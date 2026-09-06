import 'package:flutter/material.dart';

/// واجهة زخارف وتنسيقات الودجات الموحدة (App Decorations Contract)
///
/// تحدد الأنماط الجمالية الموحدة للأزرار، البطاقات، عناصر القوائم، وحقول الإدخال.
///
/// English Description:
/// Design system decoration contract establishing reusable [BoxDecoration] and [InputDecoration]
/// configurations for buttons, cards, list tiles, and input form fields.
abstract class AppDecorations {
  /// زخرفة وتنسيق الأزرار (Button Decoration).
  BoxDecoration botton();

  /// زخرفة عناصر القوائم (List Item Tile Decoration).
  BoxDecoration listItems();

  /// زخرفة وتصميم البطاقات (Card Container Decoration).
  BoxDecoration card();

  /// تنسيق حقول الإدخال والحدود (Form Input Field Decoration).
  InputDecoration input();

  /// زخرفة الحاويات العامة (General Container Decoration).
  BoxDecoration container();
}
