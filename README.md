<div align="center">

# JoDija Templates (Adaptive App Shell) 🚀

A powerful Flutter package for building highly responsive application shells, control panels, and dashboards. It handles routing, responsiveness, and theming gracefully out of the box.

*حزمة فلاتر قوية لبناء لوحات تحكم وتطبيقات متجاوبة بالكامل مع دعم التوجيه، الترجمة، والثيمات المخصصة.*

</div>

---

## 🌟 Features / المميزات

- 📱 **Responsive out-of-the-box**: Auto-switches between a fixed Sidebar (Desktop/Web) and a Drawer or BottomNavBar (Mobile).
- 🧭 **Built-in Routing**: Seamless integration with the popular `go_router` package.
- 🎨 **Dynamic Theming**: Full support for Light and Dark modes with highly customizable sidebar color tokens.
- 🔤 **Localization Ready**: Native support for RTL/LTR layouts based on your `languageCode`.
- 🧩 **State Management Friendly**: Easily inject your `MultiBlocProvider` or `ChangeNotifierProvider` at the root level.
- 🎬 **Animated Sidebar**: Smooth slide and fade animations when toggling the sidebar.

---

## 🛠️ Getting Started / البداية

To use the `AdaptiveAppShell` core widget, you simply need to wrap it inside your root entry point (e.g., your App's main widget).

### 1. Initialization (تهيئة التطبيق)

```dart
import 'package:flutter/material.dart';
import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/laaunser.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveAppShell(
      titleApp: "My Awesome App",
      initRouter: "/dashboard",
      languageCode: "en", // Changes layout direction automatically (RTL/LTR)
      isDarkMode: false,
      
      // Inject your Providers/Blocs here
      extraProvidersAndBlocs: [
        // ChangeNotifierProvider(...),
        // BlocProvider(...),
      ],
      
      // Setup Themes
      lightTheme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      
      // Setup Sidebar Items & Routes
      sidebarItems: [
        RouteItem(
          id: "dashboard",
          path: "/dashboard",
          label: "Dashboard",
          icon: Icons.dashboard,
          content: DashboardScreen(),
          isSideBarRouted: true,
          isAppBar: true, 
        ),
      ],
    );
  }
}
```

### 2. Configure Sidebar & Routes (تكوين الشريط الجانبي والمسارات)

Every page in your application is defined using a `RouteItem`. This model controls how the page looks in the Sidebar, whether it needs an `AppBar`, and if it appears in the `BottomNavigationBar` on mobile.

```dart
RouteItem(
  id: "profile",
  path: "/users/:id",
  label: "User Profile",
  icon: Icons.person,
  content: ProfileScreen(),
  isVisableInSideBar: true,   // Show in the sidebar
  isDrawerShow: true,         // Show in the mobile drawer
  isInBottomNavBar: false,    // Do not show in the bottom nav
)
```

### 3. Navigation (التنقل بين الصفحات)

The package provides a handy mixin `AppShellRouterMixin` which gives any `StatefulWidget` instant access to routing methods (`goRoute`, `goPop`) and URL parameters.

```dart
import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/utiles/side_bar_navigation_router.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AppShellRouterMixin {
  
  @override
  void initState() {
    super.initState();
    // Access URL parameters directly!
    print("User ID: ${getPrams()?['id']}"); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Push route
            goRoute(context, "/settings");
            
            // Or Replace route
            // goRoute(context, "/login", replace: true);
            
            // Pop
            // goPop(context);
          },
          child: Text("Go to Settings"),
        ),
      ),
    );
  }
}
```

---

## 📚 Documentation / التوثيق الكامل

For a detailed breakdown of all properties, theming options, and advanced routing (including animations overhead), please refer to our internal [Routed Control Panel Guide](doc/ROUTED_CONTROL_PANEL_GUIDE.md).

## 🪪 License
This project is licensed under the MIT License.
