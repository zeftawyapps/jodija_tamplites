import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'screen_notfier.dart';

class ScreenViewsWithBloc<T extends ScreenStateBlocNotifier> extends StatelessWidget {
  ScreenViewsWithBloc({Key? key, required this.notifier, required this.builder})
      : super(key: key);
  T notifier;
  final Widget Function(
    BuildContext context,
    T value,
    Widget? child,
  )builder;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (c) => notifier,
      child: Consumer<T>(
        builder: (c, nitifire, child) {
          nitifire.createproviers(c);
          return MultiBlocProvider(providers: nitifire.blocProviders,
          child: builder(c, nitifire, child));
        },
      ),
    );
  }
}
