<div align="center">

<img src="assets/jodija_logo.png" alt="شعار جوديجا - JoDija" width="160" style="border-radius: 16px; margin-bottom: 12px;" />

# 📚 بوابة التوثيق الرسمية لحزمة JoDija Templates
### *Simplifying Flutter Workflows And Universal Cross-Platform Solutions*

**الدليل التوثيقي الشامل والمعماري للمكتبة وكافة موديولاتها وأنظمتها**

---

### 🌐 اللغة / Language
[🇺🇸 **English Documentation Portal (README.md)**](README.md) • [📖 **فهرس الـ API الشامل (API_REFERENCE.ar.md)**](API_REFERENCE.ar.md)

---

</div>

مرحباً بك في بوابة التوثيق الرسمية لحزمة **JoDija Templates**. تم تقسيم التوثيق إلى أدلة متخصصة ومنظمة لتغطية كافة جوانب المعمارية، القوالب، الأدوات المشتركة، والتكامل مع الخوادم.

---

## 📸 معرض الواجهات الحية (Live UI Showcase)

تطبيقات حقيقية تعمل في بيئة الإنتاج مبنية باستخدام حزمة JoDija Templates مثل **Delta Mager Pro**:

<div align="center">
  <img src="assets/products_dashboard.jpg" alt="لوحة إدارة المنتجات Delta Mager Pro" width="85%" style="border-radius: 10px; margin: 10px; box-shadow: 0 4px 16px rgba(0,0,0,0.15);" />
  <p><em>لوحة تحكم المنتجات (Products Dashboard): قائمة جانبية متجاوبة وثيم زيتي مخصص مع دعم كامل لاتجاه RTL.</em></p>
  
  <img src="assets/categories_dashboard.jpg" alt="لوحة إدارة الفئات Delta Mager Pro" width="85%" style="border-radius: 10px; margin: 10px; box-shadow: 0 4px 16px rgba(0,0,0,0.15);" />
  <p><em>لوحة إدارة الفئات والكتالوج (Categories Dashboard): دعم شريط البحث السريع والـ Badges المخصصة.</em></p>
</div>

---

## 📑 خريطة وأدلة التوثيق (Documentation Map)

### 1. 🏛️ المعمارية والتأسيس (Architecture & Foundation)
- [📖 **الفلسفة المعمارية: الحلول الأحادية مقابل متعددة الحلول (PHILOSOPHY_AND_ARCHITECTURE.ar.md)**](01_architecture/PHILOSOPHY_AND_ARCHITECTURE.ar.md)
  - شرح معمارية الأنظمة الأحادية (`matger-client-app`) والأنظمة المتعددة (`matger-management-app`, `font logic`).
  - دور خادم `matger-express` في توفير عقود البيانات (API Contracts) والتهيئة الحية.
- [⚙️ **دليل الـ Configuration وموصل الشبكة (CONFIGURATION_GUIDE.ar.md)**](01_architecture/CONFIGURATION_GUIDE.ar.md)
  - شرح كلاس `DataViewConfigraion` لإدارة دورة حياة التطبيق والمسارات واللغات.
  - موصل الشبكة الموحد `AppHttpConnector` والتعامل مع طلبات الـ REST API.

### 2. 🧭 القوالب والشاشات التكيفية (Templates & Adaptive Shells)
- [📱 **دليل Adaptive App Shell الشامل (ADAPTIVE_APP_SHELL_GUIDE.ar.md)**](02_templates/ADAPTIVE_APP_SHELL_GUIDE.ar.md)
  - التبديل التلقائي بين القائمة الجانبية `Sidebar` على الويب/الديسكتوب، والـ `Drawer` أو `BottomNavigationBar` على الجوال.
  - تكوين وتخصيص الشريط العلوي `AppBarConfig` وقوائم التنقل `RouteItem`.
  - تخصيص الثيمات وألوان القوائم وأنماط الحركات والأنيميشن (`SidBarAnimationType`).

