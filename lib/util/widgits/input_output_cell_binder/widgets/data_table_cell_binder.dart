import 'package:JoDija_tamplites/util/cell_models/data-operations.dart';
import 'package:JoDija_tamplites/util/cell_models/modul_screateor.dart';
import 'package:JoDija_tamplites/util/widgits/input_output_cell_binder/field_model_binder.dart';
import 'package:JoDija_tamplites/util/widgits/input_text/input_text_field.dart';
import 'package:flutter/material.dart';

class DataTableGrid<F extends FeildModelBinder, C extends CellModel>
    extends StatelessWidget {
  DataTableGrid(
      {Key? key, this.physics, required this.dataModel, required this.data})
      : super(key: key);
  ScrollPhysics? physics;
  F dataModel;
  DataTableOfCellModels<C> data;
  final ScrollController controller = ScrollController();
  final ScrollController controller2 = ScrollController();
  @override
  Widget build(BuildContext context) {
    physics = physics ?? const BouncingScrollPhysics();
    return Scrollbar(
      controller: controller2,
      child: SingleChildScrollView(
        controller: controller2,
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          physics: physics,
          controller: controller,
          child: DataTable(
            columns: addHeaders(),
            rows: addRows(),
          ),
        ),
      ),
    );
  }

  List<DataColumn> addHeaders() {
    List<DataColumn> columns = [];
    dataModel.feilds.forEach((element) {
      columns.add(DataColumn(label: element.header));
    });
    return columns;
  }

  List<DataRow> addRows() {
    List<DataRow> rows = [];

    data.listOfRows.forEach((element) {
      rows.add(DataRow(
        cells: element.cells
            .map((e) => DataCell(dataModel.getField(e.name).outputField))
            .toList(),
      ));
    });

    return rows;
  }
}
