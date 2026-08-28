# 📚 JoDija Templates Documentation Portal (بوابة التوثيق الرسمية)

مرحباً بك في بوابة التوثيق الرسمية لحزمة **JoDija Templates**. تم تنظيم التوثيق في أدلة تخصصية لتسهيل الوصول والتطوير.

---

## 📸 Real UI Previews (معاينة القوالب الحية)

<div align="center">
  <img src="assets/products_dashboard.jpg" alt="Delta Mager Pro Products Dashboard" width="80%" style="border-radius: 8px; margin: 10px;" />
  <img src="assets/categories_dashboard.jpg" alt="Delta Mager Pro Categories Dashboard" width="80%" style="border-radius: 8px; margin: 10px;" />
</div>

---

## 📑 خريطة وأدلة التوثيق (Documentation Map)

### 1. المعمارية والتأسيس (Architecture & Foundation)
- [📖 الفلسفة المعمارية: الحلول الأحادية والمتعددة (PHILOSOPHY_AND_ARCHITECTURE.md)](01_architecture/PHILOSOPHY_AND_ARCHITECTURE.md)
  - شرح فلسفة الأنظمة الأحادية (`matger-client`) مقابل الأنظمة متعددة الحلول (`font logic`, `matger-management`).
  - دور `matger-express` كخادم مركزي لعقود الـ API والتهيئة الحية.
- [⚙️ دليل الـ Configuration الشامل (CONFIGURATION_GUIDE.md)](01_architecture/CONFIGURATION_GUIDE.md)
  - شرح كلاس `DataViewConfigraion` و `AppHttpConnector`.
  - إدارة المسارات واللغات والبيانات التأسيسية.

### 2. القوالب والواجهات المتجاوبة (Templates & Responsive Shells)
- [🧭 دليل Adaptive App Shell الشامل (ADAPTIVE_APP_SHELL_GUIDE.md)](02_templates/ADAPTIVE_APP_SHELL_GUIDE.md)
  - شرح خصائص الـ `Sidebar`, `Drawer`, `BottomNavBar`.
  - تخصيص ألوان الثيمات والأزرار وشريط الأدوات العلوي (`AppBarConfig`).
  - دمج وشرح أنماط وحركات الأنيميشن (`SidBarAnimationType`).

### 3. مكتبة الأدوات المشتركة (Shared Utilities)
- [🧩 دليل الأدوات المشتركة (SHARED_UTILS_GUIDE.md)](03_utils/SHARED_UTILS_GUIDE.md)
  - **DataSourceBloc:** إدارة حالات جلب وتحديث البيانات والـ CRUD.
  - **Cell Models:** جداول البيانات والحسابات الإحصائية (`DataTableOfCellModels`).
  - **SharedPreferences & SQLite:** إدارة الجلسات والـ Offline Caching.
  - **Localization & RTL:** محرك الترجمة واللغات المدمج.
  - **Form Validators:** أدوات التحقق من البريد وكلمات المرور والمدخلات.

### 4. أدلة التكامل العملي (Ecosystem Integrations)
- [🔗 دليل تكامل منظومة المتجر (MATGER_ECOSYSTEM_INTEGRATION.md)](04_integrations/MATGER_ECOSYSTEM_INTEGRATION.md)
  - كيفية ربط وتكامل `matger-management-app` مع `matger-express`.
  - كيفية ربط وتكامل `matger-client-app` مع نفس الخادم ومشاركة النماذج.
  - إدارة الـ API Endpoints، مفاتيح المصادقة، والـ Feature Flags.

---

## 🗂️ المراجع السابقة (Historical & Animation References)
للمزيد من التفاصيل المعمارية الدقيقة السابقة للأنيميشن والشاشات:
- [ANIMATION_TYPES_GUIDE.md](ANIMATION_TYPES_GUIDE.md)
- [SCREEN_UTILS.md](SCREEN_UTILS.md)
- [ROUTED_CONTROL_PANEL_GUIDE.md](ROUTED_CONTROL_PANEL_GUIDE.md)
