import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarConfig {
  // Title configuration
  final String title;
  final TextStyle? titleStyle;
  final Widget? titleWidget;

  // Actions and leading
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;

  // Appearance
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final double? toolbarHeight;
  final bool? centerTitle;

  final PreferredSizeWidget? bottom;

  AppBarConfig({
    this.title = 'تطبيقي',
    this.titleStyle,
    this.titleWidget,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.toolbarHeight,
    this.centerTitle,
    this.bottom,
  });

  AppBar? buildAppBar({
    required BuildContext context,
    bool isAppBar = true,
    bool isDesplayTitle = false,
    String currentTilte = "",
  }) {
    String newTitels = isDesplayTitle ? currentTilte : title;

    // تحديد الـ leading: إذا كان محدداً مسبقاً استخدمه، وإلا تحقق من canPop
    Widget? effectiveLeading = leading;
    if (effectiveLeading == null && GoRouter.of(context).canPop()) {
      effectiveLeading = IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.pop();
        },
      );
    }

    return isAppBar
        ? AppBar(
            title: titleWidget ?? Text(newTitels, style: titleStyle),
            actions: actions,
            leading: effectiveLeading,
            automaticallyImplyLeading: automaticallyImplyLeading,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            elevation: elevation,
            toolbarHeight: toolbarHeight,
            centerTitle: centerTitle,
            bottom: bottom,
          )
        : null;
  }
}
