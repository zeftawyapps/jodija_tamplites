import 'package:JoDija_view/util/data_souce_bloc/remote_base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_state.dart';

class DataSourceBloc<T> extends Cubit<DataSourceState<T>> {
  DataSourceBloc([T? data]) : super(data != null? DataSourceState.success(data): const DataSourceState.init());
  T? _data;

  T? get data => _data;

  set data(T? value){
    _data = value;
  }

  void loadingState(){
    emit(const DataSourceState.loading());
  }

  void successState([T? data]){
    if(_data != data){
      _data = data;
    }
    emit(DataSourceState.success(data));

  }

  void failedState(ErrorStateModel error, VoidCallback callback){
    emit(DataSourceState.failure(error, callback));
  }

}