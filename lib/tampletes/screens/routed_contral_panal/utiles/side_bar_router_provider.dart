
import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/models/route_item.dart';
import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/providers/sidebar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin SideBarRouterProvider {
// add the SidebarProvider to add the routeItems in run time
  final List<RouteItem> _routeItems = [];

  void addRouteItem(RouteItem item) {
    _routeItems.add(item);
  }

  List<RouteItem> get routeItems => _routeItems;

// how access to provider
void setupSideBarRouterProvider(BuildContext context) {
  SidebarProvider provider = context.read<SidebarProvider>();
  for (var item in this.routeItems) {
    provider.sidebarItems.add(item);
  }
}

}