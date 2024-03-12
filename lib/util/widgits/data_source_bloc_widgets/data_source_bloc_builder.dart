import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_souce_bloc/base_bloc.dart';
import '../../data_souce_bloc/base_state.dart';

class DataSourceBlocBuilder<T> extends StatelessWidget {
  DataSourceBlocBuilder({
    super.key,
    required this.loading,
    required this.success,
    required this.failure,
    required this.bloc,
      this.onesle,
  });
  DataSourceBloc<T> bloc;
  Widget Function() loading;
  Widget Function(T? data) success;
  Widget Function(dynamic error, Function() callback) failure;
  Widget Function()? onesle=()=>Container();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataSourceBloc<T>, DataSourceState<T>>(
      bloc: bloc,
      builder: (context, state) {
        return state.maybeWhen(
          orElse: onesle??(){return Container();},
          failure: (error, callback) => failure(error, callback),
          success: (data) => success(data),
          loading: loading,
        );
      },
    );
  }
}
