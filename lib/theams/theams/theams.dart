import 'package:flutter/material.dart';

/// واجهة الثيمات العامة للتطبيق (General App Themes Contract)
///
/// تتيح إنشاء ثيم فاتح (Light) وثيم داكن (Dark) متناسقين لكامل شاشات التطبيق.
abstract class AppThemes {
  /// بناء الثيم الفاتح للتطبيق.
  ThemeData light();

  /// بناء الثيم الداكن للتطبيق.
  ThemeData dark();
}

/// واجهة ثيمات لوحة التحكم والشاشات الإدارية (Dashboard & Admin Shell Themes)
///
/// توفر تخصيصاً خاصاً للوحات التحكم الإدارية مثل `matger-management-app`
/// بما يتضمن ألوان القائمة الجانبية (Sidebar) وشريط الأدوات العلوي والجداول.
abstract class DashboardThemes {
  /// الثيم الفاتح الخاص بلوحة التحكم.
  ThemeData light();

  /// الثيم الداكن الخاص بلوحة التحكم.
  ThemeData dark();
}

/// واجهة الثيمات الثابتة للتطبيقات ذات الهوية المحددة (Fixed Brand Themes).
abstract class fixThemes {
  ThemeData light();
  ThemeData dark();
}