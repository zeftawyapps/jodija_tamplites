import 'package:flutter/material.dart';

/// نظام الألوان الأساسي للتطبيق (Design System Color Palette)
///
/// يحدد هذا الكلاس التجريدي الألوان القياسية المستخدمة في الحزمة ولوحات التحكم والتطبيقات.
/// يمكن تخصيص هذه القيم أو وراثة الكلاس لإنشاء ثيمات خاصة (Custom Themes) كالثيم الأخضر الزيتي أو الداكن.
abstract class AppColors {
  /// اللون الرئيسي للتطبيق (Primary Brand Color).
  Color primary = Color(0xE4BB0404);

  /// اللون الثانوي (Secondary Color).
  Color secondary = Color(0xFF564D4D);

  /// لون التمييز والتباين (Accent Color).
  Color accent = Color(0xFFF1EAE5);

  /// لون خلفية الشاشات العامة (Background Color).
  Color background = Color(0xD3DFE0ED);

  // ألوان النصوص والخطوط (Typography Colors)
  /// لون العناوين الرئيسية (Main Headings).
  Color titleText = Color(0xFF010315);

  /// لون العناوين الفرعية (Subtitles).
  Color subTitleText = Color(0xFF2F2F32);

  /// لون نصوص الفقرات والمحتوى (Body Text).
  Color bodyText = Color(0xFF5C5959);

  /// لون النصوص التوضيحية الصغيرة (Captions).
  Color captionText = Color(0xFF3F3F40);

  /// لون النصوص داخل الأزرار (Button Labels).
  Color buttonText = Color(0xFFE9EBF2);

  // ألوان عناصر التحكم والودجات (Controls & Widgets Colors)
  /// لون خلفية الأزرار التفاعلية (Button Background).
  Color buttonColor = Color(0xFF2531D3);

  /// لون الأيقونات (Icons Color).
  Color iconColor = Color(0xE4BB0404);

  /// لون الخطوط الفاصلة (Dividers & Borders).
  Color dividerColor = Color(0xFF1A1A2B);
}