# 📘 الدليل الشامل لمحرك ربط وتوليد الحقول: Input & Output Cell Binder
### `JoDija Templates — Cell Field Engine Architecture`

---

## 🌟 1. الفلسفة المعمارية والهدف (Architecture & Philosophy)

في تطوير تطبيقات فلاتر الكبيرة (مثل الأنظمة الطبية، لوحات التحكم، وتطبيقات التجارة الإلكترونية)، يواجه المطورون مشكلة شائعة وهي **تكرار كتابة الكود (Boilerplate Code)** لنفس الحقول عدة مرات:
1. كتابة كود شاشة الإدخال (Form Fields, Controllers, FocusNodes, Validators).
2. كتابة كود شاشة العرض (Read-only Cards, Detail Views).
3. كتابة كود رؤوس الجداول وشبكات البيانات (Data Table Headers & Cells).
4. كتابة كود التحقق واستخراج وتعبئة البيانات من وإلى JSON.

### 💡 الحل في JoDija Templates:
تم ابتكار نظام **`Input & Output Cell Binder`** لتطبيق مبدأ **(Single Source of Truth)**؛ حيث تقوم بتعريف خصائص البيانات مرة واحدة فقط داخل كلاس مشتق من `CellModel`، ويقوم المحرك تلقائياً وبأعلى كفاءة بتوليد:
* **واجهات الإدخال والتحقق التلقائية (`inputField`):** حقول نصية، رقمية، قوائم، تواريخ، مفاتيح منطقية، وقوائم تكرارية متداخلة مزودة بالـ Validators والمتحكمات.
* **واجهات العرض للقراءة فقط (`outputField`):** بطاقات عرض مهيأة ومنسقة مع وحدات القياس (Units) والأيقونات وحالات الـ Boolean.
* **رؤوس وأعمدة الجداول (`header`):** متوافقة مباشرة مع `DataTableGrid` ومكونات الـ Data Grid.

```
                  ┌─────────────────────────────────────┐
                  │       CellModel (Data Schema)       │
                  │  (Name, Type, Validation, Unit...)  │
                  └──────────────────┬──────────────────┘
                                     │
                        CellFieldBuilder Engine
                                     │
         ┌───────────────────────────┼───────────────────────────┐
         ▼                           ▼                           ▼
┌─────────────────┐         ┌─────────────────┐         ┌─────────────────┐
│   inputField    │         │   outputField   │         │     header      │
│  واجهة الإدخال  │         │   واجهة العرض   │         │    رأس العمود   │
│  (Form Inputs)  │         │ (Read-only View)│         │  (Table Header) │
└─────────────────┘         └─────────────────┘         └─────────────────┘
```

---

## 🧱 2. المكونات الأساسية للنظام (Core Components)

يتكون المحرك من 5 كلاسات رئيسية تعمل معاً بتناغم تام:

### 1️⃣ `Cell<T>` & `CellDataType`
تمثل الخلية الوحدة الذرية للبيانات (Atomic Data Unit). تحتوي على:
* `name`: المعرف البرمجي الفريد للحقل (مفتاح الـ JSON).
* `caption`: الاسم المعروض للمستخدم في الواجهة.
* `type`: نوع البيانات من خلال الـ `enum CellDataType`.
* `isRequired`: هل الحقل إلزامي (يولد `RequiredValidator` تلقائياً).
* `unit`: وحدة القياس المعروضة بجانب الحقل (مثل: `mg/dL`, `سنة`, `ر.س`).
* `options`: خيارات القائمة المنسدلة (في حالة `CellDataType.dropdown`).
* `hint`: النص التوضيحي داخل الحقل.
* `defaultValue` & `value`: القيمة الافتراضية والقيمة الحالية.

#### 📊 أنواع البيانات المدعومة في `CellDataType`:
| النوع | الوصف | الويدجت المولد في الإدخال | الميزات التلقائية |
| :--- | :--- | :--- | :--- |
| `text` | نص عادي | `TextFomrFildValidtion` | لوحة مفاتيح نصية |
| `multilineText` | نص متعدد الأسطر | `TextFomrFildValidtion` | 4 أسطر مع تمدد تلقائي |
| `integer` | رقم صحيح | `TextFomrFildValidtion` | لوحة أرقام + فلترة تمنع الحروف |
| `decimal` | رقم عشري | `TextFomrFildValidtion` | لوحة أرقام + قبول الفاصلة العشرية |
| `measuredValue` | قيمة قياسية بوحدة | `TextFomrFildValidtion` | عرض وحدة القياس `unit` كـ Suffix |
| `dropdown` | قائمة خيارات | `DrobDaownValidation` | قائمة منسدلة مع التحقق الإلزامي |
| `boolean` | قيمة منطقية (نعم/لا) | `SwitchListTile` | زر تبديل مع أيقونة وحالة ملونة |
| `date` / `dateTime` | تاريخ / وقت | `DatePickerField` | نافذة اختيار التاريخ والتهيئة بتنسيق ISO |
| `email` | بريد إلكتروني | `TextFomrFildValidtion` | تحقق تلقائي عبر `EmailValidator` |
| `phone` | رقم هاتف | `TextFomrFildValidtion` | لوحة اتصال وفلترة للأرقام وعلامة `+` |
| `password` | كلمة مرور | `TextFomrFildValidtion` | إخفاء النص المشفر |
| `repeater` | قائمة مصفوفية متكررة | `DynamicRepeaterWidget` | إضافة/حذف صفوف بحقول فرعية متكاملة |

