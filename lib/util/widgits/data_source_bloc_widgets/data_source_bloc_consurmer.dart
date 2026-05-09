import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_souce_bloc/base_bloc.dart';
import '../../data_souce_bloc/base_state.dart';

/// ويدجت تجمع بين البناء (Builder) والاستماع (Listener) لحالة الـ DataSourceBloc.
/// A widget that combines building and listening to the state of a DataSourceBloc.
class DataSourceBlocConsumer<T> extends StatelessWidget {
  DataSourceBlocConsumer({
    super.key,
    /// بناء الواجهة في حالة التحميل.
    /// Build UI on loading state.
    required this.loading,
    /// بناء الواجهة في حالة النجاح.
    /// Build UI on success state.
    required this.success,
    /// بناء الواجهة في حالة الفشل.
    /// Build UI on failure state.
    required this.failure,
    /// الـ Bloc المخصص للبيانات.
    /// The DataSourceBloc instance.
    this.bloc,
    /// الواجهة الافتراضية.
    /// Fallback UI.
    this.onesle,
    /// مستمع لحالة التحميل.
    /// Listener for loading state.
    this.loadingListener,
    /// مستمع لحالة النجاح.
    /// Listener for success state.
    this.successListener,
    /// مستمع لحالة الفشل.
    /// Listener for failure state.
    this.failureListener,
    /// المستمع الافتراضي.
    /// Fallback listener.
    this.onesleListener,
  });
  /// الـ Bloc المخصص الذي يتم الاستماع له.
  /// The custom Bloc to listen to.
  DataSourceBloc<T>? bloc;
  
  /// بناء الواجهة في حالة التحميل.
  /// Build UI on loading state.
  Widget Function() loading;

  /// بناء الواجهة في حالة النجاح.
  /// Build UI on success state.
  Widget Function(T ? data) success;
  
  /// بناء الواجهة في حالة الفشل.
  /// Build UI on failure state.
  Widget Function(dynamic error, Function() callback) failure;

  /// الواجهة الافتراضية.
  /// Fallback UI.
  Widget Function()? onesle;

  /// المستمع في حالة التحميل.
  /// Listener for loading state.
  Function()? loadingListener;

  /// المستمع في حالة النجاح.
  /// Listener for success state.
  Function(T? data)? successListener;
  
  /// المستمع في حالة الفشل.
  /// Listener for failure state.
  Function(dynamic error, Function() callback)? failureListener;

  /// المستمع الافتراضي.
  /// Fallback listener.
  Function()? onesleListener;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataSourceBloc<T>, DataSourceBaseState<T>>(
      bloc: bloc ?? context.read<DataSourceBloc<T>>(),
      listener: (context, state) {
        state.maybeWhen(
          orElse: onesleListener??(){},
          failure: failureListener??(dynamic error, Function() callback){},
          success: successListener??(T? data){},
          loading: loadingListener??(){},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          orElse: onesle??(){return Container();} ,
          failure: (error, callback) => failure(error, callback),
          success: (data) => success(data),
          loading: loading,
        );
      },);
  }
}
