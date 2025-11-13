import 'dart:ui';

import 'package:JoDija_tamplites/util/localization/loaclized_init.dart';
import 'package:JoDija_tamplites/util/localization/loclization/app_localizations.dart';
 
class LocalizationInit {
Map<String, AppLocalizationsInit>? localizedValues;

LocalizationInit(this.localizedValues);  



   void setAppLocal(String localCode) {
    LocalizationConfig localizationConfig =
    LocalizationConfig(localizedValues: localizedValues);
    localizationConfig.setLocale(Locale(localCode));
    Translation().getlocal();

  }
}