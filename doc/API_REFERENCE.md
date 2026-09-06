# 📖 Complete Package API Reference Catalog

---

### 🌐 Language / اللغة
[🇸🇦 **النسخة العربية للمرجع (API_REFERENCE.ar.md)**](API_REFERENCE.ar.md) • [📚 **Documentation Portal (README.md)**](README.md)

---

This document provides a comprehensive, module-by-module reference catalog for all classes, mixins, enums, and interfaces exported by the **`JoDija Templates`** package across its 24 primary architectural sections.

---

## Quick Table of Contents
1. [Project Configuration & HTTP Connector](#1-project-configuration--http-connector)
2. [Themes, Colors & Design System](#2-themes-colors--design-system)
3. [Adaptive App Shell & Dashboard Templates](#3-adaptive-app-shell--dashboard-templates)
4. [Cell Engine & Dynamic Data Models](#4-cell-engine--dynamic-data-models)
5. [Local Storage, SQLite & CRUD](#5-local-storage-sqlite--crud)
6. [DataSourceBloc & Remote State](#6-datasourcebloc--remote-state)
7. [Cell Field Builder & Dynamic Binder](#7-cell-field-builder--dynamic-binder)
8. [Form Validation & Form Helpers](#8-form-validation--form-helpers)
9. [Form Validators](#9-form-validators)
10. [Standard Input Fields](#10-standard-input-fields)
11. [Collections & Data Grid Widgets](#11-collections--data-grid-widgets)
12. [DataSourceBloc Widgets](#12-datasourcebloc-widgets)
13. [Image Widgets & Image BLoC](#13-image-widgets--image-bloc)
14. [Screen Viewers & Notifiers](#14-screen-viewers--notifiers)
15. [Tabs & Pop-up Menus](#15-tabs--pop-up-menus)
16. [Application Global Settings](#16-application-global-settings)
17. [SharedPreferences & User Sessions](#17-sharedpreferences--user-sessions)
18. [Localization & Internationalization](#18-localization--internationalization)
19. [Navigation & Advanced Routing Services](#19-navigation--advanced-routing-services)
20. [Dependency Injection Locator](#20-dependency-injection-locator)
21. [Project Screen & Viewport Types](#21-project-screen--viewport-types)
22. [View Data Models & Group Models](#22-view-data-models--group-models)
23. [General Utility Functions & Helpers](#23-general-utility-functions--helpers)

---

### 1. Project Configuration & HTTP Connector
- **`DataViewConfigraion`**: The abstract foundation for any app. Standardizes application name, version, unique identifier, entry-point `launchScreen()`, route mapping `getRouters()`, and dynamic locale switching `setAppLocal()`.
- **`AppHttpConnector`**: Abstract networking client coordinating REST API operations, default headers, and Bearer JWT authorization tokens.

### 2. Themes, Colors & Design System
- **`AppColors`**: Curated palette covering primary, secondary, accent, surface, background, and typography tokens.
- **`AppThemes`**: Pre-configured Material light and dark themes integrated with Google Fonts.
- **`DashboardThemes`**: Dedicated color palettes for administration dashboards (such as the signature Olive Theme `0xFF556B2F`).
- **`AppDecorations` & `AppDimensions`**: Standardized margins, paddings, border radiuses, and elevation shadows.

### 3. Adaptive App Shell & Dashboard Templates
- **`AdaptiveAppShell`**: Core responsive container dynamically switching between a persistent `Sidebar` on Desktop/Web, and a collapsible `Drawer` or `BottomNavigationBar` on Mobile.
- **`RouteItem`**: Encapsulates route configurations (ID, path, icon, destination content, and visibility flags).
- **`AppBarConfig`**: Customization model for top app bar titles, actions, search inputs, and leading buttons.
- **`SidebarHeaderConfig`**: Header branding configuration for sidebars (logos, titles, profile badges).
- **`AppShellRouterMixin`**: Stateful widget mixin granting direct access to URL route parameters (`getPrams()`) and route navigation (`goRoute()`).
- **`SidBarAnimationType`**: Enum defining sidebar item entrance transitions (`slideAndFade`, `fadeOnly`, `scaleAndFade`).

### 4. Cell Engine & Dynamic Data Models
- **`Cell<T>`**: Generic unit representing an atomic data field. Encapsulates value, caption, `CellDataType`, validation flags, and formatting metadata.
- **`CellDataType`**: Supported field types (`text`, `number`, `date`, `dateTime`, `dropdown`, `repeater`, `boolean`, `image`).
- **`RowofCells`**: Represents a record row of cells with lookup and mutation helpers.
- **`DataTableOfCellModels<T>`**: High-density table calculation engine featuring distinct grouping (`unicGrubs`) and frequency counts (`countBy`).
- **`RepeaterCell`**: Specialized cell handling dynamic one-to-many list items.

### 5. Local Storage, SQLite & CRUD
- **`DataModel` & `BaseDataModel`**: Base classes providing `toMap()` and `fromMap()` serialization contracts.
- **`ICrud<T>`**: Contract for database operations (`insert`, `insertAll`, `getById`, `getAll`, `query`, `update`, `delete`, `deleteWhere`, `clear`).
- **`BaseCrudRepository<T>`**: Generic repository executing SQLite operations through `LocalDataHelper`.
- **`LocalDataHelper`**: Database lifecycle manager executing schema migrations and table creation.

### 6. DataSourceBloc & Remote State
- **`DataSourceBloc<T>`**: Specialized BLoC/Cubit streamlining data fetching and mutation lifecycles.
- **`DataSourceBaseState<T>`**: Standardized states (`init`, `loading`, `loaded`, `error`).
- **`FeaturDataSourceState<T>`**: Three-channel state model tracking `listState`, targeted `itemState`, and form mutation `feadState`.
- **`CrudBloc<T>`**: Pre-built BLoC extension providing ready-made CRUD events and handlers.

### 7. Cell Field Builder & Dynamic Binder
- **`CellFieldBuilder`**: Reactive engine compiling `Cell` models directly into interactive UI input widgets bound to `ValidationsForm`.
- **`Field`**: Configurable widget descriptor for form rendering and validation.
- **`DataTableFieldBinder`**: Binds cell models into data table columns and inline editors.

### 8. Form Validation & Form Helpers
- **`ValidationsForm`**: Central form coordinator validating all registered input items.
- **`InputValidationItem`**: Links input fields with their validation rules and localized feedback messages.
- **`TextFormValidation`**: Text field widget enhanced with built-in validation states and interactive feedback.
- **`DropDownValidation`**: Select dropdown widget with built-in validation.

### 9. Form Validators
- **`BaseValidator`**: Abstract contract for validation strategies.
- **`RequiredValidator`**: Ensures a field is not empty.
- **`EmailValidator`**: Validates RFC email syntax.
- **`PasswordValidator`**: Enforces minimum length and security strength.
- **`NumperValidator`**: Ensures numeric values fall within defined ranges.
- **`DateValidator`**: Validates calendar date formats.

### 10. Standard Input Fields
- **`InputTextField`**: Styled text field with prefix/suffix icons and theme integration.
- **`DropDownTextField`**: Flexible dropdown selector.
- **`DateTimeInputTextField`**: Date/time picker triggering native modal pickers.

### 11. Collections & Data Grid Widgets
- **`DataGridTable`**: Responsive table grid for multi-column record display.
- **`GroupListView`**: Grouped list view organizing items under category headers.
- **`GroupGridView`**: Adaptive grid view with category grouping.

### 12. DataSourceBloc Widgets
- **`DataSourceBlocBuilder<T>`**: Rebuilds UI based on `DataSourceBloc` states (loading, error, content).
- **`DataSourceBlocConsumer<T>`**: Combines reactive UI rebuilding with side-effect listeners (snackbars, dialogs).

### 13. Image Widgets & Image BLoC
- **`BlocImagePicker`**: Camera/gallery picker with integrated cropping and compression.
- **`ImageLoader`**: Resilient image widget with caching, placeholder fallbacks, and error handling.
- **`ImagBloc`**: BLoC managing image capture, uploading, and processing pipelines.

### 14. Screen Viewers & Notifiers
- **`ScreenViewer`**: Scoped screen builder driven by `ScreenStateNotifier`.
- **`ScreenNotifier`**: Lightweight `ChangeNotifier` managing local screen state without external BLoC boilerplate.

### 15. Tabs & Pop-up Menus
- **`TapWidget`**: Customizable tab bar with animated indicators and badge counters.
- **`PubUpMenu`**: Contextual pop-up action menu.

### 16. Application Global Settings
- **`SettingsProvider`**: Notifier managing user preferences (theme mode, active language, font scale).
- **`SettingsInherited`**: Inherited widget propagating settings down the widget hierarchy.

### 17. SharedPreferences & User Sessions
- **`SharedPrefranceData`**: Singleton wrapper around `SharedPreferences` managing auth tokens and user keys.
- **`ShardUserModel`**: Serialized user profile representation stored locally.

### 18. Localization & Internationalization
- **`AppLocalizations`**: Core translator looking up translated strings for active locales.
- **`AppLocalizationsInit`**: Initializes localization delegates and supported languages.

### 19. Navigation & Advanced Routing Services
- **`NavigationService`**: Global singleton enabling navigation without direct `BuildContext`.
- **`AppRoutes`**: Central route generator and page transition manager.

### 20. Dependency Injection Locator
- **`DependencyLocator`**: Service locator wrapper around `GetIt` for registering singletons and factories.

### 21. Project Screen & Viewport Types
- **`ProjectScreen`**: Standard scaffold template integrating app bars, status bars, and theme backgrounds.
- **`ScreenType`**: Viewport categorization enum (`Desktop`, `Tablet`, `Mobile`).

### 22. View Data Models & Group Models
- **`BaseViewDataModel`**: Base class for UI presentation models.
- **`DataGroupModel`**: Parent-child relationship container for nested collections.

### 23. General Utility Functions & Helpers
- **`ShowDialogHelper`**: Standardized dialogs, confirmation modals, and alert popups.
- **`DateTimeHelper`**: Multilingual date and time formatting utilities.
- **`ConsoleLog`**: Formatted debug logging with ANSI color highlights.
- **`JsonAssetReader` & `JsonFileManager`**: JSON serialization and file reading helpers.
