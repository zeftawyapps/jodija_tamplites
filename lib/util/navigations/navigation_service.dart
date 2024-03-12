 import 'package:flutter/material.dart';
import 'INavigation_service.dart';
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

  @override
  Future<Object?> navigateToPage({required String path, Object? data}) async {
    await navigatorKey.currentState!.pushNamed(path, arguments: data);
  }

  @override
  Future<void> navigateToPageAndClear({required String path}) async {
    await navigatorKey.currentState!
        .pushNamedAndRemoveUntil(path, (Route<dynamic> route) => false);
  }

  @override
  Future<void> replacementPage({required Widget path, Object? data}) async {
    await navigatorKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (context) => path ));
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

   Map<String, Widget>  _router = {};
    void setRouters(   Map<String, Widget>  routs )  {    _router = routs;}
Object? argumants;

  @override
  Route<dynamic> generateRoute( RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed

argumants = settings.arguments;
 return GenerateAnimatedPageRoute(screen: _router[settings.name] ?? getWidgetError(), routeName: settings.name  , data: argumants) ;

  }
}
