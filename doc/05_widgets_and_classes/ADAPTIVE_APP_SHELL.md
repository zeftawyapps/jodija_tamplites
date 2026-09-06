# 📱 AdaptiveAppShell & RouteItem - Comprehensive Widget Guide

---

### 🌐 Language / اللغة
[🇸🇦 **النسخة العربية (ADAPTIVE_APP_SHELL.ar.md)**](ADAPTIVE_APP_SHELL.ar.md) • [📖 **Tutorial (HOW_TO_USE.md)**](../HOW_TO_USE.md) • [📚 **Documentation Portal (README.md)**](../README.md)

---

## 1. What is `AdaptiveAppShell`?
**`AdaptiveAppShell`** is the core responsive container widget in `JoDija Templates`. It dynamically orchestrates the application shell hierarchy depending on screen dimensions:
- **Desktop & Web (> 800px):** Renders a persistent, collapsible `Sidebar` with active route state indicators.
- **Mobile & Tablet (< 800px):** Automatically collapses navigation into a modal `Drawer` or thumb-friendly `BottomNavigationBar`.
- **Automatic RTL Mirroring:** Passing `languageCode: 'ar'` flips navigation sidebars, typography alignment, and icons naturally according to Arabic text direction.

---

## 2. Parameter Reference Table

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `sidebarItems` | `List<RouteItem>` | Required | List of navigation route destinations. |
| `titleApp` | `String` | `"My App"` | Global application title rendered in app bars and browser tabs. |
| `initRouter` | `String` | `"/"` | Default entry-point path when the application launches. |
| `languageCode` | `String` | `"en"` | Viewport locale; `'ar'` enables native RTL mirroring, `'en'` enables LTR. |
| `isDarkMode` | `bool` | `false` | Toggles between light mode and dark theme. |
| `sidebarBackgroundColor` | `Color?` | `Color(0xFF556B2F)` | Background color token for the navigation sidebar. |
| `sidebarSelectedColor` | `Color?` | `Colors.white` | Highlight background color for the currently active route item. |
| `sidebarTextColor` | `Color?` | `Colors.white` | Default font/icon color for unselected navigation items. |
| `sidebarSelectedTextColor` | `Color?` | `Color(0xFF556B2F)` | Font and icon color for the active item. |
| `animationType` | `SidBarAnimationType` | `.slideAndFade` | Entry animation curve (`slideAndFade`, `fadeOnly`, `scaleUp`, etc.). |
| `sidebarHeader` | `SidebarHeaderConfig?` | `null` | Header model configuring logos (local or URL) and title typography. |
| `smallScreenAppBar` | `AppBarConfig?` | `null` | Top app bar model for mobile viewport rendering. |
| `largeScreenAppBar` | `AppBarConfig?` | `null` | Top app bar model for desktop/web viewport rendering. |

---

## 3. The `RouteItem` Data Model

| Property | Type | Description |
| :--- | :--- | :--- |
| `id` | `String` | Unique item identifier (e.g., `"products"`). |
| `path` | `String` | Target routing URL path (e.g., `"/products"` or `"/products/:id"`). |
| `label` | `String` | User-facing title rendered in sidebars and bottom navigation bars. |
| `icon` | `IconData` | Icon displayed next to the item label. |
| `content` | `Widget` | Destination widget rendered when this route is selected. |
| `isSideBarRouted` | `bool` | Synchronizes with GoRouter upon selection (recommended: `true`). |
| `isAppBar` | `bool` | Renders top app bar on this screen. |
| `isInBottomNavBar` | `bool` | Displays this item in the mobile bottom navigation bar. |
| `isVisableInSideBar` | `bool` | Controls visibility in desktop persistent sidebar. |

---

## 4. Full Runnable Example

```dart
import 'package:flutter/material.dart';
import 'package:JoDija_tamplites/JoDija_tamplites.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveAppShell(
      titleApp: "Delta Mager Pro",
      initRouter: "/dashboard",
      languageCode: "en", // Set 'ar' for native Arabic / RTL
      isDarkMode: false,
      
      // Enterprise Olive Sidebar Theme
      sidebarBackgroundColor: const Color(0xFF556B2F),
      sidebarSelectedColor: Colors.white,
      sidebarTextColor: Colors.white,
      sidebarSelectedTextColor: const Color(0xFF556B2F),
      
      sidebarHeader: SidebarHeaderConfig(
        title: "Delta Mager Pro",
        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        logoAssetPath: "doc/assets/jodija_logo.png",
        logoHight: 45,
        logoWidth: 45,
      ),

      sidebarItems: [
        RouteItem(
          id: "dashboard",
          path: "/dashboard",
          label: "Dashboard",
          icon: Icons.dashboard_outlined,
          content: const Center(child: Text("Analytics Dashboard Screen")),
          isSideBarRouted: true,
          isAppBar: true,
          isInBottomNavBar: true,
        ),
        RouteItem(
          id: "products",
          path: "/products",
          label: "Products",
          icon: Icons.inventory_2_outlined,
          content: const Center(child: Text("Products Catalog Screen")),
          isSideBarRouted: true,
          isAppBar: true,
          isInBottomNavBar: true,
        ),
        RouteItem(
          id: "orders",
          path: "/orders",
          label: "Orders",
          icon: Icons.shopping_bag_outlined,
          content: const Center(child: Text("Orders Management Screen")),
          isSideBarRouted: true,
          isAppBar: true,
          isInBottomNavBar: true,
        ),
      ],
    );
  }
}
```

---

## 5. Best Practices
1. **Accessing Parameters via `AppShellRouterMixin`**: When building detail screens that extract URL parameters (e.g., `getPrams()?['id']`), mix your state with `with AppShellRouterMixin`.
2. **Bottom Navigation Filtering**: Limit `isInBottomNavBar: true` to your top 3–5 most critical routes to avoid cluttering mobile screens.
