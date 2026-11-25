import "cell.dart";

abstract class CellModel {
  List<Cell>? cells = [];

  Map<String, dynamic>? map = <String, dynamic>{};

  Map<String, dynamic> cellToMap(List<Cell> cells) {
    Map<String, dynamic> map = <String, dynamic>{};
    for (var element in cells) {
      map[element.name] = element.value;
    }

    return map;
  }

  List<Cell> cellValueFromMap(List<Cell> cells, Map<String, dynamic> map) {
    if (cells.isNotEmpty) {
      for (var element in cells) {
        element.value = map[element.name];
      }
    }
    return cells;
  }

  List<Cell>? toCells();
}
