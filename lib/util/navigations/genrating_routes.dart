import 'package:flutter/cupertino.dart';

class GenerateAnimatedPageRoute extends PageRouteBuilder {
  final Widget? screen;
  final String? routeName;
final Object  ? data;
  GenerateAnimatedPageRoute({this.screen, this.routeName , this.data})
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
          Widget child) {

        return SlideTransition(
          textDirection: TextDirection.ltr ,
          position: Tween<Offset>(
            begin: Offset(2.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      });


}
