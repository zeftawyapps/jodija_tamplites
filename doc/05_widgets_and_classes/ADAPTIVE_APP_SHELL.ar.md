# 📱 ودجة AdaptiveAppShell و RouteItem - الدليل التطبيقي الكامل

---

### 🌐 اللغة / Language
[🇺🇸 **English Version (ADAPTIVE_APP_SHELL.md)**](ADAPTIVE_APP_SHELL.md) • [📖 **دليل الاستخدام (HOW_TO_USE.ar.md)**](../HOW_TO_USE.ar.md) • [📚 **بوابة التوثيق (README.ar.md)**](../README.ar.md)

---

## 1. ما هي ودجة `AdaptiveAppShell`؟
**`AdaptiveAppShell`** هي الودجة الحاوية الأساسية في حزمة `JoDija Templates`. تقوم ببناء هيكل التطبيق بالكامل وتغيير التخطيط آلياً بناءً على قياس شاشة الجهاز:
- **شاشات الديسك توب والويب (> 800px):** تعرض قائمة جانبية (`Sidebar`) تفاعلية وثابتة مع إمكانية طيها، وتمييز العنصر النشط.
- **شاشات الهواتف والتابلت (< 800px):** تحول القائمة تلقائياً إلى قائمة منزلقة (`Drawer`) أو شريط سفلي (`BottomNavigationBar`) حسب إعدادات كل عنصر.
- **دعم RTL التلقائي:** عند تمرير `languageCode: 'ar'`، يتم عكس القوائم والاتجاهات والأيقونات بسلاسة وفق قواعد اللغة العربية.

---

## 2. جدول المعاملات والخصائص (Parameters)

| المعامل | النوع | الافتراضي | الوصف |
| :--- | :--- | :--- | :--- |
| `sidebarItems` | `List<RouteItem>` | إلزامي | قائمة الشاشات والمسارات التي تظهر في القائمة الجانبية أو الشريط السفلي. |
| `titleApp` | `String` | `"تطبيقي"` | اسم التطبيق الرئيسي المعروض في الترويسة وشريط المهام. |
| `initRouter` | `String` | `"/"` | المسار الأولي الذي يفتح عليه التطبيق عند التشغيل. |
| `languageCode` | `String` | `"ar"` | كود لغة الواجهة؛ تعيين `"ar"` يفعل اتجاه RTL تلقائياً، و `"en"` يفعل LTR. |
| `isDarkMode` | `bool` | `false` | التبديل بين الوضع الفاتح والوضع الليلي (Dark Mode). |
| `sidebarBackgroundColor` | `Color?` | `Color(0xFF556B2F)` | لون خلفية القائمة الجانبية (مثل الثيم الزيتي). |
| `sidebarSelectedColor` | `Color?` | `Colors.white` | لون خلفية العنصر المحدد حالياً. |
| `sidebarTextColor` | `Color?` | `Colors.white` | لون نصوص وأيقونات العناصر غير المحددة. |
| `sidebarSelectedTextColor` | `Color?` | `Color(0xFF556B2F)` | لون نص وأيقونة العنصر النشط. |
| `animationType` | `SidBarAnimationType` | `.slideAndFade` | حركة دخول عناصر القائمة (`slideAndFade`, `fadeOnly`, `scaleUp`, إلخ). |
| `sidebarHeader` | `SidebarHeaderConfig?` | `null` | تخصيص شعار التطبيق (لوجو محلي أو رابط) وعنوان الترويسة. |
| `smallScreenAppBar` | `AppBarConfig?` | `null` | تخصيص الشريط العلوي عند فتح التطبيق على الهاتف. |
| `largeScreenAppBar` | `AppBarConfig?` | `null` | تخصيص الشريط العلوي على شاشات الديسك توب والويب. |

---

## 3. خصائص كائن `RouteItem`

| الخاصية | النوع | الوصف |
| :--- | :--- | :--- |
| `id` | `String` | المعرف الفريد للعنصر (مثال: `"products"`). |
| `path` | `String` | مسار الرابط للتنقل (مثال: `"/products"` أو `"/products/:id"`). |
| `label` | `String` | العنوان المكتوب في القائمة الجانبية أو الشريط السفلي. |
| `icon` | `IconData` | الأيقونة المعروضة بجانب الاسم. |
| `content` | `Widget` | الشاشة أو الودجة التي تظهر للمستخدم عند الضغط على هذا العنصر. |
| `isSideBarRouted` | `bool` | هل يتم التوجيه عبر GoRouter عند النقر؟ (يُنصح بـ `true`). |
| `isAppBar` | `bool` | هل يتم عرض الـ AppBar في هذه الشاشة؟ |
| `isInBottomNavBar` | `bool` | هل يظهر هذا العنصر في شريط التنقل السفلي في الجوال؟ |
| `isVisableInSideBar` | `bool` | هل يظهر في القائمة الجانبية للديسك توب؟ |

---

## 4. كود تطبيقي كامل جاهز للتشغيل (Full Runnable Example)

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
      titleApp: "نظام إدارة المبيعات",
      initRouter: "/dashboard",
      languageCode: "ar", // تفعيل اللغة العربية و RTL تلقائياً
      isDarkMode: false,
      
      // تخصيص الثيم الزيتي المفضل للوحات التحكم
      sidebarBackgroundColor: const Color(0xFF556B2F),
      sidebarSelectedColor: Colors.white,
      sidebarTextColor: Colors.white,
      sidebarSelectedTextColor: const Color(0xFF556B2F),
      
      // رأس القائمة الجانبية مع الشعار
      sidebarHeader: SidebarHeaderConfig(
        title: "دلتا مانجر برو",
        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        logoAssetPath: "doc/assets/jodija_logo.png",
        logoHight: 45,
        logoWidth: 45,
      ),

      sidebarItems: [
        RouteItem(
          id: "dashboard",
          path: "/dashboard",
          label: "لوحة المؤشرات",
          icon: Icons.dashboard_outlined,
          content: const Center(child: Text("شاشة لوحة المؤشرات")),
          isSideBarRouted: true,
          isAppBar: true,
          isInBottomNavBar: true,
        ),
        RouteItem(
          id: "products",
          path: "/products",
          label: "إدارة المنتجات",
          icon: Icons.inventory_2_outlined,
          content: const Center(child: Text("شاشة قائمة المنتجات")),
          isSideBarRouted: true,
          isAppBar: true,
          isInBottomNavBar: true,
        ),
        RouteItem(
          id: "orders",
          path: "/orders",
          label: "طلبات العملاء",
          icon: Icons.shopping_bag_outlined,
          content: const Center(child: Text("شاشة الطلبات")),
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

## 5. أفضل الممارسات (Best Practices)
1. **استخدام `AppShellRouterMixin`**: عند بناء شاشات التفاصيل التي تحتاج لقراءة متغيرات الروابط (مثل `getPrams()?['id']`)، استخدم الميكسين `with AppShellRouterMixin`.
2. **استخدام `isInBottomNavBar: true`**: للشاشات الرئيسية الأربع الأكثر استخداماً فقط حتى لا يزدحم الشريط السفلي على هواتف المستخدمين.
