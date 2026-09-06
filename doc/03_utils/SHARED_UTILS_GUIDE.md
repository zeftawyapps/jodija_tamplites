# 🧩 Shared Utilities & Core Helpers Guide

---

### 🌐 Language / اللغة
[🇸🇦 **النسخة العربية (SHARED_UTILS_GUIDE.ar.md)**](SHARED_UTILS_GUIDE.ar.md) • [📚 **Documentation Index (README.md)**](../README.md)

---

The `JoDija Templates` package provides an extensive collection of utility layers that save development time and enforce unified architectural patterns across all apps.

---

## 1. Unified State & Data Layer (`DataSourceBloc`)

### The `FeaturDataSourceState` Class
Manages screen states in a predictable, multi-channel state machine:
- `listState`: Complete dataset fetch state (`init`, `loading`, `loaded`, `error`).
- `itemState`: Targeted single-entity operations (fetch single, edit, delete).
- `feadState`: Interactive mutation and feedback state for form submissions.

```dart
class ProductsBloc extends Bloc<ProductsEvent, FeaturDataSourceState<ProductModel>> {
  ProductsBloc() : super(FeaturDataSourceState.defaultState()) {
    on<LoadProductsEvent>((event, emit) async {
      emit(state.copyWith(listState: const DataSourceBaseState.loading()));
      try {
        final products = await api.getProducts();
        emit(state.copyWith(listState: DataSourceBaseState.loaded(data: products)));
      } catch (e) {
        emit(state.copyWith(listState: DataSourceBaseState.error(error: e.toString())));
      }
    });
  }
}
```

---

## 2. Smart Cell Engine & Tables (`Cell Models`)

### The `DataTableOfCellModels` Class
Enables high-density data parsing into flexible, reactive tabular grids with statistical grouping:

```dart
final dataTable = DataTableOfCellModels<ProductCellModel>(productsList);

// Extract distinct groups/categories
final uniqueCategories = dataTable.unicGrubs(dataTable.mapList, categoryCell);

// Calculate frequency aggregations
final counts = dataTable.countBy(dataTable.mapList, categoryCell);
```

---

## 3. Local Storage & Session Management (`SharedPrefranceData`)

Provides a clean singleton interface for persisting user profiles, authorization tokens, and device flags:

```dart
final prefs = SharedPrefranceData();

// Retrieve cached bearer JWT token
final token = prefs.sharedPrefrance.getString(SharedPrefranceData.USER_TOKen);

// Persist user authentication status
await prefs.sharedPrefrance.setBool(SharedPrefranceData.USER_ISREJESTED, true);
```

---

## 4. Native Localization & RTL Engine (`LocalizationConfig`)

Initializes multilingual bundles with automatic Arabic RTL direction switching:

```dart
final locConfig = LocalizationConfig(
  localizedValues: {
    'ar': ArabicLocalizations(),
    'en': EnglishLocalizations(),
  },
);

// Instant runtime locale change
locConfig.setLocale(const Locale('ar'));
```

---

## 5. Input Form Validators (`FormValidators`)

Pre-built, chainable validators with localized feedback messages:
- `RequiredValidator(message: "This field is required")`
- `EmailValidator(message: "Please enter a valid email address")`
- `PasswordValidator(minLength: 6)`
- `NumberValidator()`
