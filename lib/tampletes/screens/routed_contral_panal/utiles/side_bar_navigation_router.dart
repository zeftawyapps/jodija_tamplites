import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

mixin SideBarNavigationRouterMixin {

 void goRoute(
    BuildContext context, String path, {bool replace = false}) {
  if (replace) {
    context.replace(path);
  } else {
    context.go(path);
  }
 }
  // set if the  use press back navigat pop

 void goPop(BuildContext context) {
   // use goRouter to pop the current route
    if (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    } else {
      // If no routes to pop, you can handle it here, e.g., show a message or navigate to home
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No more routes to pop')),
      );
    }

  }



}