import 'package:JoDija_tamplites/util/data_souce_bloc/feature_data_source_state.dart';
import 'package:JoDija_tamplites/util/view_data_model/base_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_souce_bloc/base_bloc.dart';
import '../../data_souce_bloc/base_state.dart';

/// ويدجت تقوم ببناء الواجهة بناءً على حالة (State) الـ DataSourceBloc الخاص بالبيانات.
/// A widget that builds its UI based on the state of a DataSourceBloc.
class DataSourceBlocBuilder<T> extends StatelessWidget {
  DataSourceBlocBuilder({
    super.key,
    /// حالة التحميل.
    /// Loading state builder.
    required this.loading,
    /// حالة النجاح.
    /// Success state builder.
    required this.success,
    /// حالة الفشل.
    /// Failure state builder.
    required this.failure,
    /// الـ Bloc الخاص بالبيانات.
    /// The DataSourceBloc instance.
    this.bloc,
    /// الحالة الافتراضية.
    /// Fallback state builder.
    this.onesle,
  });
  /// الـ Bloc المخصص الذي يتم الاستماع له.
  /// The custom Bloc to listen to.
  DataSourceBloc<T>? bloc;
  
  /// الواجهة التي تظهر في حالة التحميل (Loading).
  /// The widget built when the state is Loading.
  Widget Function() loading;
  
  /// الواجهة التي تظهر في حالة النجاح (Success).
  /// The widget built when the state is Success.
  Widget Function(T? data) success;
  
  /// الواجهة التي تظهر في حالة الفشل (Failure).
  /// The widget built when the state is Failure.
  Widget Function(dynamic error, Function() callback) failure;
  
  /// الواجهة التي تظهر كحالة افتراضية (orElse).
  /// The widget built as a fallback (orElse).
  Widget Function()? onesle = () => Container();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataSourceBloc<T>, DataSourceBaseState<T>>(
      bloc: bloc ?? context.read<DataSourceBloc<T>>(),
      builder: (context, state) {
        return state.maybeWhen(
          orElse: onesle ??
              () {
                return Container();
              },
          failure: (error, callback) => failure(error, callback),
          success: (data) => success(data),
          loading: loading,
        );
      },
    );
  }
}
