import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

class AppLocalizationsInit {

  static const LocalizationsDelegate<AppLocalizationsInit> delegate =
  _AppLocalizationsDelegate();


  static Locale local = LocalizationConfig().locale;
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
  <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static List<Locale> supportedLocales = LocalizationConfig().supportedLocales;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizationsInit> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizationsInit> load(Locale locale) {
    return SynchronousFuture<AppLocalizationsInit>(
        _lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      LocalizationConfig().localcode.contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizationsInit _lookupAppLocalizations(Locale locale) {
  // use Loacalconfig class

  LocalizationConfig config = LocalizationConfig();
  return config.localizedValues![locale.languageCode]!;
}

class LocalizationConfig {
  static final LocalizationConfig _singleton = LocalizationConfig._internal();
  factory LocalizationConfig({Map<String, AppLocalizationsInit>? localizedValues}) {
    if (localizedValues != null) _singleton.localizedValues = localizedValues;
    return _singleton;
  }
  LocalizationConfig._internal();
  Map<String, AppLocalizationsInit> localizedValues = {};
  List<Locale> _localList = [];
  // add a variable to hold the current locale
  Locale _locale = Locale('en');
  // add a getter to get the current locale
  Locale get locale => _locale;
  // add a method to set the locale
  void setLocale(Locale locale) {
    _locale = locale;
  }

  List<String> _keys = [];
  get localcode => _keys;
  // add a method to get the supported locales
  List<Locale> get supportedLocales {
    localizedValues!.forEach((key, value) {
      _localList.add(Locale(key));
    });
    _keys = localizedValues!.keys.toList();
    return _localList;
  }
}
