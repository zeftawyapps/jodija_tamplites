<div align="center">

<img src="assets/jodija_logo.png" alt="JoDija Official Logo" width="160" style="border-radius: 16px; margin-bottom: 12px;" />

# 📚 JoDija Templates Documentation Portal
### *Simplifying Flutter Workflows And Universal Cross-Platform Solutions*

**Comprehensive Architecture & API Reference for the Entire Package Ecosystem**

---

### 🌐 Language / اللغة
[🇸🇦 **بوابة التوثيق باللغة العربية (README.ar.md)**](README.ar.md) • [📖 **Complete API Reference (API_REFERENCE.md)**](API_REFERENCE.md)

---

</div>

Welcome to the official documentation portal for **JoDija Templates**. The documentation is organized into modular guides covering architecture, responsive shells, shared utilities, and server integration.

---

## 📸 Real UI Showcase

Production applications powered by **JoDija Templates**, including **Delta Mager Pro**:

<div align="center">
  <img src="assets/products_dashboard.jpg" alt="Delta Mager Pro Products Dashboard" width="85%" style="border-radius: 10px; margin: 10px; box-shadow: 0 4px 16px rgba(0,0,0,0.15);" />
  <p><em><strong>Products Dashboard:</strong> Responsive RTL Sidebar with custom Olive Theme, filter chips, card grid, and badges.</em></p>
  
  <img src="assets/categories_dashboard.jpg" alt="Delta Mager Pro Categories Dashboard" width="85%" style="border-radius: 10px; margin: 10px; box-shadow: 0 4px 16px rgba(0,0,0,0.15);" />
  <p><em><strong>Categories & Catalog Dashboard:</strong> Active sidebar item highlight, instant search bar, and action buttons.</em></p>
</div>

---

## 📑 Documentation Map

### 1. 🏛️ Architecture & Foundation
- [📖 **Philosophy & Architecture: Single vs Multi-Solution (PHILOSOPHY_AND_ARCHITECTURE.md)**](01_architecture/PHILOSOPHY_AND_ARCHITECTURE.md)
  - Architectural patterns for Single-Solution apps (`matger-client-app`) vs Multi-Solution platforms (`matger-management-app`, `font logic`).
  - The central role of `matger-express` providing live API contracts and feature flags.
- [⚙️ **Configuration & HTTP Connector Guide (CONFIGURATION_GUIDE.md)**](01_architecture/CONFIGURATION_GUIDE.md)
  - Overview of `DataViewConfigraion` for application lifecycle, route mapping, and locales.
  - Unified HTTP connector `AppHttpConnector` for resilient REST operations.

### 2. 🧭 Templates & Responsive Shells
- [📱 **Adaptive App Shell Guide (ADAPTIVE_APP_SHELL_GUIDE.md)**](02_templates/ADAPTIVE_APP_SHELL_GUIDE.md)
  - Auto-switching between persistent `Sidebar` (Desktop/Web) and collapsible `Drawer` or `BottomNavigationBar` (Mobile/Tablet).
  - App bar customization via `AppBarConfig` and route management with `RouteItem`.
  - Theming, sidebar color schemes, and transition animations (`SidBarAnimationType`).

### 3. 🧩 Shared Utilities
- [🛠️ **Shared Utilities Guide (SHARED_UTILS_GUIDE.md)**](03_utils/SHARED_UTILS_GUIDE.md)
  - **DataSourceBloc:** Standardized state management (Initial, Loading, Loaded, Error, Empty) with pre-built CRUD actions.
  - **Cell Models:** Composable data representations and table analytics (`DataTableOfCellModels`).
  - **Local Storage:** Session management via `SharedPrefranceData` and offline SQLite caching with `LocalDataHelper`.
  - **Localization & RTL:** Native Arabic/RTL support with dynamic runtime language switching.
  - **Form Validation:** Reusable validators and form helpers (`FormValidators`).

### 4. 🔗 Ecosystem Integration
- [🌐 **Matger Ecosystem Integration Guide (MATGER_ECOSYSTEM_INTEGRATION.md)**](04_integrations/MATGER_ECOSYSTEM_INTEGRATION.md)
  - Connecting `matger-management-app` with the central `matger-express` backend.
  - Connecting `matger-client-app` with the shared API and reusing data contracts.
  - Managing authentication tokens and live feature toggles.

### 5. 🚀 Complete How-To-Use Guide
- [📘 **Complete End-to-End Tutorial (HOW_TO_USE.md)**](HOW_TO_USE.md)
  - Step-by-step developer tutorial: installation, foundation setup, responsive dashboard creation, and state management.

### 6. 🧩 Dedicated Widget & Class Guides
- [📱 **AdaptiveAppShell & RouteItem Guide**](05_widgets_and_classes/ADAPTIVE_APP_SHELL.md)
- [⚡ **DataSourceBloc & State Management Guide**](05_widgets_and_classes/DATA_SOURCE_BLOC.md)
- [📊 **Cell Models & Analytical Grids Guide**](05_widgets_and_classes/CELL_MODELS_AND_TABLES.md)
- [⚙️ **CellFieldBuilder Dynamic Form Generator**](05_widgets_and_classes/CELL_FIELD_BUILDER.md)
- [💾 **Local Storage & SQLite Architecture Guide**](05_widgets_and_classes/LOCAL_STORAGE_AND_SQLITE.md)
- [✅ **Form Validation & Validators Guide**](05_widgets_and_classes/FORM_VALIDATION.md)
- [🎨 **Theming, Colors & Olive Dashboard Guide**](05_widgets_and_classes/THEMING_AND_DESIGN_SYSTEM.md)
- [📸 **Image Picker & Resilient Loader Guide**](05_widgets_and_classes/IMAGE_PICKER_AND_LOADER.md)

### 7. 📚 Complete API Reference
- [🔍 **Complete API Reference Catalog (API_REFERENCE.md)**](API_REFERENCE.md)
  - In-depth documentation covering all 24 exported modules and classes in the library.

---

## 🗂️ Specialized & Historical References
- [INPUT_OUTPUT_CELL_BINDER_GUIDE.md](INPUT_OUTPUT_CELL_BINDER_GUIDE.md) - Cell-to-field dynamic form binding guide.
- [ROUTED_CONTROL_PANEL_GUIDE.md](ROUTED_CONTROL_PANEL_GUIDE.md) - Routed dashboard and control panel architecture.
- [SCREEN_UTILS.md](SCREEN_UTILS.md) - Screen adaptation and responsiveness helpers.
- [ANIMATION_TYPES_GUIDE.md](ANIMATION_TYPES_GUIDE.md) - Transition effects and animation parameters.
