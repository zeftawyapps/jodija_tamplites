import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen_notfier.dart';

class ScreenViews<T extends ScreenStateNotifier> extends StatelessWidget {
  ScreenViews({Key? key, required this.notifier, required this.builder})
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
        builder: (c, me, child) {
          me.createproviers(c);
          return builder(c, me, child);
        },
      ),
    );
  }
}
