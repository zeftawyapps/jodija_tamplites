import 'package:flutter/material.dart';

import '../util/navigations/navigation_service.dart';

/// كلاس الإعدادات التأسيسية للتطبيق (Application Foundation Configuration)
///
/// يمثل هذا الكلاس النواة المشتركة لتهيئة أي تطبيق مبني على حزمة `JoDija Templates`،
/// سواء كان تطبيقاً **أحادي الحلول (Single-Solution)** مثل `matger-client-app`،
/// أو نظاماً **متعدد الحلول والوحدات (Multi-Solution)** مثل `font logic` و `matger-management-app`.
///
/// يوفر الكلاس عقداً قياسياً لتحديد:
/// - بيانات الهوية وإصدار التطبيق (`AppName`, `AppNameID`, `Version`).
/// - شاشة الانطلاق الأساسية (`launchScreen`).
/// - خريطة المسارات والتوجيه (`getRouters`).
/// - تهيئة اللغات والترجمة واتجاه الواجهة (`setAppLocal`).
abstract class DataViewConfigraion {
  String _Version = " V:  1.0.0";
  String _AppName = "Commerce App";
  String _AppNameID = "Commerce_App";

  /// إصدار التطبيق الحالي (Application Version String).
  String get Version => _Version;
  set Version(String value) => _Version = value;

  /// اسم التطبيق المعروض للمستخدم (Human-readable App Name).
  String get AppName => _AppName;
  set AppName(String value) => _AppName = value;

  /// المعرف الفريد للتطبيق (Unique Identifier for storage/API isolation).
  String get AppNameID => _AppNameID;
  set AppNameID(String value) => _AppNameID = value;

  /// الشاشة الرئيسية الافتراضية التي يفتح عليها التطبيق عند تشغيله.
  /// The default entry point screen (Widget) when the app launches.
  Widget launchScreen();

  /// تهيئة وتمرير المسارات إلى [NavigationService] تلقائياً.
  /// Initializes and passes the route map to the global [NavigationService].
  void RouteInit() {
    NavigationService().setRouters(getRouters());
  }

  /// خريطة المسارات والشاشات المقابلة لها في التطبيق.
  /// A map associating route path strings with their destination widgets.
  Map<String, Widget> getRouters();

  /// ضبط لغة التطبيق وتحديث اتجاه الواجهة (RTL / LTR).
  /// Sets the active application locale and updates layout direction.
  void setAppLocal(String localCode);
}