import 'dart:ui';

import 'package:JoDija_tamplites/util/view_data_model/base_data_model.dart';
import 'package:JoDija_tamplites/util/widgits/input_text/input_text_field.dart';
import 'package:flutter/material.dart';

/// جدول لعرض البيانات (DataTable) مع إمكانيات التمرير الأفقي والعمودي.
/// A data table view with horizontal and vertical scrolling capabilities.
class DataTableGridView extends StatefulWidget {
  DataTableGridView({
    Key? key,
    /// فيزياء التمرير.
    /// Scroll physics.
    this.physics,
    /// عناوين الأعمدة.
    /// The headers for columns.
    required this.header,
    /// تصميم خط العناوين.
    /// Header text style.
    this.headerStyle =
        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    /// العرض الافتراضي للعمود.
    /// Default column width.
    this.width = 80,
    /// دالة بناء الخلايا لكل صف.
    /// Callback to build row cells.
    required this.rowWidgets,
    /// عدد الصفوف.
    /// The number of rows.
    required this.rowCount,
    /// إمكانية إضافة أو حذف صفوف.
    /// Whether to show add/delete options.
    this.addDelete = false,
    /// لون خلفية العناوين.
    /// Header background color.
    this.headerColor = Colors.blue,
    /// لون خلفية الصفوف.
    /// Row background color.
    this.rowColor = Colors.white,
    /// عرض مخصص لكل عمود.
    /// Custom widths for columns.
    this.columnWidth = const [],
  }) : super(key: key);
  /// فيزياء التمرير.
  /// Scroll physics.
  ScrollPhysics? physics;
  
  /// قائمة نصوص عناوين الأعمدة.
  /// List of column headers.
  List<String> header = [];
  
  /// العرض الافتراضي لكل عمود.
  /// Default width for each column.
  double? width = 80;

  /// دالة تستقبل الفهرس (Index) وترجع قائمة من الخلايا (DataCell) لذلك الصف.
  /// Callback receiving the index and returning a list of DataCells for that row.
  List<DataCell> Function(int) rowWidgets;

  /// العرض المخصص لكل عمود على حدة.
  /// Custom width for each specific column.
  List<double> columnWidth = [];
  
  /// تصميم الخط في العناوين.
  /// Text style for the header.
  TextStyle headerStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  
  /// تفعيل إمكانية الإضافة/الحذف.
  /// Enable add/delete.
  bool addDelete = false;
  
  /// إجمالي عدد الصفوف في الجدول.
  /// Total number of rows.
  int rowCount = 0;
  
  /// لون خلفية العناوين (Header).
  /// Header background color.
  Color headerColor = Colors.blue;
  
  /// لون خلفية الصفوف.
  /// Rows background color.
  Color rowColor = Colors.white;

  @override
  State<DataTableGridView> createState() => _DataTableGridViewState();
}

class _DataTableGridViewState extends State<DataTableGridView> {
  final ScrollController controller = ScrollController();

  final ScrollController controller2 = ScrollController();
  ScrollPhysics? physics;
  bool showSelect = false;
  List<bool> rowSelected = [];
  @override
  Widget build(BuildContext context) {
    physics = widget.physics ?? const BouncingScrollPhysics();

    return Scrollbar(
      controller: controller2,
      child: SingleChildScrollView(
        controller: controller2,
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          physics: widget.physics,
          controller: controller,
          child: DataTable(
            headingRowColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected))
                return widget.headerColor;
              return widget.headerColor;
            }),
            dataRowColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected))
                return widget.rowColor;
              return widget.rowColor;
            }),
            columns: List<DataColumn>.generate(
              widget.header.length,
              (index) {
                if (widget.columnWidth.length == 0 ||
                    widget.columnWidth.length < widget.header.length) {
                  widget.columnWidth.add(widget.width!);
                }

                return DataColumn(
                  label: Container(
                    width: widget.columnWidth[index],
                    child: Text(
                      widget.header[index],
                      style: widget.headerStyle,
                    ),
                  ),
                );
              },
            ),
            rows: List<DataRow>.generate(widget.rowCount, (index) {
              List<DataCell> cells = widget.rowWidgets!(index);
              rowSelected.add(false);
              return DataRow(
                onSelectChanged: (value) {
                  setState(() {
                    rowSelected[index] = !rowSelected[index];
                  });
                },
                selected: rowSelected[index],
                cells: List<DataCell>.generate(widget.header.length, (hindex) {
                  return cells[hindex];
                }),
              );
            }),
          ),
        ),
      ),
    );
  }
}
