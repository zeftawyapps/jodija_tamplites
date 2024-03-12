import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mvvm_module.dart';

class PageViews<T extends PageModule> extends StatelessWidget {
  PageViews({Key? key, required this.tModule, required this.builder})
      : super(key: key);
  T tModule;
  final Widget Function(
    BuildContext context,
    T value,
    Widget? child,
  )builder;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (c) => tModule,
      child: Consumer<T>(
        builder: (c, me, child) {
          me.createproviers(c);
          return builder(c, me, child);
        },
      ),
    );
  }
}
