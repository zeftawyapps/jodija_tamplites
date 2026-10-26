import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/models/route_item.dart';
import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/widgets/drower_widget.dart';
import 'package:flutter/material.dart';
import '../laaunser.dart';

class AppDrawerWidget extends StatelessWidget {
  final List<RouteItem> items;
  final int selectedIndex;

  const AppDrawerWidget({
    super.key,
    required this.items,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AdaptiveAppShell.getTheme(context);
     return Drawer(
      width: (theme.itemHeight * 5.5).clamp(270.0, 320.0), // Responsive width based on theme
      backgroundColor: theme.backgroundColor,
      child: DrawerbarWidget(
        items: items,
        selectedIndex: selectedIndex,
      ),
    );
  }
}
