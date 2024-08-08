import "cell.dart";

abstract class CellModel {
  List<Cell>? cells = [];

  Map<String, dynamic>? map = Map<String, dynamic>();

  Map<String, dynamic> cellToMap(List<Cell> cells) {
    Map<String, dynamic> map = Map<String, dynamic>();
    cells.forEach((element) {
      map[element.name] = element.value;
    });

    return map!;
  }

  List<Cell> cellValueFromMap(List<Cell> cells, Map<String, dynamic> map) {
    if (cells.length > 0) {
      cells.forEach((element) {
        element.value = map[element.name];
      });
    }
    return cells;
  }

  List<Cell>? toCells();
}
