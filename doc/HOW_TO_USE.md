# 🚀 Comprehensive End-to-End Guide for JoDija Templates (From Zero to Production)

---

### 🌐 Language / اللغة
[🇸🇦 **النسخة العربية (HOW_TO_USE.ar.md)**](HOW_TO_USE.ar.md) • [📚 **Documentation Portal (README.md)**](README.md)

---

Welcome to the comprehensive, step-by-step developer tutorial for **`JoDija Templates`**. This guide walks you through package installation, foundation architecture, responsive adaptive shells with native **RTL/Arabic** support, state management with `DataSourceBloc`, intelligent cell-based tables, SQLite persistence, and dynamic form generators.

---

## 📑 Table of Contents
1. [Step 1: Installation & Foundation Setup](#1-step-1-installation--foundation-setup)
2. [Step 2: Configuring Foundation Settings (`DataViewConfigraion`)](#2-step-2-configuring-foundation-settings-dataviewconfigraion)
3. [Step 3: Launching the Adaptive Application Shell (`AdaptiveAppShell`)](#3-step-3-launching-the-adaptive-application-shell-adaptiveappshell)
4. [Step 4: State Management & Remote Data with `DataSourceBloc`](#4-step-4-state-management--remote-data-with-datasourcebloc)
5. [Step 5: Smart Data Grids & Calculations with `Cell Models`](#5-step-5-smart-data-grids--calculations-with-cell-models)
6. [Step 6: Dynamic Form Generation via `CellFieldBuilder`](#6-step-6-dynamic-form-generation-via-cellfieldbuilder)
7. [Step 7: Local Storage & Offline SQLite Persistence](#7-step-7-local-storage--offline-sqlite-persistence)
8. [Step 8: Custom Enterprise Theming & Brand Palettes](#8-step-8-custom-enterprise-theming--brand-palettes)

---

## 1. Step 1: Installation & Foundation Setup

Add `JoDija_tamplites` directly from GitHub to your application's `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  JoDija_tamplites:
    git:
      url: https://github.com/zeftawyapps/jodija_tamplites.git
      ref: master
```

> [!NOTE]
> If you are working in a local multi-package workspace/monorepo, you can also link it locally via path:
> ```yaml
> dependencies:
>   JoDija_tamplites:
>     path: ../tools/jodija_tamplites
> ```

Import the unified package header into `main.dart`:

```dart
import 'package:JoDija_tamplites/JoDija_tamplites.dart';
```

> [!TIP]
> Importing `JoDija_tamplites.dart` automatically re-exports essential production packages including `flutter_bloc`, `provider`, `go_router`, `sqflite`, `flutter_animate`, and `google_fonts`.

---

## 2. Step 2: Configuring Foundation Settings (`DataViewConfigraion`)

Subclass **`DataViewConfigraion`** to establish global app identity, routing endpoints, and dynamic locale switching:

```dart
import 'package:flutter/material.dart';
import 'package:JoDija_tamplites/JoDija_tamplites.dart';

class MyAppConfig extends DataViewConfigraion {
  @override
  String get AppName => "Delta Pro System";

  @override
  String get AppNameID => "delta_pro_system";

  @override
  String get Version => "3.0.3";

  @override
  Widget launchScreen() => const DashboardScreen();

  @override
  Map<String, Widget> getRouters() => {
    '/dashboard': const DashboardScreen(),
    '/products': const ProductsScreen(),
    '/categories': const CategoriesScreen(),
  };

  @override
  void setAppLocal(String localCode) {
    // Dynamic locale handling and RTL adjustment
  }
}
```

---

## 3. Step 3: Launching the Adaptive Application Shell (`AdaptiveAppShell`)

`AdaptiveAppShell` automatically adapts its layout:
- **Desktop & Web:** Persistent, collapsible `Sidebar` with active route highlighting.
- **Mobile & Tablet:** Responsive `Drawer` or thumb-friendly `BottomNavigationBar`.

```dart
import 'package:flutter/material.dart';
import 'package:JoDija_tamplites/JoDija_tamplites.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveAppShell(
      titleApp: "Delta Mager Pro",
      initRouter: "/products",
      languageCode: "en", // Set 'ar' for automatic native RTL mirroring
      isDarkMode: false,
      
      // Sidebar Enterprise Olive Palette
      sidebarBackgroundColor: const Color(0xFF556B2F),
      sidebarSelectedColor: Colors.white,
      sidebarTextColor: Colors.white,
      sidebarSelectedTextColor: const Color(0xFF556B2F),
      
      sidebarItems: [
        RouteItem(
          id: "dashboard",
          path: "/dashboard",
          label: "Dashboard",
          icon: Icons.dashboard_outlined,
          content: const DashboardScreen(),
          isSideBarRouted: true,
          isAppBar: true,
        ),
        RouteItem(
          id: "products",
          path: "/products",
          label: "Products",
          icon: Icons.inventory_2_outlined,
          content: const ProductsScreen(),
          isSideBarRouted: true,
          isAppBar: true,
        ),
        RouteItem(
          id: "categories",
          path: "/categories",
          label: "Categories",
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

## 4. Step 4: State Management & Remote Data with `DataSourceBloc`

Eliminate boilerplate when fetching, updating, and rendering datasets:

### Define the Presentation Model:
```dart
class ProductModel extends BaseViewDataModel {
  final String title;
  final double price;

  ProductModel({required String id, required this.title, required this.price})
      : super(id);

  @override
  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'price': price};
}
```

### Consume State in the UI:
```dart
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsBloc = DataSourceBloc<List<ProductModel>>();

    // Simulate API fetch
    productsBloc.loadingState();
    Future.delayed(const Duration(seconds: 1), () {
      productsBloc.successState([
        ProductModel(id: "1", title: "Enterprise Smart Screen", price: 1200.0),
        ProductModel(id: "2", title: "Wireless Barcode Scanner", price: 450.0),
      ]);
    });

    return Scaffold(
      body: BlocBuilder<DataSourceBloc<List<ProductModel>>,
          DataSourceBaseState<List<ProductModel>>>(
        bloc: productsBloc,
        builder: (context, state) {
          return state.when(
            init: () => const Center(child: Text("Initializing...")),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (data) => ListView.builder(
              itemCount: data?.length ?? 0,
              itemBuilder: (context, i) => ListTile(
                title: Text(data![i].title),
                subtitle: Text("\$${data[i].price}"),
              ),
            ),
            failure: (error, retry) => Center(
              child: ElevatedButton(
                onPressed: retry,
                child: const Text("Retry"),
              ),
            ),
          );
        },
      ),
    );
  }
}
```

---

## 5. Step 5: Smart Data Grids & Calculations with `Cell Models`

The Cell Engine models atomic data points alongside metadata and statistical grouping:

```dart
// 1. Instantiate smart cells
final nameCell = Cell<String>("product_name", caption: "Product Name", value: "Smart TV");
final priceCell = Cell<double>("price", caption: "Price", value: 3500.0);
final categoryCell = Cell<String>("category", caption: "Category", value: "Electronics");

// 2. Compose into a row
final row = RowofCells([nameCell, priceCell, categoryCell]);
print(row.getvalueBykeyname("product_name")); // Smart TV
```

---

## 6. Step 6: Dynamic Form Generation via `CellFieldBuilder`

Automatically bind and render reactive form input widgets directly from `Cell` instances:

```dart
final form = ValidationsForm();

final nameField = CellFieldBuilder.buildField(
  cell: Cell<String>(
    "customer_name",
    caption: "Customer Name",
    isRequired: true,
    hint: "Enter full customer name",
  ),
  form: form,
  onChanged: (val) => print("Updated: $val"),
);

// Render the generated input widget
Widget build(BuildContext context) {
  return Column(
    children: [
      nameField.textFormValidation,
      ElevatedButton(
        onPressed: () {
          if (form.valdate()) {
            print("Form input verified successfully!");
          }
        },
        child: const Text("Submit"),
      ),
    ],
  );
}
```

---

## 7. Step 7: Local Storage & Offline SQLite Persistence

Subclass `BaseCrudRepository` to gain zero-boilerplate SQLite operations:

```dart
// 1. Define Entity
class CustomerModel extends DataModel {
  final String name;
  CustomerModel({int? id, required this.name}) : super(id: id);

  @override
  Map<String, dynamic> toMap() => {'id': id, 'name': name};

  factory CustomerModel.fromMap(Map<String, dynamic> map) =>
      CustomerModel(id: map['id'], name: map['name']);
}

// 2. Instantiate Repository
class CustomerRepository extends BaseCrudRepository<CustomerModel> {
  CustomerRepository()
      : super(
          tableName: "customers",
          primaryKeyColumn: "id",
          fromMap: (map) => CustomerModel.fromMap(map),
        );
}

// 3. Perform CRUD Operations
void saveCustomer() async {
  final repo = CustomerRepository();
  await repo.insert(CustomerModel(name: "Alexander Smith"));
  final customers = await repo.getAll();
}
```

---

## 8. Step 8: Custom Enterprise Theming & Brand Palettes

Tailor color tokens and Google Fonts to match your exact brand identity:

```dart
final customColors = AppColors(
  primary: const Color(0xFF556B2F), // Signature Olive theme
  accent: const Color(0xFFFFA500),
);
```

---

## 📚 Dedicated Widget & Class Markdown Guides
For comprehensive parameter breakdowns and isolated runnable examples for each component:
- [AdaptiveAppShell Detailed Guide](05_widgets_and_classes/ADAPTIVE_APP_SHELL.md)
- [DataSourceBloc Detailed Guide](05_widgets_and_classes/DATA_SOURCE_BLOC.md)
- [Cell Models & Data Tables Guide](05_widgets_and_classes/CELL_MODELS_AND_TABLES.md)
- [CellFieldBuilder Dynamic Forms Guide](05_widgets_and_classes/CELL_FIELD_BUILDER.md)
- [SQLite & Local Storage Guide](05_widgets_and_classes/LOCAL_STORAGE_AND_SQLITE.md)
- [Form Validation & Validators Guide](05_widgets_and_classes/FORM_VALIDATION.md)
- [Theming & Color Palettes Guide](05_widgets_and_classes/THEMING_AND_DESIGN_SYSTEM.md)
- [Image Picker & Caching Loader Guide](05_widgets_and_classes/IMAGE_PICKER_AND_LOADER.md)
