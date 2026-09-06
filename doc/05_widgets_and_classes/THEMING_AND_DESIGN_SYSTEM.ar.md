# 🎨 نظام الألوان والثيمات (AppColors & DashboardThemes)

---

### 🌐 اللغة / Language
[🇺🇸 **English Version (THEMING_AND_DESIGN_SYSTEM.md)**](THEMING_AND_DESIGN_SYSTEM.md) • [📖 **دليل الاستخدام (HOW_TO_USE.ar.md)**](../HOW_TO_USE.ar.md) • [📚 **بوابة التوثيق (README.ar.md)**](../README.ar.md)

---

## 1. نظرة عامة
توفر الحزمة نظاماً تصميمياً موحداً (Design System) يضمن تناسق الألوان والخطوط والأبعاد عبر كافة شاشات ولوحات التحكم في التطبيق:
- **`AppColors`**: تعريف درجات الألوان الأساسية، الثانوية، التباين، وخلفيات الشاشات والنصوص.
- **`DashboardThemes`**: تخصيص ألوان لوحات التحكم الإدارية مثل **الثيم الزيتي القياسي (`0xFF556B2F`)**.
- **دعم خطوط Google:** تهيئة الخطوط العربية الشائعة مثل Cairo و Tajawal و Almarai.

---

## 2. لوحة الألوان الأساسية لكلاس `AppColors`

| اللون | الخاصية | القيمة الافتراضية | الاستخدام |
| :--- | :--- | :--- | :--- |
| `primary` | الأساسي | `Color(0xE4BB0404)` | الأزرار الرئيسية وعناصر الهوية. |
| `secondary` | الثانوي | `Color(0xFF564D4D)` | العناصر المساندة والحدود. |
| `accent` | التباين | `Color(0xFFF1EAE5)` | شارات التمييز والعناصر الملفتة. |
| `background` | الخلفية | `Color(0xD3DFE0ED)` | خلفيات الشاشات والحاويات. |
| `titleText` | نصوص العناوين | `Color(0xFF010315)` | العناوين الرئيسية الكبيرة. |
| `bodyText` | نصوص المحتوى | `Color(0xFF5C5959)` | الفقرات والنصوص التوضيحية. |

---

## 3. كود تطبيقي لتخصيص الثيم الزيتي القياسي (Olive Enterprise Theme)

```dart
import 'package:flutter/material.dart';
import 'package:JoDija_tamplites/JoDija_tamplites.dart';

class CustomOliveTheme {
  static const Color primaryOlive = Color(0xFF556B2F); // زيتي داكن
  static const Color accentAmber = Color(0xFFFFA500);  // برتقالي دافئ للتمييز
  static const Color lightBg = Color(0xFFF8F9FA);      // خلفية نقية

  static ThemeData createTheme() {
    return ThemeData(
      primaryColor: primaryOlive,
      scaffoldBackgroundColor: lightBg,
      fontFamily: 'Cairo', // خط عربي مميز
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryOlive,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryOlive,
        primary: primaryOlive,
        secondary: accentAmber,
      ),
    );
  }
}
```
