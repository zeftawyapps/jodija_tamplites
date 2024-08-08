import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

class AppLocalizationsInit {
// add sengle tone
//   static final AppLocalizationsInit _singleton = AppLocalizationsInit._internal();
//   factory AppLocalizationsInit( ) {
//
//     return _singleton;
//   }
//   AppLocalizationsInit._internal();



    Locale local = LocalizationConfig().locale;
  // static   List<LocalizationsDelegate<dynamic>> localizationsDelegates =
  // <LocalizationsDelegate<dynamic>>[
  //    delegate,
  //   GlobalMaterialLocalizations.delegate,
  //       GlobalWidgetsLocalizations.delegate,
  //   GlobalCupertinoLocalizations.delegate,
  // ];
  List<LocalizationsDelegate<dynamic>> get localizationsDelegates =>
      LocalizationConfig().locliztionDelegates( LocalizationConfig().locale);



  /// A list of this localizations delegate's supported locales.
    List<Locale> supportedLocales = LocalizationConfig().supportedLocales;
}

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
