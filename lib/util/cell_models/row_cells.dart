import 'cell.dart';
import 'modul_screateor.dart';

/// نموذج صف الخلايا في الجداول الذكية (Row of Cells Data Model)
///
/// يمثل سجلاً واحداً (Row) يتألف من قائمة من كائنات [Cell] مع تحويل تلقائي
/// إلى قاموس برمجي (`rowMap`) لتسهيل البحث والاسترجاع السريع للقيم.
///
/// English Description:
/// Data row representation comprising a collection of [Cell] instances.
/// Maintains an indexed lookup map (`rowMap`) for fast retrieval by cell name or key.
///
/// ### مثال للاستخدام (Usage Example):
/// ```dart
/// final row = RowofCells([
///   Cell("name", value: "Product A"),
///   Cell("price", value: 150),
/// ]);
/// final name = row.getvalueBykeyname("name");
/// ```
class RowofCells<T extends CellModel> {
  /// قائمة الخلايا في هذا الصف (List of cells in this row)
  List<Cell> cells = [];

  /// قاموس المفاتيح والقيم لسهولة وسرعة الوصول (Key-value map for fast lookup)
  Map<String, dynamic> rowMap = {};

  /// النموذج المرتبط بالصف (Associated model instance)
  T? modle;

  RowofCells(this.cells) {
    cells.map((e) => {
      rowMap.addAll({e.name: e.value})
    }).toList();
  }

  RowofCells.model(T model) {
    this.modle = model;
    cells = model.cells!;
    cells.map((e) => {
      rowMap.addAll({e.name: e.value})
    }).toList();
  }

  void addMap(Map<String, dynamic> map) {
    rowMap.addAll(map);
  }

  void addCell(Cell map) {
    rowMap.addAll(map.toMap());
  }

  RowofCells.manual(this.rowMap);

  /// استرجاع قيمة الخلية بواسطة كائن الخلية (Gets value by Cell instance)
  dynamic getvalue(Cell keycell) {
    return rowMap[keycell.name];
  }

  /// استرجاع قيمة الخلية بواسطة اسم المفتاح (Gets value by key name string)
  dynamic getvalueBykeyname(String keycell) {
    return rowMap[keycell];
  }
}