### 3. 🧩 الأدوات والخدمات المشتركة (Shared Utilities)
- [🛠️ **دليل الأدوات والخدمات المشتركة (SHARED_UTILS_GUIDE.ar.md)**](03_utils/SHARED_UTILS_GUIDE.ar.md)
  - **DataSourceBloc:** إدارة الحالات القياسية (Initial, Loading, Loaded, Error, Empty) وعمليات الـ CRUD الجاهزة.
  - **Cell Models:** تمثيل البيانات الذكي وجداول الحسابات والإحصائيات (`DataTableOfCellModels`).
  - **التخزين المحلي:** حفظ الجلسات (`SharedPrefranceData`) ودعم قواعد بيانات SQLite بدون إنترنت (`LocalDataHelper`).
  - **الترجمة واللغات:** دعم أصيل للغة العربية والـ RTL مع التبديل اللحظي للغة.
  - **التحقق من صحة المدخلات:** حقول ونماذج التحقق الجاهزة (`FormValidators`).

### 4. 🔗 التكامل والربط العملي (Ecosystem Integrations)
- [🌐 **دليل تكامل منظومة المتجر (MATGER_ECOSYSTEM_INTEGRATION.ar.md)**](04_integrations/MATGER_ECOSYSTEM_INTEGRATION.ar.md)
  - ربط تطبيق الإدارة `matger-management-app` مع الخادم المركزي `matger-express`.
  - ربط تطبيق العميل `matger-client-app` مع نفس الخادم ومشاركة النماذج وقواعد الأعمال.
  - إدارة مفاتيح المصادقة (Auth Tokens) وحالات الميزات (Feature Flags).

### 5. 🚀 دليل الاستخدام الشامل (Complete How-To-Use Guide)
- [📘 **دليل الاستخدام الشامل من الصفر إلى الإنتاج (HOW_TO_USE.ar.md)**](HOW_TO_USE.ar.md)
  - شرح تفصيلي خطوة بخطوة: التثبيت، التهيئة، بناء شاشات لوحة التحكم المتجاوبة، وإدارة البيانات.

### 6. 🧩 أدلة الكلاسات والودجات التفصيلية (Dedicated Widget & Class Guides)
- [📱 **دليل AdaptiveAppShell بالتفصيل**](05_widgets_and_classes/ADAPTIVE_APP_SHELL.ar.md)
- [⚡ **دليل DataSourceBloc وإدارة الحالة**](05_widgets_and_classes/DATA_SOURCE_BLOC.ar.md)
- [📊 **دليل Cell Models وجداول البيانات**](05_widgets_and_classes/CELL_MODELS_AND_TABLES.ar.md)
- [⚙️ **دليل توليد النماذج CellFieldBuilder**](05_widgets_and_classes/CELL_FIELD_BUILDER.ar.md)
- [💾 **دليل التخزين وقواعد بيانات SQLite**](05_widgets_and_classes/LOCAL_STORAGE_AND_SQLITE.ar.md)
- [✅ **دليل التحقق من النماذج FormValidation**](05_widgets_and_classes/FORM_VALIDATION.ar.md)
- [🎨 **دليل نظام الألوان والثيم الزيتي**](05_widgets_and_classes/THEMING_AND_DESIGN_SYSTEM.ar.md)
- [📸 **دليل ودجات ومعالجة الصور**](05_widgets_and_classes/IMAGE_PICKER_AND_LOADER.ar.md)

### 7. 📚 المرجع الشامل لكافة الكلاسات (Complete API Reference)
- [🔍 **فهرس الـ API الشامل لكافة كلاسات المكتبة (API_REFERENCE.ar.md)**](API_REFERENCE.ar.md)
  - توثيق تفصيلي باللغة العربية لكافة الأقسام الـ 24 المصدّرة في الحزمة.

---

## 🗂️ الأدلة التخصصية والمراجع الملحقة
- [INPUT_OUTPUT_CELL_BINDER_GUIDE.md](INPUT_OUTPUT_CELL_BINDER_GUIDE.md) - دليل محرك ربط الخلايا بالحقول الديناميكية.
- [ROUTED_CONTROL_PANEL_GUIDE.md](ROUTED_CONTROL_PANEL_GUIDE.md) - دليل لوحات التحكم الموجهة.
- [SCREEN_UTILS.md](SCREEN_UTILS.md) - أدوات التجاوب مع أحجام الشاشات المختلفة.
- [ANIMATION_TYPES_GUIDE.md](ANIMATION_TYPES_GUIDE.md) - دليل مؤثرات الانتقال وأنواع الأنيميشن.
