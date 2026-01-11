import 'package:JoDija_tamplites/util/navigations/web_route.dart';
import 'package:flutter/cupertino.dart';

import 'animation_types.dart';

class GenerateAnimatedPageRoute extends PageRouteBuilder {
  final Widget? screen;
  final String? routeName;
  final Object? data;
  NavigationAnimationType animationType = NavigationAnimationType.none;
  GenerateAnimatedPageRoute(
      {this.screen,
      this.routeName,
      this.data,
      this.animationType = NavigationAnimationType.none})
      : super(
            settings: RouteSettings(name: routeName, arguments: data),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return screen!;
            },
            transitionDuration: Duration(milliseconds: 300),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              Map<NavigationAnimationType, Widget> childWidget = {
                NavigationAnimationType.slide: SlideTransition(
                  textDirection: TextDirection.ltr,
                  position: Tween<Offset>(
                    begin: Offset(2.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
                NavigationAnimationType.fade: FadeTransition(
                  opacity: Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(animation),
                  child: child,
                ),
                NavigationAnimationType.scale: ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(animation),
                  child: child,
                ),
                NavigationAnimationType.rotate: RotationTransition(
                  turns: Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(animation),
                  child: child,
                ),
                NavigationAnimationType.size: SizeTransition(
                  sizeFactor: Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(animation),
                  child: child,
                ),
                NavigationAnimationType.position: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(2.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
                NavigationAnimationType.none: child,
              };
              return childWidget[animationType]!;
            });
}

class urlGeneratior extends Route {
  void generateUrl(
      String path, Map<String, String>? pram, Map<String, dynamic>? query) {}
}
