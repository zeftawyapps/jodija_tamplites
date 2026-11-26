![JoDija Logo](https://raw.githubusercontent.com/zeftawyapps/jodija_tamplites/master/doc/assets/jodija_logo.png)

# 🚀 قوالب جوديجا (`jodija_tamplites`) - النواة الشاملة للأنظمة والتطبيقات

**حزمة فلاتر متطورة لتأسيس لوحات التحكم، التطبيقات الأحادية، والمنصات متعددة الوحدات مع دعم كامل ومحلي للغة العربية ونظام RTL على جميع المنصات (Android, iOS, Web, macOS, Windows, Linux).**

[![pub package](https://img.shields.io/pub/v/jodija_tamplites.svg)](https://pub.dev/packages/jodija_tamplites)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/zeftawyapps/jodija_tamplites/blob/master/LICENSE)

🌐 **اللغة / Language:** [🇺🇸 English Documentation (README.md)](https://github.com/zeftawyapps/jodija_tamplites/blob/master/README.md) • [📚 بوابة التوثيق الكاملة (doc/README.md)](https://github.com/zeftawyapps/jodija_tamplites/blob/master/doc/README.md)

---

## 📸 معرض الواجهات والقوالب الحية (Real UI Showcase)

نماذج حية تم بناؤها باستخدام `JoDija Templates` مثل نظام **Delta Mager Pro**:

<div align="center">
  <img src="https://raw.githubusercontent.com/zeftawyapps/jodija_tamplites/master/doc/assets/products_dashboard.jpg" alt="Delta Mager Pro لوحة إدارة المنتجات" width="85%" style="border-radius: 12px; box-shadow: 0 8px 24px rgba(0,0,0,0.15); margin-bottom: 20px;" />
  <p><strong>لوحة تحكم المنتجات (Products Dashboard)</strong>: القائمة الجانبية (Sidebar) بنظام RTL مع كبسولات التصفية وشبكة البطاقات المتجاوبة وبادجات (الأكثر مبيعاً وخصم كبير).</p>
</div>

<div align="center">
  <img src="https://raw.githubusercontent.com/zeftawyapps/jodija_tamplites/master/doc/assets/categories_dashboard.jpg" alt="Delta Mager Pro لوحة إدارة الفئات" width="85%" style="border-radius: 12px; box-shadow: 0 8px 24px rgba(0,0,0,0.15); margin-top: 10px;" />
  <p><strong>لوحة إدارة الفئات والكتالوج (Categories Dashboard)</strong>: إبراز العنصر النشط في القائمة الجانبية، شريط البحث، وزر الإضافة بالثيم الزيتي المخصص.</p>
</div>

---

## 🏛️ الفلسفة المعمارية: التطبيقات أحادية الحلول vs متعددة الحلول

تعتمد الحزمة على ركيزة معمارية أساسية تدعم نمطين من التطبيقات مع إعادة استخدام الكود بنسبة 100%:

```text
+-------------------------------------------------------------------+
|                        jodija_tamplites                           |
|  AdaptiveAppShell | DataSourceBloc | CellFieldBuilder | Themes    |
+-----------------+-------------------------------+-----------------+
                  |                               |
                  v                               v
+---------------------------------+ +-------------------------------+
|    أنظمة وحلول متعددة (Admin)   | |     تطبيقات أحادية الحلول     |
| - قائمة جانبية متجاوبة وجداول   | | - تطبيقات الجوال والويب       |
| - موديولات فرعية وتقارير        | | - دعم RTL وخطوط عربية مدمجة   |
+---------------------------------+ +-------------------------------+
```

### 1. التطبيقات أحادية الحلول (Single-Solution Apps)
- **الهدف:** حل مشكلة واحدة ومحددة للمستخدم النهائي بأعلى كفاءة وسرعة.
- **أمثلة:** تطبيق العميل (`matger-client-app`) الذي يركز على تصفح المنتجات، سلة المشتريات، وإتمام الطلب.
- **الخصائص:** مسارات خفيفة، شريط تنقل سفلي (`BottomNavigationBar`)، واستخدام مباشر لطبقة إدارة الحالات والبيانات.

### 2. التطبيقات والأنظمة متعددة الحلول (Multi-Solution Apps)
- **الهدف:** إدارة عمليات تشغيلية معقدة وربط عدة موديولات وأنظمة في واجهة واحدة.
- **أمثلة:** نظام `font logic` لإدارة ومعالجة الخطوط، ولوحة تحكم المتجر (`matger-management-app`) لإدارة المنتجات، الفئات، الطلبات، والتقارير المالية.
- **الخصائص:** تعتمد على `AdaptiveAppShell` لتغيير التخطيط آلياً بين شاشات الكمبيوتر والتابلت والجوال، مع نظام `Cell Models` للجداول والتقارير الإحصائية.

### 3. خادم الباك إند الموحد (`matger-express`)
- يمثل المزود المركزي لعقود البيانات (API Contracts)، وإعدادات التطبيقات الحية (Dynamic Configurations)، ومفاتيح الميزات (Feature Flags) لكلا النمطين.

---

## 🌟 كافة مميزات الحزمة بالتفصيل

### 1. 🧭 القالب المتجاوب الذكي (`AdaptiveAppShell`)
- **تخطيط ديناميكي متكيف:** تحويل تلقائي بين القائمة الجانبية الثابتة (`Sidebar`) على الشاشات الكبيرة، والقائمة المنزلقة (`Drawer`) أو الشريط السفلي (`BottomNavBar`) على شاشات الجوال.
- **توجيه مدمج قوي (`GoRouter`):** دعم الروابط العميقة (Deep Linking)، المعاملات المتغيرة (`:id`)، ومتغيرات الاستعلام (`?query=value`).
- **شريط تطبيق مرن (`AppBarConfig`):** تحكم كامل في الأزرار الإضافية، العناوين، وإجراءات الرجوع والقائمة.

### 2. 🌍 دعم اللغة العربية واتجاه RTL المدمج
- **ملاءمة تلقائية للـ RTL:** انعكاس تلقائي لكافة عناصر القوائم، الحركات، والمسارات بمجرد تحديد `languageCode: 'ar'`.
- **محرك اللغات والترجمة (`LocalizationConfig` & `AppLocalizationsInit`):** إدارة الكلمات المترجمة والتبديل الفوري بين العربية والإنجليزية.
- **دعم خطوط Google العربية:** تهيئة جاهزة لأشهر الخطوط العربية مثل Cairo و Tajawal و Almarai.

### 3. 🧩 إدارة الحالات وطبقة البيانات الموحدة (`DataSourceBloc`)
- **حالات موحدة للبيانات (`FeaturDataSourceState`):** كلاس جاهز يدير حالات التحميل، النجاح، الخطأ، والقوائم الفارغة.
- **عمليات الـ CRUD الجاهزة (`BaseBloc` & `CrudBloc`):** تقليل كتابة الكود المكرر لعمليات جلب وحفظ وتعديل البيانات.

### 4. 📊 محرك الجداول والخلايا الذكية (`Cell Models`)
- **معالجة متقدمة للجداول (`DataTableOfCellModels`):** تحويل نماذج البيانات إلى صفوف وخلايا ديناميكية.
- **عمليات إحصائية جاهزة:** استخراج المجموعات الفريدة (`unicGrubs`) وحساب التكرارات والمجاميع (`countBy`).

### 5. 🎨 نظام التصميم والثيمات الديناميكية (`Theming System`)
- **لوحة ألوان قياسية (`AppColors`):** تحكم في ألوان الهوية، النصوص، الأزرار، والفواصل.
- **ثيمات مخصصة (`DashboardThemes`):** دعم الثيم الفاتح والداكن وتخصيص ثيمات لوحات التحكم الإدارية (مثل الثيم الزيتي أو الأزرق).

### 6. 💾 التخزين المحلي وإدارة الجلسات
- **مدير التخزين (`SharedPrefranceData`):** إدارة وحفظ جلسة المستخدم والـ Tokens بأمان وسرعة بنمط Singleton.
- **دعم قواعد بيانات SQLite (`sqllite_helper.dart`):** لحفظ واسترجاع البيانات محلياً والعمل بدون إنترنت (Offline Caching).

### 7. ✅ أدوات التحقق من المدخلات (Form Validation)
- دوال وحقول تحقق جاهزة: `RequiredValidator`, `EmailValidator`, `PasswordValidator`, `NumberValidator`.

---

## ⚡ خطوات البدء السريع (Quick Start)

### 1. التثبيت

أضف حزمة `jodija_tamplites` مباشرة من [pub.dev](https://pub.dev/packages/jodija_tamplites):

```bash
flutter pub add jodija_tamplites
```

أو أضفها يدوياً إلى ملف `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  jodija_tamplites: ^3.1.2
```

### 2. إعداد كلاس الـ Configuration
```dart
import 'package:flutter/material.dart';
import 'package:jodija_tamplites/project_configrations/app_configration.dart';

class MatgerConfig extends DataViewConfigraion {
  @override
  String get AppName => "Delta Mager Pro";

  @override
  Widget launchScreen() => const ProductsScreen();

  @override
  Map<String, Widget> getRouters() => {
    '/dashboard': const DashboardScreen(),
    '/products': const ProductsScreen(),
    '/categories': const CategoriesScreen(),
  };

  @override
  void setAppLocal(String localCode) {
    // ضبط اللغة واتجاه الواجهة
  }
}
```

### 3. تهيئة وتشغيل الـ `AdaptiveAppShell`
```dart
import 'package:flutter/material.dart';
import 'package:jodija_tamplites/tampletes/screens/routed_contral_panal/laaunser.dart';
import 'package:jodija_tamplites/tampletes/screens/routed_contral_panal/models/route_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveAppShell(
      titleApp: "Delta Mager Pro",
      initRouter: "/products",
      languageCode: "ar", // تفعيل اللغة العربية ونظام RTL تلقائياً
      isDarkMode: false,
      
      // تخصيص ألوان القائمة الجانبية (الثيم الزيتي المميز)
      sidebarBackgroundColor: const Color(0xFF556B2F),
      sidebarSelectedColor: Colors.white,
      sidebarTextColor: Colors.white,
      sidebarSelectedTextColor: const Color(0xFF556B2F),
      
      sidebarItems: [
        RouteItem(
          id: "dashboard",
          path: "/dashboard",
          label: "لوحة التحكم",
          icon: Icons.dashboard_outlined,
          content: const DashboardScreen(),
          isSideBarRouted: true,
          isAppBar: true,
        ),
        RouteItem(
          id: "products",
          path: "/products",
          label: "المنتجات",
          icon: Icons.inventory_2_outlined,
          content: const ProductsScreen(),
          isSideBarRouted: true,
          isAppBar: true,
        ),
        RouteItem(
          id: "categories",
          path: "/categories",
          label: "الفئات",
          icon: Icons.category_outlined,
          content: const CategoriesScreen(),
          isSideBarRouted: true,
          isAppBar: true,
        ),
      ],
    );
  }
}
```

---

## 📚 فهرس الأدلة التوثيقية الشاملة

| الدليل | الموضوع الرئيسي | الرابط |
| :--- | :--- | :--- |
| **🚀 دليل الاستخدام الشامل** | شرح تطبيقي خطوة بخطوة من الصفر وحتى بناء تطبيق متكامل | [HOW_TO_USE.ar.md](https://github.com/zeftawyapps/jodija_tamplites/blob/master/doc/HOW_TO_USE.ar.md) |
| **الفلسفة والمعمارية** | معمارية الحلول الأحادية والمتعددة ودور matger-express | [PHILOSOPHY_AND_ARCHITECTURE.ar.md](https://github.com/zeftawyapps/jodija_tamplites/blob/master/doc/01_architecture/PHILOSOPHY_AND_ARCHITECTURE.ar.md) |
| **دليل الـ Configuration** | شرح DataViewConfigraion وموصل الشبكة AppHttpConnector | [CONFIGURATION_GUIDE.ar.md](https://github.com/zeftawyapps/jodija_tamplites/blob/master/doc/01_architecture/CONFIGURATION_GUIDE.ar.md) |
| **دليل Adaptive App Shell** | الدليل الكامل لتخصيص القوالب والـ Sidebar والأنيميشن | [ADAPTIVE_APP_SHELL_GUIDE.ar.md](https://github.com/zeftawyapps/jodija_tamplites/blob/master/doc/02_templates/ADAPTIVE_APP_SHELL_GUIDE.ar.md) |
| **دليل الأدوات المشتركة** | توثيق الـ Bloc، الجداول، التخزين، والتحقق | [SHARED_UTILS_GUIDE.ar.md](https://github.com/zeftawyapps/jodija_tamplites/blob/master/doc/03_utils/SHARED_UTILS_GUIDE.ar.md) |
| **دليل تكامل منظومة المتجر** | ربط Matger Management + Client مع Express | [MATGER_ECOSYSTEM_INTEGRATION.ar.md](https://github.com/zeftawyapps/jodija_tamplites/blob/master/doc/04_integrations/MATGER_ECOSYSTEM_INTEGRATION.ar.md) |
| **📖 فهرس الـ API الشامل** | مرجع مفصل يوثق كافة الأقسام والكلاسات المصدّرة | [API_REFERENCE.ar.md](https://github.com/zeftawyapps/jodija_tamplites/blob/master/doc/API_REFERENCE.ar.md) |

---

## 📄 الترخيص (License)
هذا المشروع مرخص بموجب رخصة MIT - راجع ملف [LICENSE](https://github.com/zeftawyapps/jodija_tamplites/blob/master/LICENSE) لمزيد من التفاصيل.
