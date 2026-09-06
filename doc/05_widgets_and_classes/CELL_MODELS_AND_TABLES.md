# 📊 Smart Cell Engine & Tables (Cell Models & DataTableOfCellModels)

---

### 🌐 Language / اللغة
[🇸🇦 **النسخة العربية (CELL_MODELS_AND_TABLES.ar.md)**](CELL_MODELS_AND_TABLES.ar.md) • [📖 **Tutorial (HOW_TO_USE.md)**](../HOW_TO_USE.md) • [📚 **Documentation Portal (README.md)**](../README.md)

---

## 1. What is the Cell Engine?
The Cell Engine in `JoDija Templates` elevates standard primitive types (Strings, Numbers, Dates) into intelligent atomic units carrying **values**, **labels**, **data types**, **validation rules**, and **statistical aggregation capabilities**.

Core Building Blocks:
1. **`Cell<T>`**: Represents an individual atomic field (key, value, `CellDataType`, user caption, unit of measurement).
2. **`RowofCells`**: Represents an entire row of cells mapped to a data model or hash map.
3. **`DataTableOfCellModels<T>`**: High-density table analytical engine computing distinct grouping, frequency counts, and grid rows.

---

## 2. Supported Data Types (`CellDataType`)

| Type | Description | Common Use Case |
| :--- | :--- | :--- |
| `CellDataType.text` | Standard string field | Titles, customer names, addresses. |
| `CellDataType.number` | Numeric value (int / double) | Prices, quantities, percentages. |
| `CellDataType.date` | Calendar date | Invoices, birthdates. |
| `CellDataType.dateTime` | Timestamp date and time | Audit logs, reservations. |
| `CellDataType.dropdown` | Selectable options list | Status flags (New, In Progress, Completed). |
| `CellDataType.boolean` | Boolean flag (true / false) | In stock, active status toggles. |
| `CellDataType.repeater` | Dynamic one-to-many items | Invoice line items, medication lists. |

---

## 3. Method Reference for `DataTableOfCellModels<T>`

| Method | Parameters | Description |
| :--- | :--- | :--- |
| `unicGrubs(mapList, cell)` | `List<Map>, Cell` | Extracts distinct values for a given cell (e.g., unique categories list). |
| `countBy(mapList, cell)` | `List<Map>, Cell` | Aggregates item frequency counts (e.g., number of items in each category). |
| `getListOfCells(row)` | `RowofCells` | Extracts raw `Cell` objects from a given row. |

---

## 4. Full Runnable Example

```dart
import 'package:flutter/material.dart';
import 'package:JoDija_tamplites/JoDija_tamplites.dart';

// 1. Define Entity subclassing CellModel
class InventoryItemModel extends CellModel {
  final String productName;
  final double price;
  final String category;

  InventoryItemModel({
    required this.productName,
    required this.price,
    required this.category,
  }) {
    // Populate cell metadata
    cells = [
      Cell<String>("name", caption: "Product Name", value: productName, type: CellDataType.text),
      Cell<double>("price", caption: "Unit Price", value: price, type: CellDataType.number),
      Cell<String>("category", caption: "Category", value: category, type: CellDataType.text),
    ];
  }
}

void main() {
  // 2. Sample Inventory Dataset
  final inventory = [
    InventoryItemModel(productName: "Dell Latitude Laptop", price: 1200.0, category: "Computers"),
    InventoryItemModel(productName: "Wireless Mouse", price: 35.0, category: "Accessories"),
    InventoryItemModel(productName: "Mechanical Keyboard", price: 95.0, category: "Accessories"),
    InventoryItemModel(productName: "27-inch 4K Monitor", price: 450.0, category: "Computers"),
  ];

  // 3. Feed the analytical table engine
  final tableEngine = DataTableOfCellModels<InventoryItemModel>(inventory);

  // Extract distinct unique categories
  final categoryCell = Cell<String>("category");
  final distinctCategories = tableEngine.unicGrubs(tableEngine.mapList, categoryCell);
  print("Distinct Categories: $distinctCategories"); // ["Computers", "Accessories"]

  // Aggregate frequencies by category
  final counts = tableEngine.countBy(tableEngine.mapList, categoryCell);
  print("Category Aggregations: $counts"); // {"Computers": 2, "Accessories": 2}
}
```
