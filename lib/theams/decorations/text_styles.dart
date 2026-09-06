import 'package:flutter/painting.dart';

/// واجهة أنماط الخطوط والنصوص الموحدة (App Text Styles Contract)
///
/// تحدد الأنماط الطباعية لكافة مستويات النصوص في التطبيق (العناوين، العناوين الفرعية، نصوص المحتوى، ونصوص الأزرار).
///
/// English Description:
/// Typography design tokens contract establishing consistent hierarchy styles for
/// titles, subtitles, body copy, captions, and interactive buttons.
abstract class AppTextStyle {
  /// نمط العناوين الرئيسية (Main Title Text Style).
  TextStyle titleText();

  /// نمط العناوين الفرعية (Subtitle Text Style).
  TextStyle subTitleText();

  /// نمط نصوص الفقرات والمحتوى (Body Text Style).
  TextStyle bodyText();

  /// نمط النصوص التوضيحية الدقيقة (Caption Text Style).
  TextStyle captionText();

  /// نمط نصوص الأزرار (Button Label Text Style).
  TextStyle buttonText();
}