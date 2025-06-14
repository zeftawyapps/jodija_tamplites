// ignore_for_file: avoid_web_libraries_in_flutter
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html'
    as html; // Using with ignore directive as it's the most reliable solution
import 'package:url_strategy/url_strategy.dart';

class WebRouter {
  // تحديث عنوان URL في المتصفح
  static void updateUrl(String path) {
    if (kIsWeb) {
      html.window.history.pushState(null, '', path);
    }
  }

  // الحصول على المسار الحالي من URL
  static String getCurrentPath(String currentPath) {
    if (!kIsWeb) {
      return '/$currentPath'; // Default for non-web platforms
    }

    String? rawPath = html.window.location.pathname;
    String path = rawPath ?? '/';
    if (path == '/' || path.isEmpty) {
      return '/$currentPath';
    }
    return path;
  } // إضافة مستمع للتغييرات في التاريخ (للاستجابة لزر الرجوع والتقدم في المتصفح)

  static void listenToPopState(Function(String) onPathChange) {
    if (kIsWeb) {
      html.window.onPopState.listen((event) {
        String path = getCurrentPath("");
        onPathChange(path);
      });
    }
  }

  static void createUrlStrategyInMain() {
    if (kIsWeb) {
      // استخدام URL Strategy لتجنب الحاجة إلى إعادة تحميل الصفحة
      setPathUrlStrategy();
    }
  }
}
