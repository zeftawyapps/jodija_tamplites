import 'package:flutter/cupertino.dart';

import 'animation_types.dart';

class GenerateAnimatedPageRoute extends PageRouteBuilder {
  final Widget? screen;
  final String? routeName;
  final Object  ? data;
  AnimationType animationType = AnimationType.none;
  GenerateAnimatedPageRoute({this.screen, this.routeName , this.data
  , this.animationType = AnimationType.none
  })
      : super(
      settings: RouteSettings(name: routeName , arguments: data),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return screen!;
      },
      transitionDuration: Duration(milliseconds: 300),
      transitionsBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child ) {
        Map<AnimationType , Widget> childWidget = {
          AnimationType.slide: SlideTransition(
            textDirection: TextDirection.ltr ,
            position: Tween<Offset>(
              begin: Offset(2.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
          AnimationType.fade: FadeTransition(
            opacity: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation),
            child: child,
          ),
          AnimationType.scale: ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation),
            child: child,
          ),
          AnimationType.rotate: RotationTransition(
            turns: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation),
            child: child,
          ),
          AnimationType.size: SizeTransition(
            sizeFactor: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation),
            child: child,
          ),
          AnimationType.position: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(2.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
          AnimationType.none: child,
        };
        return    childWidget[animationType]! ;
      });



}