---

### 2️⃣ `RepeaterCell` (الجداول والقوائم التكرارية المتداخلة)
تتيح إضافة مصفوفات كائنات (Array of Objects) كحقل داخل النموذج مع تحديد مخطط الحقول الفرعية (`subCellsSchema`):
```dart
final medications = RepeaterCell(
  'medications',
  caption: 'قائمة الأدوية الموصوفة',
  addItemLabel: 'إضافة دواء جديد +',
  subCellsSchema: [
    Cell<String>('drugName', caption: 'اسم الدواء', type: CellDataType.text),
    Cell<String>('dosage', caption: 'الجرعة', type: CellDataType.text, unit: 'mg'),
  ],
);
```

---

### 3️⃣ `Field<T>` (كائن الحقل الشامل)
يرث من `Cell<T>` ويضيف عناصر الواجهة المرتبطة بالخلية:
* `inputField`: ويدجت الإدخال الجاهز للعرض في الاستمارات.
* `outputField`: ويدجت العرض المنسق الجاهز للعرض في بطاقات التفاصيل.
* `header`: ويدجت عنوان العمود لاستخدامه في الجداول.
* `controller`: متحكم `TextEditingController` مدمج ومحدث تلقائياً.

---

### 4️⃣ `FeildModelBinder<T extends CellModel>` (الحاوية المنسقة)
يمثل الوسيط بين النموذج (`CellModel`) وواجهات المستخدم، ويوفر دوال سريعة:
* `binder.getInputWidgets()`: تعيد قائمة بجميع ويدجات الإدخال الجاهزة للتمرير مباشرة لـ `Column` أو `ValidationsForm`.
* `binder.getOutputWidgets()`: تعيد قائمة بجميع ويدجات العرض للقراءة فقط.
* `binder.getHeaderWidgets()`: تعيد قائمة برؤوس الأعمدة.
* `binder.getField('fieldName')`: للوصول إلى حقل معين وتعديله أو عرضه منفرداً.

---

### 5️⃣ `CellFieldBuilder` (المحرك والمولد المركزي)
الكلاس المسؤول عن البناء والتحويل الذكي:
```dart
// بناء الحقول وربطها بنظام التحقق في سطر واحد
final binder = CellFieldBuilder.buildBinderFromModel(
  model: myModel,
  form: myValidationForm,
  onFieldChanged: (cellName, newValue) {
    print('تم تعديل الحقل: $cellName إلى: $newValue');
  },
);
```

---

## 🚀 3. خطوات بناء شاشة متكاملة خطوة بخطوة

### 📝 الخطوة 1: إنشاء نموذج البيانات (Define the CellModel)
قم بإنشاء كلاس يرث من `CellModel` وعرف الحقول كمتغيرات من نوع `Cell`:

```dart
import 'package:JoDija_tamplites/JoDija_tamplites.dart';

class PatientIntakeModel extends CellModel {
  // حقل نصي إلزامي
  final fullName = Cell<String>(
    'fullName',
    caption: 'اسم المريض',
    type: CellDataType.text,
    isRequired: true,
    hint: 'أدخل الاسم الثلاثي',
  );

  // حقل رقمي مع وحدة قياس
  final age = Cell<int>(
    'age',
    caption: 'العمر',
    type: CellDataType.integer,
    unit: 'سنة',
    isRequired: true,
  );

  // قائمة منسدلة
  final bloodGroup = Cell<String>(
    'bloodGroup',
    caption: 'فصيلة الدم',
    type: CellDataType.dropdown,
    options: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
    isRequired: true,
  );

  // قيمة قياسية
  final bloodSugar = Cell<double>(
    'bloodSugar',
    caption: 'مستوى السكر العشوائي',
    type: CellDataType.measuredValue,
    unit: 'mg/dL',
  );

  // قيمة منطقية
  final isSmoker = Cell<bool>(
    'isSmoker',
    caption: 'هل المريض مدخن؟',
    type: CellDataType.boolean,
    defaultValue: false,
  );

  // تاريخ
  final visitDate = Cell<String>(
    'visitDate',
    caption: 'تاريخ الزيارة',
    type: CellDataType.date,
  );

  // حقل تكراري للأدوية
  final medications = RepeaterCell(
    'medications',
    caption: 'الأدوية الحالية',
    addItemLabel: 'إضافة دواء +',
    subCellsSchema: [
      Cell<String>('name', caption: 'اسم الدواء', type: CellDataType.text),
      Cell<String>('dose', caption: 'الجرعة', type: CellDataType.text, unit: 'mg'),
    ],
  );

  // تجميع الخلايا في مصفوفة
  @override
  List<Cell> toCells() {
    return [
      fullName,
      age,
      bloodGroup,
      bloodSugar,
      isSmoker,
      visitDate,
      medications,
    ];
  }
}
```

