import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_souce_bloc/base_bloc.dart';
import '../../data_souce_bloc/base_state.dart';
 class DataSourceBlocListener<T> extends StatelessWidget {
     DataSourceBlocListener({super.key ,
       required this.child,
         this.loading,
       required this.success,
       required this.failure,
       required this.bloc,
          this.onesle,

     });
 Function()? loading ;
 Widget child;
 Function(T? data ) success;
  Function(dynamic error, Function() callback) failure;
  DataSourceBloc<T> bloc;
  Function()? onesle;

   @override
   Widget build(BuildContext context) {
     return  BlocListener
     <DataSourceBloc<T>, DataSourceState<T>>(
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
