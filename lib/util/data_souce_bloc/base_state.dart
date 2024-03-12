import 'package:JoDija_view/util/data_souce_bloc/remote_base_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
  part 'base_state.freezed.dart';

@immutable
@freezed
class DataSourceState<T> with _$BaseState<T>{
  const factory DataSourceState.init() = _Init;
  const factory DataSourceState.loading() = _Loading;
  const factory DataSourceState.success([T? model]) = _Success<T>;
  const factory DataSourceState.failure(ErrorStateModel error, VoidCallback callback) = _Failure;
}