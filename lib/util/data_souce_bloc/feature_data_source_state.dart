import 'package:JoDija_tamplites/util/data_souce_bloc/base_state.dart';
import 'package:JoDija_tamplites/util/view_data_model/base_data_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
@freezed
class FeaturDataSourceState<T extends BaseViewDataModel> {
  DataSourceBaseState<List<T>> listState;
  DataSourceBaseState<T> itemState;
  DataSourceBaseState<dynamic> feadState;
  FeaturDataSourceState(
      {required this.listState,
      required this.itemState,
      required this.feadState});

  FeaturDataSourceState<T> copyWith(
      {DataSourceBaseState<List<T>>? listState,
      DataSourceBaseState<T>? itemState,
      DataSourceBaseState<dynamic>? feadState}) {
    return FeaturDataSourceState<T>(
        listState: listState ?? this.listState,
        itemState: itemState ?? this.itemState,
        feadState: feadState ?? this.feadState);
  }

  factory FeaturDataSourceState.defaultState() => FeaturDataSourceState<T>(
      listState: DataSourceBaseState.init(),
      itemState: DataSourceBaseState.init(),
      feadState: DataSourceBaseState.init());
}
