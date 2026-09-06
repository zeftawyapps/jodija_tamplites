# 📊 محرك الخلايا والجداول الذكية (Cell Models & DataTableOfCellModels)

---

### 🌐 اللغة / Language
[🇺🇸 **English Version (CELL_MODELS_AND_TABLES.md)**](CELL_MODELS_AND_TABLES.md) • [📖 **دليل الاستخدام (HOW_TO_USE.ar.md)**](../HOW_TO_USE.ar.md) • [📚 **بوابة التوثيق (README.ar.md)**](../README.ar.md)

---

## 1. ما هو محرك الـ Cells؟
محرك الخلايا في حزمة `JoDija Templates` ينقل البيانات من مجرد متغيرات عادية (Strings / Numbers) إلى كائنات ذكية تحمل **القيمة**، **الوصف**، **النوع**، **قواعد التحقق**، و**إمكانيات التحليل الإحصائي**.

اللبنات الأساسية:
1. **`Cell<T>`**: تمثيل الحقل الذري (اسم الحقل، قيمته، نوعه `CellDataType`، التسمية التوضيحية `caption`).
2. **`RowofCells`**: يمثل صفاً كاملاً من الخلايا مرتبطاً بنموذج أو خريطة بيانات.
3. **`DataTableOfCellModels<T>`**: محرك التحليل الإحصائي وحساب المجموعات الفريدة وجداول البيانات.

---

## 2. جدول أنواع البيانات `CellDataType`

| النوع | الوصف | الاستخدام الشائع |
| :--- | :--- | :--- |
| `CellDataType.text` | حقل نصي عادي | الأسماء، العناوين، والملاحظات. |
| `CellDataType.number` | قيمة رقمية (صحيحة أو عشرية) | الأسعار، الكميات، والنسب المئوية. |
| `CellDataType.date` | تاريخ ميلادي | تاريخ الفاتورة، تاريخ الميلاد. |
| `CellDataType.dateTime` | تاريخ ووقت معاً | أوقات تسجيل العمليات، الحجوزات. |
| `CellDataType.dropdown` | قائمة خيارات منسدلة | الحالات (جديد، قيد التنفيذ، مكتمل). |
| `CellDataType.boolean` | حالة منطقية (نعم / لا) | متاح في المخزون، نشط / غير نشط. |
| `CellDataType.repeater` | قائمة بنود فرعية متكررة | بنود الفاتورة، تفاصيل الطلب المتعددة. |

---

## 3. دوال كلاس `DataTableOfCellModels<T>`

| الدالة | المعاملات | الوصف |
| :--- | :--- | :--- |
| `unicGrubs(mapList, cell)` | `List<Map>, Cell` | استخراج كافة القيم الفريدة لحقل معين (تجميع الفئات بدون تكرار). |
| `countBy(mapList, cell)` | `List<Map>, Cell` | حساب عدد تكرار كل قيمة (مثال: عدد المنتجات في كل فئة). |
| `getListOfCells(row)` | `RowofCells` | استخراج قائمة كائنات الـ Cell من صف محدد. |

---

## 4. كود تطبيقي كامل جاهز للتشغيل (Full Runnable Example)

```dart
import 'package:flutter/material.dart';
import 'package:JoDija_tamplites/JoDija_tamplites.dart';

// 1. تعريف نموذج الكيان يرث من CellModel
class InventoryItemModel extends CellModel {
  final String productName;
  final double price;
  final String category;

  InventoryItemModel({
    required this.productName,
    required this.price,
    required this.category,
  }) {
    // تعيين كائنات الخلايا للنموذج
    cells = [
      Cell<String>("name", caption: "اسم الصنف", value: productName, type: CellDataType.text),
      Cell<double>("price", caption: "سعر الوحدة", value: price, type: CellDataType.number),
      Cell<String>("category", caption: "التصنيف", value: category, type: CellDataType.text),
    ];
  }
}

void main() {
  // 2. تجهيز بيانات المخزون
  final inventory = [
    InventoryItemModel(productName: "لابتوب ديل", price: 25000.0, category: "أجهزة كمبيوتر"),
    InventoryItemModel(productName: "ماوس لاسلكي", price: 450.0, category: "إكسسوارات"),
    InventoryItemModel(productName: "لوحة مفاتيح ميكانيكية", price: 1200.0, category: "إكسسوارات"),
    InventoryItemModel(productName: "شاشة 27 بوصة", price: 8500.0, category: "أجهزة كمبيوتر"),
  ];

  // 3. تغذية محرك الجداول
  final tableEngine = DataTableOfCellModels<InventoryItemModel>(inventory);

  // استخراج الفئات بدون تكرار
  final categoryCell = Cell<String>("category");
  final distinctCategories = tableEngine.unicGrubs(tableEngine.mapList, categoryCell);
  print("الفئات المتاحة: $distinctCategories"); // ["أجهزة كمبيوتر", "إكسسوارات"]

  // حساب عدد المنتجات في كل فئة
  final counts = tableEngine.countBy(tableEngine.mapList, categoryCell);
  print("إحصائية الفئات: $counts"); // {"أجهزة كمبيوتر": 2, "إكسسوارات": 2}
}
```
