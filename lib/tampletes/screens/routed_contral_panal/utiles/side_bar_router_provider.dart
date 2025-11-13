
import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/models/route_item.dart';
import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/providers/sidebar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Mixin for managing app shell routes dynamically
mixin AppShellRouteManager {
// add the AppShellRouterProvider to add the routeItems in run time
  final List<RouteItem> _routeItems = [];
AppShellRouterProvider? provider ; 
  void addRouteItem(RouteItem item) {
    _routeItems.add(item);
  }

  List<RouteItem> get routeItems => _routeItems;

// how access to provider
void setupAppShellRouteManager(BuildContext context) {
  if ( this .  provider == null )   {
  this.  provider = context.read<AppShellRouterProvider>();
  
  provider!.setSidebarItems(_routeItems);
  }
}

RouteItem? getRouteItemById(String id) {
  try {
    return _routeItems.firstWhere((item) => item.id == id);
  } catch (e) {
    return null; // Return null if no matching item is found
  }
}
 List<RouteItem> getRouteItemsFromAppShellRouterProvider(BuildContext context) {
  AppShellRouterProvider provider = context.read<AppShellRouterProvider>();
  _routeItems.addAll(provider.sidebarItems);
 
  return _routeItems; 
}

}