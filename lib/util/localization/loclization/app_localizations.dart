import 'package:JoDija_tamplites/util/localization/loaclized_init.dart';
import 'package:flutter/cupertino.dart';

class Translation {
  static final Translation _singleton = Translation._internal();
  factory Translation() {
    return _singleton;
  }


AppLocal get appLocal => translate();
  Translation._internal();

  Map<String, AppLocal> transelation = {};
  AppLocal translate() {
    final code = LocalizationConfig().locale.languageCode;
    return transelation[code] ??
        (transelation.isNotEmpty ? transelation.values.first : DefaultAppLocal());
  }

  AppLocal translateOf(BuildContext context) {
    return AppLocal.of(context);
  }

  void getlocal() {
    var localval = LocalizationConfig().localizedValues;
    localval.forEach((key, value) {
      if (value is AppLocal) {
        transelation[key] = value;
      } else {
        transelation[key] = DefaultAppLocal();
      }
    });
  }
}

abstract class AppLocal extends AppLocalizationsInit {
  static AppLocal of(BuildContext context) {
    return Localizations.of<AppLocal>(context, AppLocal)!;
  }

  AppLocal();
  Map<String, String> get values;

  String? get(String key) => values[key];
  String operator [](String key) => values[key] ?? key;
}

class DefaultAppLocal extends AppLocal {
  final Map<String, String> _values;
  DefaultAppLocal([this._values = const {}]);

  @override
  Map<String, String> get values => _values;
}
