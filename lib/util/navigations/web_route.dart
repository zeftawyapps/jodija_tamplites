import 'dart:html' as html;

class WebRouteUrlSplitter {
  Map<String, dynamic> query = {};
  Map<String, String> pram = {};
  String url = "";
  String routeName = "";
}

class WebRoute {
  static void updateUrl(String path) {
    html.window.history.pushState(null, '', path);
  }

  static void updateUrlWithQuery(String path, Map<String, dynamic> query) {
    String queryString = Uri(queryParameters: query).query;
    html.window.history.pushState(null, '', '$path?$queryString');
  }

  static String getCurrentPath() {
    return html.window.location.pathname!;
  }
}
