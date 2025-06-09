import 'package:JoDija_tamplites/util/main-screen/screen-type.dart';
import 'package:flutter/material.dart';

class BaseSetting extends IBaseSetting {
  int? pageState;
  String? language;
  ThemeMode? theme;
  ScreenType? screenType;
  // add sengle tone
  static final BaseSetting _singleton = BaseSetting._internal();
  factory BaseSetting(
      {int pageState = 0,
      String language = 'en',
      ThemeMode theme = ThemeMode.system,
      screenType = ScreenType.web}) {
    _singleton.pageState = pageState;
    _singleton.language = language;
    _singleton.theme = theme;
    _singleton.screenType = screenType;

    return _singleton;
  }
  BaseSetting._internal();
  @override
  String toString() {
    return 'BaseSetting{pageState: $pageState, language: $language, theme: $theme}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseSetting &&
          runtimeType == other.runtimeType &&
          pageState == other.pageState &&
          language == other.language &&
          theme == other.theme &&
          ScreenType == other.screenType;

  @override
  int get hashCode => pageState.hashCode ^ language.hashCode ^ theme.hashCode;
}

abstract class IBaseSetting {
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
