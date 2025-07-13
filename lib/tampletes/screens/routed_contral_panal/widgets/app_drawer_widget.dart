import 'package:flutter/material.dart';
import '../theam/theam.dart';
import '../laaunser.dart';
import 'sidebar_widget.dart';

class AppDrawerWidget extends StatelessWidget {
  final List<dynamic> items;
  final int selectedIndex;

  const AppDrawerWidget({
    super.key,
    required this.items,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SidebarNavigationControlPanale.getTheme(context);

    return Drawer(
      width: theme.itemHeight * 5.5, // Dynamic width based on theme
      backgroundColor: theme.backgroundColor,
      child: SidebarWidget(
        items: items,
        selectedIndex: selectedIndex,
      ),
    );
  }
}
