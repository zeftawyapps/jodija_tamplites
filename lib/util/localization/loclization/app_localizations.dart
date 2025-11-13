import 'package:JoDija_tamplites/util/localization/loaclized_init.dart';
import 'package:flutter/cupertino.dart';

class Translation {
  static final Translation _singleton = Translation._internal();
  factory Translation() {
    return _singleton;
  }


AppLocal get appLocal => translate();
  Translation._internal() {

  }

  Map<String, AppLocal> transelation = {};
  AppLocal translate() {
    return transelation[LocalizationConfig().locale.languageCode]!;
  }

  AppLocal translateOf(BuildContext context) {
    return AppLocal.of(context);
  }

  void getlocal() {

    var localval = LocalizationConfig().localizedValues;
    localval.forEach((key, value) {
      transelation[key] = value as AppLocal;
    });
  }
}

abstract class AppLocal extends AppLocalizationsInit {
  static AppLocal of(BuildContext context) {
    return Localizations.of<AppLocal>(context, AppLocal)!;
  }

  AppLocal();
  Map<String, String> get values;

}
