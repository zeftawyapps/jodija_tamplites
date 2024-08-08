import 'dart:ui';

import 'package:JoDija_view/util/view_data_model/base_data_model.dart';
import 'package:JoDija_view/util/widgits/input_text/input_text_field.dart';
import 'package:flutter/material.dart';

class DataTableGridView extends StatefulWidget {
  DataTableGridView({
    Key? key,
    this.physics,
    required this.header,
    this.headerStyle =
        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    this.width = 80,
    required this.rowWidgets,
    required this.rowCount,
    this.addDelete = false,
    this.headerColor = Colors.blue,
    this.rowColor = Colors.white,
    this.columnWidth = const [],
  }) : super(key: key);
  ScrollPhysics? physics;
  List<String> header = [];
  double? width = 80;

   // add call back to add rows
  List<DataCell> Function(int) rowWidgets;



  List<double> columnWidth = [];
  TextStyle headerStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  bool addDelete = false;
  int rowCount = 0;
  Color headerColor = Colors.blue;
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
                if (widget.columnWidth.length == 0 || widget.columnWidth.length < widget.header.length) {
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
                cells:
                    List<DataCell>.generate( widget.header.length , (hindex) {
                  return  cells[hindex];
                }),
              );
            }),
          ),
        ),
      ),
    );
  }
}
