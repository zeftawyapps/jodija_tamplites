# 🚀 دليل الاستخدام الشامل لحزمة JoDija Templates (من الصفر إلى الاحتراف)

---

### 🌐 اللغة / Language
[🇺🇸 **English Version (HOW_TO_USE.md)**](HOW_TO_USE.md) • [📚 **بوابة التوثيق الرئيسية (README.ar.md)**](README.ar.md)

---

مرحباً بك في دليل الاستخدام الشامل لحزمة **`JoDija Templates`**. يهدف هذا الدليل إلى أخذك خطوة بخطوة من بداية تثبيت الحزمة وإعداد بيئة العمل وحتى بناء تطبيق كامل متجاوب يعمل على كافة الأجهزة (Desktop, Web, Tablet, Mobile) بنظام **RTL** واللغة العربية، مع إدارة الحالة وقاعدة بيانات SQLite ونماذج الإدخال الذكية.

---

## 📑 فهرس مراحل الدليل
1. [المرحلة 1: التثبيت والإعداد التأسيسي](#1-المرحلة-1-التثبيت-والإعداد-التأسيسي)
2. [المرحلة 2: إعداد كلاس الـ Configuration العام](#2-المرحلة-2-إعداد-كلاس-الـ-configuration-العام)
3. [المرحلة 3: تشغيل القالب التكيفي الذكي (AdaptiveAppShell)](#3-المرحلة-3-تشغيل-القالب-التكيفي-الذكي-adaptiveappshell)
4. [المرحلة 4: إدارة البيانات وحالات الشاشات عبر DataSourceBloc](#4-المرحلة-4-إدارة-البيانات-وحالات-الشاشات-عبر-datasourcebloc)
5. [المرحلة 5: بناء الجداول وحساب الإحصائيات عبر Cell Models](#5-المرحلة-5-بناء-الجداول-وحساب-الإحصائيات-عبر-cell-models)
6. [المرحلة 6: التوليد الديناميكي لنماذج الإدخال عبر CellFieldBuilder](#6-المرحلة-6-التوليد-الديناميكي-لنماذج-الإدخال-عبر-cellfieldbuilder)
7. [المرحلة 7: التخزين المحلي وقواعد البيانات SQLite](#7-المرحلة-7-التخزين-المحلي-وقواعد-البيانات-sqlite)
8. [المرحلة 8: الثيمات المخصصة وتغيير الخطوط](#8-المرحلة-8-الثيمات-المخصصة-وتغيير-الخطوط)

---

## 1. المرحلة 1: التثبيت والإعداد التأسيسي

أضف الحزمة مباشرة من GitHub إلى ملف `pubspec.yaml` في مشروعك:

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
> إذا كنت تعمل داخل مساحة عمل محلية متعددة الحزم (Monorepo Workspace)، يمكنك أيضاً ربطها محلياً عبر المسار (Path):
> ```yaml
> dependencies:
>   JoDija_tamplites:
>     path: ../tools/jodija_tamplites
> ```

ثم قم باستيراد المكتبة الرئيسية في ملف `main.dart`:

```dart
import 'package:JoDija_tamplites/JoDija_tamplites.dart';
```

> [!TIP]
> استيراد `JoDija_tamplites.dart` يوفر لك تلقائياً حزم `flutter_bloc`, `provider`, `go_router`, `sqflite`, `flutter_animate`, و `google_fonts` دون الحاجة لاستيرادها بشكل منفصل.

---

## 2. المرحلة 2: إعداد كلاس الـ Configuration العام

كلاس **`DataViewConfigraion`** هو الأساس لتوحيد هوية التطبيق، مسارات الشاشات، وإعدادات اللغة:

```dart
import 'package:flutter/material.dart';
import 'package:JoDija_tamplites/JoDija_tamplites.dart';

class MyAppConfig extends DataViewConfigraion {
  @override
  String get AppName => "نظام دلتا برو";

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
    // كود تحديث اتجاه ولغة التطبيق
  }
}
```

---

## 3. المرحلة 3: تشغيل القالب التكيفي الذكي (AdaptiveAppShell)

الـ `AdaptiveAppShell` يقوم تلقائياً بتبديل التخطيط:
- على الديسك توب والويب: قائمة جانبية مستمرة (`Sidebar`).
- على الجوال والتابلت: قائمة منزلقة (`Drawer`) أو شريط سفلي (`BottomNavigationBar`).

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
      titleApp: "لوحة تحكم دلتا",
      initRouter: "/products",
      languageCode: "ar", // تفعيل العربية ونظام RTL تلقائياً
      isDarkMode: false,
      
      // ثيم القائمة الجانبية (الثيم الزيتي المميز)
      sidebarBackgroundColor: const Color(0xFF556B2F),
      sidebarSelectedColor: Colors.white,
      sidebarTextColor: Colors.white,
      sidebarSelectedTextColor: const Color(0xFF556B2F),
      
      sidebarItems: [
        RouteItem(
          id: "dashboard",
          path: "/dashboard",
          label: "لوحة المؤشرات",
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
          label: "الفئات والكتالوج",
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

## 4. المرحلة 4: إدارة البيانات وحالات الشاشات عبر DataSourceBloc

تتيح لك الحزمة إدارة حالات جلب وتحديث البيانات دون تكرار الشفرات البرمجية:

### تعريف نموذج البيانات:
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

### استخدام `DataSourceBloc` في الشاشة:
```dart
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsBloc = DataSourceBloc<List<ProductModel>>();

    // محاكاة جلب البيانات
    productsBloc.loadingState();
    Future.delayed(const Duration(seconds: 1), () {
      productsBloc.successState([
        ProductModel(id: "1", title: "منتج تجريبي أ", price: 120.0),
        ProductModel(id: "2", title: "منتج تجريبي ب", price: 250.0),
      ]);
    });

    return Scaffold(
      body: BlocBuilder<DataSourceBloc<List<ProductModel>>,
          DataSourceBaseState<List<ProductModel>>>(
        bloc: productsBloc,
        builder: (context, state) {
          return state.when(
            init: () => const Center(child: Text("جاري التهيئة...")),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (data) => ListView.builder(
              itemCount: data?.length ?? 0,
              itemBuilder: (context, i) => ListTile(
                title: Text(data![i].title),
                subtitle: Text("${data[i].price} ج.م"),
              ),
            ),
            failure: (error, retry) => Center(
              child: ElevatedButton(
                onPressed: retry,
                child: const Text("إعادة المحاولة"),
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

## 5. المرحلة 5: بناء الجداول وحساب الإحصائيات عبر Cell Models

محرك الـ Cells يتيح لك تمثيل أي حقل ببياناته الوصفية والحسابية:

```dart
// 1. إنشاء خلايا البيانات
final nameCell = Cell<String>("product_name", caption: "اسم المنتج", value: "شاشة ذكية");
final priceCell = Cell<double>("price", caption: "السعر", value: 3500.0);
final categoryCell = Cell<String>("category", caption: "الفئة", value: "إلكترونيات");

// 2. تجميعها في صف
final row = RowofCells([nameCell, priceCell, categoryCell]);
print(row.getvalueBykeyname("product_name")); // شاشة ذكية
```

---

## 6. المرحلة 6: التوليد الديناميكي لنماذج الإدخال عبر CellFieldBuilder

بدلاً من كتابة عشرات الـ `TextFormField` يدوياً، يقوم `CellFieldBuilder` ببناء النموذج كاملاً من كائنات الـ `Cell`:

```dart
final form = ValidationsForm();

final nameField = CellFieldBuilder.buildField(
  cell: Cell<String>(
    "customer_name",
    caption: "اسم العميل",
    isRequired: true,
    hint: "أدخل اسم العميل ثلاثياً",
  ),
  form: form,
  onChanged: (val) => print("الاسم الجديد: $val"),
);

// عرض ودجة الإدخال الجاهزة في الواجهة:
Widget build(BuildContext context) {
  return Column(
    children: [
      nameField.textFormValidation,
      ElevatedButton(
        onPressed: () {
          if (form.valdate()) {
            print("البيانات صحيحة تماماً!");
          }
        },
        child: const Text("حفظ"),
      ),
    ],
  );
}
```

---

## 7. المرحلة 7: التخزين المحلي وقواعد البيانات SQLite

لحفظ البيانات محلياً للعمل بدون إنترنت (Offline First)، نستخدم `BaseCrudRepository`:

```dart
// 1. تعريف الكيان
class CustomerModel extends DataModel {
  final String name;
  CustomerModel({int? id, required this.name}) : super(id: id);

  @override
  Map<String, dynamic> toMap() => {'id': id, 'name': name};

  factory CustomerModel.fromMap(Map<String, dynamic> map) =>
      CustomerModel(id: map['id'], name: map['name']);
}

// 2. إنشاء المستودع
class CustomerRepository extends BaseCrudRepository<CustomerModel> {
  CustomerRepository()
      : super(
          tableName: "customers",
          primaryKeyColumn: "id",
          fromMap: (map) => CustomerModel.fromMap(map),
        );
}

// 3. العمليات المباشرة
void saveCustomer() async {
  final repo = CustomerRepository();
  await repo.insert(CustomerModel(name: "محمد أحمد"));
  final allCustomers = await repo.getAll();
}
```

---

## 8. المرحلة 8: الثيمات المخصصة وتغيير الخطوط

يمكنك تخصيص خطوط Google والألوان لتناسب هوية شركتك أو عميلك:

```dart
final customColors = AppColors(
  primary: const Color(0xFF556B2F), // الثيم الزيتي
  accent: const Color(0xFFFFA500),
);
```

---

## 📚 روابط للأدلة التخصصية لكل ودجة وكلاس
للاطلاع على الشرح المفصل لكل ودجة بمعاملاتها الكاملة:
- [دليل AdaptiveAppShell بالتفصيل](05_widgets_and_classes/ADAPTIVE_APP_SHELL.ar.md)
- [دليل DataSourceBloc بالتفصيل](05_widgets_and_classes/DATA_SOURCE_BLOC.ar.md)
- [دليل Cell Models والجداول بالتفصيل](05_widgets_and_classes/CELL_MODELS_AND_TABLES.ar.md)
- [دليل CellFieldBuilder للنماذج الذكية](05_widgets_and_classes/CELL_FIELD_BUILDER.ar.md)
- [دليل SQLite والتخزين المحلي](05_widgets_and_classes/LOCAL_STORAGE_AND_SQLITE.ar.md)
- [دليل التحقق من النماذج FormValidation](05_widgets_and_classes/FORM_VALIDATION.ar.md)
- [دليل الثيمات ونظام الألوان](05_widgets_and_classes/THEMING_AND_DESIGN_SYSTEM.ar.md)
- [دليل اختيار وعرض الصور](05_widgets_and_classes/IMAGE_PICKER_AND_LOADER.ar.md)
