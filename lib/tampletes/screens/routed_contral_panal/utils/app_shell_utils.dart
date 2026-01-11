import 'package:flutter/material.dart';

/// Utility functions for AdaptiveAppShell
class AppShellUtils {
  /// Calculate layout direction from language code
  static TextDirection getLayoutDirection(String languageCode) {
    // RTL languages
    const rtlLanguages = ['ar', 'he', 'fa', 'ur', 'yi', 'ji', 'iw', 'ku'];
    return rtlLanguages.contains(languageCode) 
        ? TextDirection.rtl 
        : TextDirection.ltr;
  }

  /// Check if language is RTL
  static bool isRTL(String languageCode) {
    return getLayoutDirection(languageCode) == TextDirection.rtl;
  }
}
