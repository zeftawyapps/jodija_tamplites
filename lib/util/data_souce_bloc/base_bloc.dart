import 'package:JoDija_tamplites/util/data_souce_bloc/remote_base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_state.dart';

class DataSourceBloc<T> extends Cubit<DataSourceBaseState<T>> {
  DataSourceBloc([T? data])
      : super(data != null
            ? DataSourceBaseState.success(data)
            : const DataSourceBaseState.init());
  T? _data;

  T? get data => _data;

  set data(T? value) {
    _data = value;
  }

  void loadingState() {
    emit(const DataSourceBaseState.loading());
  }

  void successState([T? data]) {
    if (_data != data) {
      _data = data;
    }
    emit(DataSourceBaseState.success(data));
  }

  void failedState(ErrorStateModel error, VoidCallback callback) {
    emit(DataSourceBaseState.failure(error, callback));
  }
}
