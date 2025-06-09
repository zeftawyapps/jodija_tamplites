import 'package:JoDija_tamplites/util/data_souce_bloc/remote_base_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'base_state.freezed.dart';

@immutable
@freezed
class DataSourceBaseState<T> with _$BaseState<T> {
  const factory DataSourceBaseState.init() = _Init;
  const factory DataSourceBaseState.loading() = _Loading;
  const factory DataSourceBaseState.success([T? model]) = _Success<T>;
  const factory DataSourceBaseState.failure(
      ErrorStateModel error, VoidCallback callback) = _Failure;
}
