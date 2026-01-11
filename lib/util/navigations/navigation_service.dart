import 'package:JoDija_tamplites/util/navigations/web_route.dart';
import 'package:flutter/material.dart';

import 'INavigation_service.dart';
import 'animation_types.dart';
import 'genrating_routes.dart';

/// [NavigationService] = [NavigationService]
class NavigationService extends INavigationService {
  static final NavigationService _instance = NavigationService._init();

  NavigationService._init();

  factory NavigationService() {
    return _instance;
  }

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext get context => navigatorKey.currentContext!;

  final removeAllOldRoutes = (Route<dynamic> route) => false;
  NavigationAnimationType animationType = NavigationAnimationType.none;
  @override
  Future<Object?> navigateToPage({required String path, Object? data}) async {
    await navigatorKey.currentState!.pushNamed(path, arguments: data);
  }

  @override
  Future<void> navigateToPageWithUrl(
      {required String path,
      Map<String, String>? pram,
      Map<String, dynamic>? query}) async {
    String name = path;
    WebRouteUrlSplitter data = WebRouteUrlSplitter();
    if (pram != null) {
      path = path + "/:";
      pram.forEach((key, value) {
        path = path + "$value/";
      });
      // remove last /
      path = path.substring(0, path.length - 1);
      data.pram = pram;
    }
    if (query != null) {
      path = path + "?";
      query.forEach((key, value) {
        path = path + "$key=$value&";
      });
      // remove last &
      path = path.substring(0, path.length - 1);
      data.query = query;
    }
    data.url = path;
    await navigatorKey.currentState!.pushNamed(name, arguments: data);
  }

  @override
  Future<void> navigateToPageAndClear({required String path}) async {
    await navigatorKey.currentState!
        .pushNamedAndRemoveUntil(path, (Route<dynamic> route) => false);
  }

  @override
  Future<void> replacementPage({required Widget path, Object? data}) async {
    await navigatorKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (context) => path));
  }

  Future<void> replacementToPage({required String path, Object? data}) async {
    await navigatorKey.currentState!
        .pushReplacementNamed(path, arguments: data);
  }

  @override
  Future<void> navigateToPageClear({required String path, Object? data}) async {
    await navigatorKey.currentState!
        .pushNamedAndRemoveUntil(path, removeAllOldRoutes, arguments: data);
  }

  @override
  void goBack({Object? data}) {
    unFocus();
    Navigator.pop(context, data);
  }

  @override
  void unFocus() {
    // FocusScope.of(context).unfocus();
    // https://github.com/flutter/flutter/issues/47128#issuecomment-627551073
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Map<String, Widget> _router = {};
  void setRouters(Map<String, Widget> routs) {
    _router = routs;
  }

  Object? argumants;

  @override
  Route<dynamic> generateRoute(RouteSettings settings,
      {NavigationAnimationType animatiionType = NavigationAnimationType.none}) {
    // Getting arguments passed in while calling Navigator.pushNamed
    String url = settings.name!;

    if (settings.arguments != null) {
      argumants = settings.arguments;
      if (argumants is WebRouteUrlSplitter) {
        var data = argumants as WebRouteUrlSplitter;
        url = data.url;
      } else if (argumants is String) {
        argumants = argumants;
      }
    }

    argumants = settings.arguments;
    String routeName = settings.name ?? "";
// if _router is exist the settings.name is the route name
    if (!_router.containsKey(routeName)) {
      var data = _getRouteName(routeName);
      url = data.url;
      argumants = data;
      routeName = data.routeName;
    }

    return GenerateAnimatedPageRoute(
        screen: _router[routeName] ?? getWidgetError(),
        routeName: url,
        data: argumants,
        animationType: NavigationAnimationType.slide);
  }

  _getRouteName(String url) {
    WebRouteUrlSplitter data = WebRouteUrlSplitter();
    var routeName = url;
    String namePath, pramQuery, pramPath, queryPath;
    if (url.contains(":")) {
      var split = url.split(":");
      namePath = split[0];
      pramQuery = split[1];
      if (pramQuery.contains("?")) {
        var split2 = pramQuery.split("?");
        pramPath = split2[0];
        // split pram
        var split3 = pramPath.split("/");
        Map<String, String> pram = {};
        for (int i = 0; i < split3.length; i++) {
          pram["p$i"] = split3[i];
        }
        queryPath = split2[1];
        // split query
        var split4 = queryPath.split("&");
        Map<String, dynamic> query = {};
        for (var item in split4) {
          var split5 = item.split("=");
          query[split5[0]] = split5[1];
        }
        data.pram = pram;
        data.query = query;
        data.url = url;
        data.routeName = namePath.substring(0, namePath.length - 1);
      } else {}
      return data;
    }

    data.url = url;
    // remove last /
    data.routeName = routeName.substring(0, routeName.length - 1);
    return data;
  }

  Widget getWidgetError() {
    return Scaffold(
      body: Center(
        child: Text('404'),
      ),
    );
  }
}
