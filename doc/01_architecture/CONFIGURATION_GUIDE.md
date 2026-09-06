# ⚙️ Configuration Guide & Foundation Settings Management

---

### 🌐 Language / اللغة
[🇸🇦 **النسخة العربية (CONFIGURATION_GUIDE.ar.md)**](CONFIGURATION_GUIDE.ar.md) • [📚 **Documentation Index (README.md)**](../README.md)

---

## 1. Overview
The abstract class **`DataViewConfigraion`** serves as the architectural foundation for configuring any Flutter application powered by `JoDija Templates`. It unifies application lifecycle, route table initialization, and dynamic locale switching.

---

## 2. Structure of `DataViewConfigraion`

```dart
import 'package:flutter/material.dart';
import 'package:JoDija_tamplites/util/navigations/navigation_service.dart';

abstract class DataViewConfigraion {
  String _Version = " V:  1.0.0";
  String _AppName = "Commerce App";
  String _AppNameID = "Commerce_App";

  String get Version => _Version;
  set Version(String value) => _Version = value;

  String get AppName => _AppName;
  set AppName(String value) => _AppName = value;

  String get AppNameID => _AppNameID;
  set AppNameID(String value) => _AppNameID = value;

  /// Default launch screen widget
  Widget launchScreen();

  /// Initializes route registration with NavigationService
  void RouteInit() {
    NavigationService().setRouters(getRouters());
  }

  /// Complete routing map for application screens
  Map<String, Widget> getRouters();

  /// Dynamic locale updater and RTL handler
  void setAppLocal(String localCode);
}
```

---

## 3. Practical Implementation Examples

### A) Single-Solution App Configuration (`matger-client-app`)
```dart
class MatgerClientConfig extends DataViewConfigraion {
  @override
  String get AppName => "Delta Storefront";

  @override
  String get AppNameID => "delta_client_app";

  @override
  String get Version => "1.2.0";

  @override
  Widget launchScreen() => const HomeScreen();

  @override
  Map<String, Widget> getRouters() => {
    '/': const HomeScreen(),
    '/catalog': const CatalogScreen(),
    '/cart': const CartScreen(),
    '/profile': const ProfileScreen(),
  };

  @override
  void setAppLocal(String localCode) {
    // Dynamically adjust text direction and layout direction based on user selection
  }
}
```

### B) Multi-Solution Ecosystem Configuration (`matger-management-app`)
```dart
class MatgerAdminConfig extends DataViewConfigraion {
  @override
  String get AppName => "Delta Mager Pro Dashboard";

  @override
  String get AppNameID => "delta_management_app";

  @override
  String get Version => "3.0.3";

  @override
  Widget launchScreen() => const ProductsManagementScreen();

  @override
  Map<String, Widget> getRouters() => {
    '/dashboard': const AnalyticsDashboardScreen(),
    '/products': const ProductsManagementScreen(),
    '/categories': const CategoriesManagementScreen(),
    '/orders': const OrdersManagementScreen(),
    '/inventory': const InventoryControlScreen(),
    '/settings': const SystemSettingsScreen(),
  };

  @override
  void setAppLocal(String localCode) {
    // Dynamic localization reload and tabular view update
  }
}
```

---

## 4. Unified Network Connector (`AppHttpConnector`)
An abstract network connector designed to interface with the `matger-express` API:

```dart
abstract class AppHttpConnector {
  /// Defines Base URL, Default Headers, and Bearer JWT authorization tokens
}
```
