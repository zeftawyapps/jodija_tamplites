# ⚙️ دليل الـ Configuration وإدارة الإعدادات التأسيسية

## 1. نظرة عامة
كلاس **`DataViewConfigraion`** هو الأساس الهيكلي لتهيئة أي تطبيق يعتمد على حزمة `JoDija Templates`. يضمن هذا الكلاس توحيد دورة حياة التطبيق، تهيئة المسارات، وضبط اللغات.

---

## 2. هيكل كلاس `DataViewConfigraion`

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

  /// الشاشة الرئيسية التي يبدأ بها التطبيق
  Widget launchScreen();

  /// تهيئة المسارات في NavigationService
  void RouteInit() {
    NavigationService().setRouters(getRouters());
  }

  /// خريطة المسارات المتاحة داخل التطبيق
  Map<String, Widget> getRouters();

  /// ضبط اللغة وتحديث الاتجاه
  void setAppLocal(String localCode);
}
```

---

## 3. أمثلة عملية للتطبيق

### أ) إعداد تطبيق أحادي الحلول (`matger-client-app`)
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
    // ضبط اتجاه الواجهة بناء على لغة العميل
  }
}
```

### ب) إعداد نظام متعدد الحلول (`matger-management-app`)
```dart
class MatgerAdminConfig extends DataViewConfigraion {
  @override
  String get AppName => "Delta Mager Pro Dashboard";

  @override
  String get AppNameID => "delta_management_app";

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
    // تحديث الترجمة وضبط جداول البيانات
  }
}
```

---

## 4. موصل الشبكة الموحد (`AppHttpConnector`)
كلاس تجريدي لتنسيق الاتصال مع خادم `matger-express`:

```dart
abstract class AppHttpConnector {
  // يحدد إعدادات الـ Base URL، الـ Headers، ورمز المصادقة JWT
}
```
