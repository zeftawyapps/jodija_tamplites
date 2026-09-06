/// واجهة الأبعاد والقياسات الموحدة في التطبيق (App Dimensions Contract)
///
/// تحدد الثوابت القياسية لأنصاف أقطار الحواف (Border Radius)، الهوامش (Padding)،
/// أحجام الخطوط في الويب والجوال، وأحجام الأيقونات.
///
/// English Description:
/// Layout dimension contract defining responsive spatial tokens including border radius,
/// padding margins, responsive font sizes for mobile/web, and icon scaling.
abstract class AppDimensions {
  /// نصف قطر استدارة الحواف (Border Radius).
  double borderRadius();

  /// الهامش الداخلي الافتراضي (Standard Padding).
  double padding();

  /// حجم الخط الأساسي في بيئة الويب (Web Typography Size).
  int fontSizeInWeb();

  /// حجم الخط الأساسي في بيئة الجوال (Mobile Typography Size).
  int fontSizeInMobile();

  /// حجم الأيقونة الافتراضي (Standard Icon Size).
  double iconSize();

  /// حجم الأيقونة الصغير (Small Icon Size).
  double iconSizeSmall();

  /// حجم الأيقونة الكبير (Large Icon Size).
  double iconSizeLarge();
}