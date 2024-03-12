import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_souce_bloc/base_bloc.dart';
import '../../data_souce_bloc/base_state.dart';

class DataSourceBlocConsumer<T> extends StatelessWidget {
  DataSourceBlocConsumer({
    super.key,
    required this.loading,
    required this.success,
    required this.failure,
    required this.bloc,
      this.onesle,
      this.loadingListener,
      this.successListener,
      this.failureListener,
      this.onesleListener,

  });
  DataSourceBloc<T> bloc;
  Widget Function() loading;

  Widget Function(T ? data) success;
  Widget Function(dynamic error, Function() callback) failure;

  Widget Function()? onesle;

    Function()? loadingListener;

    Function(T? data)? successListener;
    Function(dynamic error, Function() callback)? failureListener;

    Function()? onesleListener;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataSourceBloc<T>, DataSourceState<T>>(
      bloc: bloc,
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
