import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

/// الفئة الأساسية لتهيئة وإدارة الترجمة واللغات (Localization Foundation Initializer)
///
/// توفر الكلمات والمصطلحات المترجمة ودعم اتجاه النص (RTL للغة العربية و LTR للغات اللاتينية).
class AppLocalizationsInit {
  Locale local = LocalizationConfig().locale;


  /// قائمة مفوضي الترجمة بما يشمل ترجمات Material و Widgets و Cupertino.
  List<LocalizationsDelegate<dynamic>> get localizationsDelegates =>
      LocalizationConfig().locliztionDelegates(LocalizationConfig().locale);

  /// قائمة اللغات المدعومة حالياً داخل التطبيق.
  List<Locale> supportedLocales = LocalizationConfig().supportedLocales;
}

/// مفوض تحميل الترجمات في بيئة فلاتر (Flutter Localization Delegate)
class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizationsInit> {
  const AppLocalizationsDelegate();

  @override
  Future<AppLocalizationsInit> load(Locale locale) {
    return SynchronousFuture<AppLocalizationsInit>(
        _lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      LocalizationConfig().localcode.contains(locale.languageCode);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

AppLocalizationsInit _lookupAppLocalizations(Locale locale) {
  LocalizationConfig config = LocalizationConfig();
  return config.localizedValues![locale.languageCode]!;
}

/// مدير إعدادات الترجمة الموحد بنمط Singleton
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

  List<LocalizationsDelegate<dynamic>> locliztionDelegates(Locale local ){
    LocalizationsDelegate<AppLocalizationsInit> delegate = AppLocalizationsDelegate();
   delegate.load(locale);

    return  [
      delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];;
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
