import 'package:flutter/material.dart';

/// واجهة الثيمات العامة للتطبيق (General App Themes Contract)
///
/// تتيح إنشاء ثيم فاتح (Light) وثيم داكن (Dark) متناسقين لكامل شاشات التطبيق.
///
/// English Description:
/// Base contract for defining synchronized Light and Dark Material application themes.
abstract class AppThemes {
  /// بناء الثيم الفاتح للتطبيق (Builds light theme).
  ThemeData light();

  /// بناء الثيم الداكن للتطبيق (Builds dark theme).
  ThemeData dark();
}

/// واجهة ثيمات لوحة التحكم والشاشات الإدارية (Dashboard & Admin Shell Themes)
///
/// توفر تخصيصاً خاصاً للوحات التحكم الإدارية مثل `matger-management-app`
/// بما يتضمن ألوان القائمة الجانبية (Sidebar) وشريط الأدوات العلوي والجداول.
///
/// English Description:
/// Dedicated theme contract tailored for administration dashboards and enterprise shells,
/// configuring sidebar backgrounds, app bar tokens, and data grid styling.
abstract class DashboardThemes {
  /// الثيم الفاتح الخاص بلوحة التحكم (Builds admin dashboard light theme).
  ThemeData light();

  /// الثيم الداكن الخاص بلوحة التحكم (Builds admin dashboard dark theme).
  ThemeData dark();
}

/// واجهة الثيمات الثابتة للتطبيقات ذات الهوية المحددة (Fixed Brand Themes)
///
/// English Description:
/// Fixed brand theme contract for single-brand focused deployments.
abstract class fixThemes {
  /// الثيم الفاتح الثابت (Fixed light theme).
  ThemeData light();
  
  /// الثيم الداكن الثابت (Fixed dark theme).
  ThemeData dark();
}