---

### 🎨 الخطوة 2: بناء الشاشة التفاعلية (The Complete Screen)

```dart
import 'package:flutter/material.dart';
import 'package:JoDija_tamplites/JoDija_tamplites.dart';

class PatientIntakeScreen extends StatefulWidget {
  const PatientIntakeScreen({super.key});

  @override
  State<PatientIntakeScreen> createState() => _PatientIntakeScreenState();
}

class _PatientIntakeScreenState extends State<PatientIntakeScreen> {
  // 1. إنشاء كائن التحقق من النماذج
  final ValidationsForm _form = ValidationsForm();

  // 2. إنشاء كائن الموديل
  late PatientIntakeModel _model;

  // 3. كائن الـ Binder المولد
  late FeildModelBinder _binder;

  @override
  void initState() {
    super.initState();
    _initEngine();
  }

  void _initEngine() {
    _model = PatientIntakeModel();
    // توليد الـ Binder وربط الحقول بالنموذج
    _binder = CellFieldBuilder.buildBinderFromModel(
      model: _model,
      form: _form,
      onFieldChanged: (name, val) {
        setState(() {}); // تحديث الواجهة التفاعلية عند التعديل
      },
    );
  }

  /// حفظ البيانات والتحقق من الشروط
  void _submitForm() {
    if (_form.form.currentState!.validate()) {
      _form.form.currentState!.save();

      // استخراج خريطة البيانات الكاملة
      final extractedData = <String, dynamic>{};
      for (final cell in _model.toCells()) {
        extractedData[cell.name] = cell.value;
      }

      print('🚀 تم حفظ واستخراج البيانات بنجاح:');
      print(extractedData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ تم حفظ بيانات النموذج بنجاح!'),
          backgroundColor: Colors.teal,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ يرجى تصحيح الحقول المطلوبة.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('استمارة تسجيل المريض | Cell Field Engine'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.edit_note), text: 'شاشة الإدخال (Input Form)'),
              Tab(icon: Icon(Icons.visibility), text: 'شاشة العرض (Output View)'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // ==========================================
            // التبويب 1: استمارة الإدخال التلقائية
            // ==========================================
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Column(
                    children: [
                      // تمرير كافة حقول الإدخال إلى ValidationsForm بضغطة زر
                      _form.buildChildrenWithColumn(
                        context: context,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _binder.getInputWidgets(),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        ),
                        onPressed: _submitForm,
                        icon: const Icon(Icons.save_rounded),
                        label: const Text('حفظ البيانات والتحقق'),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ==========================================
            // التبويب 2: بطاقة العرض المنسقة للقراءة فقط
            // ==========================================
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 700),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ملخص بيانات المريض (Read-only View)',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(height: 24),
                      // عرض كافة الحقول عبر getOutputWidgets()
                      ..._binder.feilds.map((f) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 180,
                                child: Text(
                                  f.nameCaption,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Expanded(child: f.outputField),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## ⚡ 4. كيفية توليد جداول البيانات (DataTableGrid)

إذا كنت تبني شاشة لوحة تحكم تعرض جدولاً للبيانات (Data Grid / Table)، يمكنك استخدام `DataTableGrid` مباشرة مع الـ `FeildModelBinder`:

```dart
// تعريف جدول يحتوي على عدة أسطر من نفس الموديل
final tableData = DataTableOfCellModels<PatientIntakeModel>(
  listOfRows: [
    RowCells(cells: patient1.toCells()),
    RowCells(cells: patient2.toCells()),
    RowCells(cells: patient3.toCells()),
  ],
);

// بناء الجدول تلقائياً مع الرؤوس والخلايا المنسقة
Widget buildTable() {
  return DataTableGrid(
    dataModel: _binder,
    data: tableData,
  );
}
```

---

## 💡 5. أفضل الممارسات والنصائح (Best Practices)

1. **الوصول المباشر للقيم:** يمكنك قراءة أو تعيين أي قيمة مباشرة عبر اسم الحقل في النموذج:
   ```dart
   _model.fullName.value = 'محمد علي';
   print(_model.fullName.value);
   ```
2. **استخراج الـ JSON Schema:** يمكنك استخراج المخطط الوصفي للحقول برمجياً لإرساله للخادم أو حفظه في قاعدة البيانات:
   ```dart
   final schema = _model.toCells().map((c) => c.toSchemaJson()).toList();
   ```
3. **التفاعل الفوري (Reactivity):** استخدم كولباك `onFieldChanged` في `buildBinderFromModel` لتحديث حسابات تلقائية (مثلاً: حساب مؤشر كتلة الجسم BMI تلقائياً عند تغيير الوزن أو الطول).
4. **التخصيص المنفرد للحقول:** يمكنك الوصول لأي حقل وتعديل الـ `inputField` أو الـ `outputField` الخاص به يدوياً إن أردت تخصيصاً خاصاً جداً:
   ```dart
   _binder.getField('fullName').inputField = CustomMySpecialWidget();
   ```

---
**JoDija Templates — Modern Enterprise Flutter Framework**
