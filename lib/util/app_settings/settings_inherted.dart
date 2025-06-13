import 'package:JoDija_tamplites/util/app_settings/settings_model.dart';
import 'package:JoDija_tamplites/util/main-screen/screen-type.dart';
import 'package:flutter/material.dart';

class SettingChanger extends StatefulWidget {
  final Widget child;

  const SettingChanger({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<SettingChanger> createState() => _SettingChangerState();
}

class _SettingChangerState extends State<SettingChanger> {
  var state = BaseSetting();
// add call backe function type BaseState

  void change(BaseSetting NewStateChange) {
    setState(() {
      state = NewStateChange;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SettingChangeLestner(
      state: state,
      stateWidget: this,
      child: Builder(builder: (context) {
        state.screenType =
            ScreenTypeExtension.fromMediaQueryData(MediaQuery.of(context));
        return widget.child;
      }),
    );
  }
}

class SettingChangeLestner extends InheritedWidget {
  final BaseSetting state;
  final _SettingChangerState stateWidget;

  const SettingChangeLestner({
    Key? key,
    required super.child,
    required this.state,
    required this.stateWidget,
  }) : super(
          key: key,
        );

  static _SettingChangerState of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<SettingChangeLestner>()!
      .stateWidget;

  @override
  bool updateShouldNotify(covariant SettingChangeLestner oldWidget) {
    state;
    return oldWidget.state == state;
  }
}
