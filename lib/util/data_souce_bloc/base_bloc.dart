import 'package:JoDija_tamplites/util/data_souce_bloc/remote_base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_state.dart';

/// كلاس Cubit لإدارة حالات مصدر البيانات (Data Source Cubit / Bloc)
///
/// يبسط إدارة حالات جلب وتحديث البيانات عبر الانتقال المباشر بين:
/// - [DataSourceBaseState.init]: الحالة الابتدائية.
/// - [DataSourceBaseState.loading]: حالة قيد التحميل.
/// - [DataSourceBaseState.success]: حالة النجاح وجلب البيانات.
/// - [DataSourceBaseState.failure]: حالة الفشل وتوفير دالة إعادة المحاولة (Callback).
///
/// English Description:
/// Specialized Cubit state controller streamlining generic entity fetching lifecycles.
/// Transitions directly between initial, loading, success (with typed payload), and failure states.
///
/// ### مثال للاستخدام (Usage Example):
/// ```dart
/// final userBloc = DataSourceBloc<UserModel>();
/// userBloc.loadingState();
/// userBloc.successState(user);
/// ```
class DataSourceBloc<T> extends Cubit<DataSourceBaseState<T>> {
  DataSourceBloc([T? data])
      : super(data != null
            ? DataSourceBaseState.success(data)
            : const DataSourceBaseState.init());
  T? _data;

  /// البيانات المخزنة حالياً
  /// Current cached data payload.
  T? get data => _data;

  set data(T? value) {
    _data = value;
  }

  /// إصدار حالة قيد التحميل (Emits loading state)
  void loadingState() {
    emit(const DataSourceBaseState.loading());
  }

  /// إصدار حالة النجاح وتحديث البيانات (Emits success state with optional payload)
  void successState([T? data]) {
    if (_data != data) {
      _data = data;
    }
    emit(DataSourceBaseState.success(data));
  }

  /// إصدار حالة الفشل مع كائن الخطأ ودالة إعادة المحاولة (Emits failure state)
  void failedState(ErrorStateModel error, VoidCallback callback) {
    emit(DataSourceBaseState.failure(error, callback));
  }
}
