import 'cell.dart';
import 'cell_data_type.dart';
import 'row_cells.dart';

/// خلية الإدخال المتعدد المتكرر (Repeater / Dynamic Sub-Rows)
/// تمثل قائمة من الصفوف أو الكائنات المتكررة (مثل قائمة الأدوية، التحاليل المتكررة، درجات الحرارة...)
class RepeaterCell extends Cell<List<Map<String, dynamic>>> {
  /// مخطط الخلايا للسطر الواحد (Row Schema)
  final List<Cell> subCellsSchema;

  /// الحد الأدنى لعدد العناصر المسموح بإضافتها
  final int minItems;

  /// الحد الأقصى لعدد العناصر المسموح بإضافتها (اختياري)
  final int? maxItems;

  /// تسمية زر الإضافة (مثل: "إضافة دواء جديد +")
  final String? addItemLabel;

  RepeaterCell(
    super.name, {
    required this.subCellsSchema,
    List<Map<String, dynamic>>? initialRows,
    super.caption,
    super.isRequired = false,
    super.hint,
    this.minItems = 0,
    this.maxItems,
    this.addItemLabel,
  }) : super(
          type: CellDataType.repeater,
          value: initialRows ?? [],
        );

  /// الحصول على قائمة الصفوف الحالية
  List<Map<String, dynamic>> get rows => value ?? [];

  /// إضافة صف جديد بقيم أولية
  void addRow([Map<String, dynamic>? initialRowData]) {
    value ??= [];
    final newRow = <String, dynamic>{};
    for (final cell in subCellsSchema) {
      newRow[cell.name] = initialRowData?[cell.name] ?? cell.defaultValue;
    }
    value!.add(newRow);
  }

  /// حذف صف عند مؤشر محدد
  void removeRow(int index) {
    if (value != null && index >= 0 && index < value!.length) {
      value!.removeAt(index);
    }
  }

  /// تحديث بيانات صف محدد
  void updateRow(int index, Map<String, dynamic> rowData) {
    if (value != null && index >= 0 && index < value!.length) {
      value![index] = Map<String, dynamic>.from(rowData);
    }
  }

  /// تحويل الصفوف إلى قائمة `RowofCells` للربط مع نظام الجداول والعمليات الإحصائية
  List<RowofCells> toRowOfCellsList() {
    return (value ?? []).map((rowMap) {
      final cells = subCellsSchema.map((schemaCell) {
        return schemaCell.copyWith(value: rowMap[schemaCell.name]);
      }).toList();
      return RowofCells(cells);
    }).toList();
  }

  @override
  Map<String, dynamic> toSchemaJson() {
    final baseJson = super.toSchemaJson();
    baseJson['subCellsSchema'] =
        subCellsSchema.map((c) => c.toSchemaJson()).toList();
    baseJson['minItems'] = minItems;
    baseJson['maxItems'] = maxItems;
    baseJson['addItemLabel'] = addItemLabel;
    return baseJson;
  }
}
