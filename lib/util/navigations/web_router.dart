// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:js_interop';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:web/web.dart' as web;
import 'package:url_strategy/url_strategy.dart';

class WebRouter {
  // Update the URL in the browser
  static void updateUrl(String path) {
    if (kIsWeb) {
      // Use web.window.history for pushState
      web.window.history.pushState(null, '', path);
    }
  }

  // Get the current path from the URL
  static String getCurrentPath(String currentPath) {
    if (!kIsWeb) {
      return '/$currentPath'; // Default for non-web platforms
    }

    // Use web.window.location.pathname
    String? rawPath = web.window.location.pathname;
    String path = rawPath ?? '/';
    if (path == '/' || path.isEmpty) {
      return '/$currentPath';
    }
    return path;
  }

  // Add a listener for history changes (e.g., browser back/forward buttons)
  static void listenToPopState(Function(String) onPathChange) {
    if (kIsWeb) {
      // Add an event listener to the window for 'popstate'
      web.window.addEventListener(
        'popstate',
        (web.Event event) {
          String path = getCurrentPath("");
          onPathChange(path);
        }.toJS,
        // Convert Dart function to JavaScript function
      );
    }
  }

  static void createUrlStrategyInMain() {
    if (kIsWeb) {
      // Use URL Strategy to avoid page reloads
      // setPathUrlStrategy is still from flutter_web_plugins
      setPathUrlStrategy();
    }
  }

  // This method seems redundant with getCurrentPath(String currentPath)
  // and has a logical error for non-web platforms.
  // Review if you truly need it.
  static String? getCurrentPathFromUrl(String currentPath) {
    if (kIsWeb) {
      // Check kIsWeb here, not !kIsWeb
      String? rawPath = web.window.location.pathname;
      return rawPath ?? '/$currentPath';
    }
    return null; // Return null or an appropriate default for non-web
  }
}
