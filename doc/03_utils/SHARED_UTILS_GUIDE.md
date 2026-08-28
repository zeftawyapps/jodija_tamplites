# 🧩 دليل الأدوات المشتركة (Shared Utilities Guide)

تتضمن حزمة `JoDija Templates` مجموعة متكاملة من الأدوات التي توفر الوقت وتوحد منطق العمل عبر كافة التطبيقات.

---

## 1. طبقة إدارة الحالات والبيانات (`DataSourceBloc`)

### كلاس `FeaturDataSourceState`
يدير حالات الشاشة بطريقة موحدة ومنظمة:
- `listState`: حالة جلب قائمة البيانات بالكامل (`init`, `loading`, `loaded`, `error`).
- `itemState`: حالة عنصر محدد للعمليات الفردية (عرض، تعديل، حذف).
- `feadState`: حالة العمليات التفاعلية وإرسال النماذج.

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

## 2. محرك الجداول والخلايا الذكية (`Cell Models`)

### كلاس `DataTableOfCellModels`
يتيح التعامل مع كميات البيانات وتحويلها إلى جداول ديناميكية مع إمكانية التجميع الإحصائي:

```dart
final dataTable = DataTableOfCellModels<ProductCellModel>(productsList);

// استخراج المجموعات الفريدة
final uniqueCategories = dataTable.unicGrubs(dataTable.mapList, categoryCell);

// حساب إحصاءات التكرار
final counts = dataTable.countBy(dataTable.mapList, categoryCell);
```

---

## 3. التخزين المحلي والجلسات (`SharedPrefranceData`)

يوفر وصولاً سريعاً بنمط Singleton لإدارة بيانات المستخدم والتوكن المشترك مع السيرفر:

```dart
final prefs = SharedPrefranceData();

// قراءة توكن المصادقة
final token = prefs.sharedPrefrance.getString(SharedPrefranceData.USER_TOKen);

// حفظ حالة تسجيل الدخول
await prefs.sharedPrefrance.setBool(SharedPrefranceData.USER_ISREJESTED, true);
```

---

## 4. محرك اللغات والـ RTL (`LocalizationConfig`)

تهيئة اللغات ودعم اللغة العربية تلقائياً:

```dart
final locConfig = LocalizationConfig(
  localizedValues: {
    'ar': ArabicLocalizations(),
    'en': EnglishLocalizations(),
  },
);

// التبديل الفوري للغة
locConfig.setLocale(const Locale('ar'));
```

---

## 5. أدوات التحقق من المدخلات (Form Validators)

محققات جاهزة وسهلة الاستخدام في حقول الإدخال:
- `RequiredValidator(message: "هذا الحقل مطلوب")`
- `EmailValidator(message: "البريد الإلكتروني غير صحيح")`
- `PasswordValidator(minLength: 6)`
- `NumberValidator()`
