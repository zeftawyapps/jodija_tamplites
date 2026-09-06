# سجل التحديثات والإصدارات (Changelog & Release Notes)

All notable changes to the `JoDija_tamplites` package will be documented in this file.

---

## [3.0.3] - 2026-09-05

### 🇸🇦 التحديثات باللغة العربية (Arabic Release Notes)

#### 🌟 أبرز التغييرات والإضافات:
- **🎨 الهوية والشعار الرسمي (Official Branding & Identity):**
  - اعتماد وتوثيق الشعار الرسمي لحزمة **JODIJA** والسلوجان الرسمي:
    > *Simplifying Flutter Workflows And Universal Cross-Platform Solutions*
  - إضافة وتحديث أصول الشعار الرسمية داخل المستودع وبوابات التوثيق (`assets/` و `doc/assets/`).
- **🧩 محرك النماذج الديناميكية (CellFieldBuilder & Dynamic Form Binder):**
  - تقديم `CellFieldBuilder` لبناء نماذج الإدخال والإخراج الديناميكية المعتمدة على الـ Cells.
  - دعم تدفقات التخزين المحلي والعمليات (Local Storage CRUD Architecture).
- **🛠️ تحسينات التحقق ومعالجة الحقول (Input Validation Refactor):**
  - إعادة هيكلة وتطوير منطق التحقق من صحة المدخلات في `text_form_validation.dart` وإزالة الشفرات المكررة.

---

### 🇬🇧 English Release Notes

#### 🌟 Highlights & Major Changes:
- **🎨 Official Brand Identity & Logo:**
  - Integrated the official **JODIJA** brand logo and tagline:
    > *Simplifying Flutter Workflows And Universal Cross-Platform Solutions*
  - Added official logo assets across repository and documentation portals.
- **🧩 Dynamic Form Engine (CellFieldBuilder & Form Binder):**
  - Introduced `CellFieldBuilder` for cell-driven reactive input/output binding and dynamic form rendering.
  - Added local storage CRUD architecture workflows.
- **🛠️ Form Validation & Performance Refactoring:**
  - Simplified and optimized text form field validation in `text_form_validation.dart`.

---

## [1.5.0] - 2026-08-28

### 🇸🇦 التحديثات باللغة العربية (Arabic Release Notes)

#### 🌟 أبرز التغييرات والإضافات:
- **📸 معاينات بصرية حية للقوالب (Real UI Showcase):**
  - إضافة لقطات ومعاينات بصرية حقيقية لشاشات لوحات التحكم التفاعلية (مثل شاشات المنتجات والفئات في نظام Delta Mager Pro) بنظام RTL وقوائم Sidebar المتجاوبة.
- **🏛️ ترسيخ الفلسفة المعمارية (الحلول الأحادية vs متعددة الحلول):**
  - توثيق معمارية الحزمة ودعمها للتطبيقات أحادية الحلول (`matger-client-app`) والأنظمة متعددة الحلول والوحدات (`font logic` و `matger-management-app`).
  - توثيق الدور المحوري لخادم `matger-express` في توفير عقود البيانات (API Contracts) والتهيئة الديناميكية وحالات الميزات (Feature Flags).
- **⚙️ دليل الـ Configuration والتأسيس:**
  - توثيق شامل وموسع لكلاسات `DataViewConfigraion` و `AppHttpConnector` لتنظيم دورة حياة التطبيقات، المسارات، وإعدادات الشبكة.
- **🌍 دعم أصيل للغة العربية والـ RTL:**
  - إنشاء ملف `README.ar.md` المخصص بالكامل للغة العربية مع دليل شامل للترجمة، اتجاه النصوص، والخطوط العربية.
- **🧩 ترقية التوثيق المصدري الداخلي (DartDoc):**
  - إضافة توثيق قياسي ثنائي اللغة لكافة الكلاسات: `AdaptiveAppShell`, `RouteItem`, `AppBarConfig`, `DataSourceBloc`, `CellModels`, `SharedPrefranceData`, `AppColors`, `AppThemes`, `FormValidators`.
- **📚 إعادة هيكلة شاملة لبوابة التوثيق (`doc/`):**
  - تنظيم مجلد التوثيق إلى أدلة مصنفة (`01_architecture`, `02_templates`, `03_utils`, `04_integrations`).
  - إنشاء دليل التكامل الموحد لمنظومة المتجر `MATGER_ECOSYSTEM_INTEGRATION.md`.

---

### 🇬🇧 English Release Notes

#### 🌟 Highlights & Major Changes:
- **📸 Real UI Showcase & Live Visuals:**
  - Added real-world visual screenshots showcasing the interactive dashboard templates (e.g., Delta Mager Pro products and categories screens) in native RTL and responsive Sidebar themes.
- **🏛️ Core Architecture Philosophy (Single vs Multi-Solution Ecosystems):**
  - Established and documented support for both Single-Solution apps (`matger-client-app`) and Multi-Solution modular platforms (`font logic`, `matger-management-app`).
  - Documented the central role of `matger-express` as the unified backend for API contracts, dynamic configurations, and feature flags.
- **⚙️ Foundation & Central Configuration Guide:**
  - Comprehensive documentation for `DataViewConfigraion` and `AppHttpConnector` to standardize app lifecycle, routing tables, and HTTP/API clients.
- **🌍 Native RTL & Arabic Localization Support:**
  - Introduced the comprehensive `README.ar.md` alongside in-depth guides for text direction, dynamic language switching, and Arabic typography.
- **🧩 Enhanced In-Code DartDoc Documentation:**
  - Added standard bilingual doc comments across core modules: `AdaptiveAppShell`, `RouteItem`, `AppBarConfig`, `DataSourceBloc`, `CellModels`, `SharedPrefranceData`, `AppColors`, `AppThemes`, and `FormValidators`.
- **📚 Modern Documentation Hierarchy (`doc/`):**
  - Restructured the documentation directory into dedicated folders (`01_architecture`, `02_templates`, `03_utils`, `04_integrations`).
  - Added the end-to-end `MATGER_ECOSYSTEM_INTEGRATION.md` guide.
