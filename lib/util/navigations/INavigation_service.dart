import 'package:flutter/material.dart';
import "animation_types.dart";

abstract class INavigationService {
  Route<dynamic>? generateRoute( RouteSettings settings , {NavigationAnimationType animatiionType = NavigationAnimationType.none});

  Future<void> navigateToPage({required String path, Object? data});
  Future<void> navigateToPageWithUrl({required String path,Map<String , String >pram , Map<String , dynamic > query});

  Future<void> replacementPage({required Widget path, Object? data});

  Future<void> navigateToPageAndClear({required String path});

  Future<void> navigateToPageClear({required String path, Object? data});

  void goBack();

  void unFocus();

  Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return  getWidgetError();
    });
  }
  Widget getWidgetError()=>   Scaffold(
  appBar: AppBar(
  title: Text('Error'),
  ),
  body: Center(
  child: Text('ERROR'),
  ),
  );
}
