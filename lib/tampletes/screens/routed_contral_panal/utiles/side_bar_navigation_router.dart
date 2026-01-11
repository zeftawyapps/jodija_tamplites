import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/providers/sidebar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// Mixin for adaptive app shell routing capabilities
mixin AppShellRouterMixin {
  void goRoute(BuildContext context, String path, {bool replace = false}) {
    if (replace) {
      context.replace(path);
    } else {
      context.go(path);
    }
  }
  // set if the  use press back navigat pop

  void goPop(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      // في حا لة عدم وجود routes للرجوع إليها، عرض رسالة للمستخدم
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لا توجد صفحات للرجوع إليها'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Map<String, dynamic>? params;
  Map<String, dynamic>? query;
  String? mainPath; // الرابط الرئيسي عند الاستدعاء من الـ sidebar

  Map<String, dynamic>? getQuery() {
    return query;
  }

  Map<String, dynamic>? getPrams() {
    return params;
  }

  String? getMainPath() {
    return mainPath;
  }

  void goRouterInSidBar(BuildContext context, String path) {
    AppShellRouterProvider provider = context.read<AppShellRouterProvider>();

    provider!.handleItemTapByPath(context, path);
  }
}
