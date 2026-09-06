# ⚙️ كلاس CellFieldBuilder والربط التلقائي للنماذج الذكية

---

### 🌐 اللغة / Language
[🇺🇸 **English Version (CELL_FIELD_BUILDER.md)**](CELL_FIELD_BUILDER.md) • [📖 **دليل الاستخدام (HOW_TO_USE.ar.md)**](../HOW_TO_USE.ar.md) • [📚 **بوابة التوثيق (README.ar.md)**](../README.ar.md)

---

## 1. ما هو كلاس `CellFieldBuilder`؟
**`CellFieldBuilder`** هو المحرك التفاعلي الذي يقوم تلقائياً بتحويل كائنات الـ `Cell` إلى حقول إدخال مرئية (`Field` و `TextFormValidation`) مربوطة بنظام التحقق `ValidationsForm`.

بدلاً من كتابة كل حقل إدخال وربطه بـ `TextEditingController` ومحققات الأخطاء يدوياً، يقوم `CellFieldBuilder` بقراءة:
- نوع البيانات (`CellDataType`) لتحديد الودجة المناسبة (حقل نصي، رقمي، تاريخ، أو قائمة منسدلة).
- الخاصية الإلزامية (`isRequired`) لإضافة `RequiredValidator` تلقائياً.
- التسمية والتلميحات (`caption` و `hint`) لبناء الـ InputDecoration والعناوين.

---

## 2. دوال كلاس `CellFieldBuilder`

| الدالة | المعاملات | الوصف |
| :--- | :--- | :--- |
| `buildField(...)` | `Cell, ValidationsForm, onChanged` | توليد كائن `Field` متكامل يحتوي على ودجة الإدخال المناسبة ومربوط بالنموذج. |
| `buildFormFields(...)` | `List<Cell>, ValidationsForm` | بناء قائمة متكاملة من الحقول لصف كامل من البيانات دفعة واحدة. |

---

## 3. كود تطبيقي كامل جاهز للتشغيل (Full Runnable Example)

```dart
import 'package:flutter/material.dart';
import 'package:JoDija_tamplites/JoDija_tamplites.dart';

class CustomerEntryFormScreen extends StatefulWidget {
  const CustomerEntryFormScreen({super.key});

  @override
  State<CustomerEntryFormScreen> createState() => _CustomerEntryFormScreenState();
}

class _CustomerEntryFormScreenState extends State<CustomerEntryFormScreen> {
  final formManager = ValidationsForm();

  late final Field nameField;
  late final Field phoneField;
  late final Field countryField;

  @override
  void initState() {
    super.initState();

    // 1. إنشاء الحقول عبر المحرك الذكي CellFieldBuilder
    nameField = CellFieldBuilder.buildField(
      cell: Cell<String>(
        "customer_name",
        caption: "اسم العميل",
        isRequired: true,
        hint: "أدخل الاسم بالكامل",
      ),
      form: formManager,
    );

    phoneField = CellFieldBuilder.buildField(
      cell: Cell<String>(
        "phone",
        caption: "رقم الهاتف",
        type: CellDataType.number,
        isRequired: true,
        hint: "010xxxxxxxx",
      ),
      form: formManager,
    );

    countryField = CellFieldBuilder.buildField(
      cell: Cell<String>(
        "country",
        caption: "الدولة",
        type: CellDataType.dropdown,
        options: ["مصر", "السعودية", "الإمارات", "الكويت"],
        value: "مصر",
        isRequired: true,
      ),
      form: formManager,
    );
  }

  void submitForm() {
    // 2. التحقق من كافة الحقول دفعة واحدة
    if (formManager.valdate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم التحقق بنجاح وحفظ البيانات!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى تصحيح الأخطاء أولاً")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تسجيل عميل جديد")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            nameField.textFormValidation,
            const SizedBox(height: 16),
            phoneField.textFormValidation,
            const SizedBox(height: 16),
            countryField.textFormValidation,
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: submitForm,
                child: const Text("حفظ البيانات"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```
