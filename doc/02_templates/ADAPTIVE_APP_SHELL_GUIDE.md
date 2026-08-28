# 🧭 دليل Adaptive App Shell الشامل

## 1. نظرة عامة
**`AdaptiveAppShell`** هو المكون الأساسي لبناء واجهات متجاوبة بالكامل تتكيف تلقائياً مع مختلف أحجام الشاشات وأنظمة التشغيل (Desktop, Web, Tablet, Mobile) مع دعم كامل لنظام **RTL** واللغة العربية وحركات الأنيميشن السلسة.

---

## 2. المعاينات البصرية لقوالب الواجهات

<div align="center">
  <img src="../assets/products_dashboard.jpg" alt="Delta Mager Pro Products Dashboard" width="85%" style="border-radius: 12px; margin-bottom: 16px;" />
  <img src="../assets/categories_dashboard.jpg" alt="Delta Mager Pro Categories Dashboard" width="85%" style="border-radius: 12px;" />
</div>

---

## 3. المعاملات والخصائص الرئيسية

| الخاصية | النوع | الوصف |
| :--- | :--- | :--- |
| `sidebarItems` | `List<RouteItem>` | قائمة عناصر وروابط القائمة الجانبية ومساراتها |
| `languageCode` | `String` | كود اللغة ('ar' لتفعيل RTL تلقائياً، 'en' للـ LTR) |
| `isDarkMode` | `bool` | التبديل بين الوضع الفاتح والداكن |
| `sidebarBackgroundColor` | `Color?` | لون خلفية القائمة الجانبية (مثل الثيم الزيتي `0xFF556B2F`) |
| `sidebarSelectedColor` | `Color?` | لون خلفية العنصر النشط (Selected Item) |
| `sidebarTextColor` | `Color?` | لون النصوص العادية في القائمة |
| `sidebarSelectedTextColor` | `Color?` | لون نص العنصر النشط |
| `animationType` | `SidBarAnimationType` | نوع أنيميشن دخول عناصر القائمة (`slideAndFade`, `fadeOnly`, ...) |
| `smallScreenAppBar` | `AppBarConfig?` | إعدادات الـ AppBar لشاشات الجوال |
| `largeScreenAppBar` | `AppBarConfig?` | إعدادات الـ AppBar لشاشات الديسك توب والتابلت |
| `extraProvidersAndBlocs` | `List<SingleChildWidget>?` | حقن مزودات الـ BLoC و Provider على مستوى التطبيق بالكامل |

---

## 4. نموذج `RouteItem`

يحدد كل مسار وشاشة داخل التطبيق:

```dart
RouteItem(
  id: "products",
  path: "/products",
  label: "المنتجات",
  icon: Icons.inventory_2_outlined,
  content: const ProductsScreen(),
  isSideBarRouted: true,    // استخدام التوجيه بالمسار
  isAppBar: true,           // إظهار الـ AppBar
  isInBottomNavBar: false,  // إظهاره في الشريط السفلي للجوال إن رغبت
  isVisableInSideBar: true, // مرئي في القائمة الجانبية
)
```

---

## 5. ميزات التوجيه مع `AppShellRouterMixin`

أي شاشة تستخدم هذا الـ Mixin تحصل على وصول فوري لمعاملات الرابط والتنقل:

```dart
class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with AppShellRouterMixin {
  
  @override
  void initState() {
    super.initState();
    // قراءة معامل :id من الرابط مباشرة
    final productId = getPrams()?['id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () => goRoute(context, '/categories'),
        child: const Text('العودة للفئات'),
      ),
    );
  }
}
```
