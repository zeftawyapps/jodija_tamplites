import 'package:JoDija_tamplites/util/app_settings/settings_model.dart';
import 'package:JoDija_tamplites/util/main-screen/screen-type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 
class SettingProvider extends ChangeNotifier {
  BaseSetting? setting = BaseSetting(
      pageState: 0,
      language: "ar",
      theme: ThemeMode.system,
      screenType: ScreenType.web);

  SettingProvider({this.setting}) {
    if (setting == null) {
      BaseSetting(
          pageState: 0,
          language: "ar",
          theme: ThemeMode.system,
          screenType: ScreenType.web);
    }
  }

  void change(BaseSetting value) {
    setting = value;
    notifyListeners();
  }
}
