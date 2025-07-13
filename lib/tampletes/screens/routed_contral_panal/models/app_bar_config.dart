import 'package:flutter/material.dart';

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

  AppBar buildAppBar({bool isSmallScreen = true}) {
    return AppBar(
      title: titleWidget ?? Text(title, style: titleStyle),
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      toolbarHeight: toolbarHeight,
      centerTitle: centerTitle,
      bottom: bottom,
    );
  }
}
