import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_souce_bloc/base_bloc.dart';
import '../../data_souce_bloc/base_state.dart';
/// ويدجت للاستماع (Listener) لتغيرات حالة (State) الـ DataSourceBloc وتُنفذ دوال استدعاء (Callbacks).
/// A widget that listens to the state changes of a DataSourceBloc and executes callbacks.
class DataSourceBlocListener<T> extends StatelessWidget {
    DataSourceBlocListener({super.key ,
      /// العنصر الفرعي (Widget) الذي يتم تغليفه.
      /// The child widget.
      required this.child,
      /// المستمع لحالة التحميل.
      /// Loading state listener.
      this.loading,
      /// المستمع لحالة النجاح.
      /// Success state listener.
      required this.success,
      /// المستمع لحالة الفشل.
      /// Failure state listener.
      required this.failure,
      /// الـ Bloc المخصص للبيانات.
      /// The DataSourceBloc instance.
      this.bloc,
      /// المستمع الافتراضي للحالات الأخرى.
      /// Fallback listener for other states.
      this.onesle,
    });
  /// دالة تُستدعى في حالة التحميل.
  /// Callback triggered on loading state.
  Function()? loading ;
  
  /// العنصر الفرعي (Widget).
  /// The child widget being wrapped.
  Widget child;
  
  /// دالة تُستدعى في حالة النجاح.
  /// Callback triggered on success state.
  Function(T? data ) success;
  
  /// دالة تُستدعى في حالة الفشل.
  /// Callback triggered on failure state.
  Function(dynamic error, Function() callback) failure;
  
  /// الـ Bloc المخصص للبيانات.
  /// The DataSourceBloc instance.
  DataSourceBloc<T>? bloc;
  
  /// دالة تُستدعى كحالة افتراضية.
  /// Fallback callback.
  Function()? onesle;

   @override
   Widget build(BuildContext context) {
     return  BlocListener
     <DataSourceBloc<T>, DataSourceBaseState<T>>(
       bloc: bloc,
       listener: (context, state) {
          state.maybeWhen(
            orElse:   onesle??(){},
            failure: failure,
            success: success,
            loading:  loading??(){},
          );
         },

       child: child,
     );

   }
 }
