 import 'package:JoDija_view/util/data_souce_bloc/feature_data_source_state.dart';
import 'package:JoDija_view/util/view_data_model/base_data_model.dart';
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
      this.bloc,
      this.onesle,
  });
  DataSourceBloc<T>? bloc;
  Widget Function() loading;
  Widget Function(T? data) success;
  Widget Function(dynamic error, Function() callback) failure;
  Widget Function()? onesle=()=>Container();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataSourceBloc<T>, DataSourceBaseState<T>>(
      bloc: bloc??context.read<DataSourceBloc<T>>(),
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




