import 'package:JoDija_tamplites/util/data_souce_bloc/base_state.dart';
import 'package:JoDija_tamplites/util/view_data_model/base_data_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// حالة إدارة مصادر البيانات الموحدة للميزات (Feature Data Source State)
///
/// يدير هذا الكلاس حالات البيانات المتزامنة داخل الـ Bloc لأي ميزة في التطبيق:
/// - [listState]: حالة جلب وتحديث قائمة العناصر بالكامل (Initial, Loading, Loaded, Error).
/// - [itemState]: حالة عنصر محدد للعمليات الفردية (Get by ID, Update, Delete).
/// - [feadState]: حالة العمليات الإضافية والتغذية الراجعة (Feedback, Submissions, Actions).
@immutable
@freezed
class FeaturDataSourceState<T extends BaseViewDataModel> {
  /// حالة القائمة الكاملة للبيانات.
  DataSourceBaseState<List<T>> listState;

  /// حالة العنصر الفردي.
  DataSourceBaseState<T> itemState;

  /// حالة العمليات التفاعلية والتغذية الراجعة.
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
