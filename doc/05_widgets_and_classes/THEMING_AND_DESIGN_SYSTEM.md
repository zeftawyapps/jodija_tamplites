# 🎨 Theming, Colors & Design System (AppColors & DashboardThemes)

---

### 🌐 Language / اللغة
[🇸🇦 **النسخة العربية (THEMING_AND_DESIGN_SYSTEM.ar.md)**](THEMING_AND_DESIGN_SYSTEM.ar.md) • [📖 **Tutorial (HOW_TO_USE.md)**](../HOW_TO_USE.md) • [📚 **Documentation Portal (README.md)**](../README.md)

---

## 1. Overview
`JoDija Templates` provides a centralized design system guaranteeing visual consistency across mobile viewports, responsive web interfaces, and administrative dashboards:
- **`AppColors`**: Primary, secondary, accent, surface, and typography color tokens.
- **`DashboardThemes`**: Specialized theme palettes for enterprise control panels (such as the signature **Olive Theme `0xFF556B2F`**).
- **Google Fonts Integration**: Pre-configured support for popular Arabic typography (Cairo, Tajawal, Almarai).

---

## 2. Default Palette Tokens (`AppColors`)

| Token | Property | Default Value | Role |
| :--- | :--- | :--- | :--- |
| `primary` | Primary | `Color(0xE4BB0404)` | Primary call-to-actions, brand identity. |
| `secondary` | Secondary | `Color(0xFF564D4D)` | Supporting UI borders, disabled states. |
| `accent` | Accent | `Color(0xFFF1EAE5)` | Badges, highlights, active selections. |
| `background` | Canvas | `Color(0xD3DFE0ED)` | Scaffold canvas and layout containers. |
| `titleText` | Headings | `Color(0xFF010315)` | Primary titles and section headings. |
| `bodyText` | Body Copy | `Color(0xFF5C5959)` | Body paragraphs and descriptive subtitles. |

---

## 3. Full Runnable Example: Signature Olive Enterprise Theme

```dart
import 'package:flutter/material.dart';
import 'package:JoDija_tamplites/JoDija_tamplites.dart';

class CustomOliveTheme {
  static const Color primaryOlive = Color(0xFF556B2F); // Deep Enterprise Olive
  static const Color accentAmber = Color(0xFFFFA500);  // Warm Accent Amber
  static const Color lightBg = Color(0xFFF8F9FA);      // Crisp clean background

  static ThemeData createTheme() {
    return ThemeData(
      primaryColor: primaryOlive,
      scaffoldBackgroundColor: lightBg,
      fontFamily: 'Cairo',
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
