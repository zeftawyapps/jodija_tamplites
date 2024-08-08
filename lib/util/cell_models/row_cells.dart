
import 'cell.dart';
import 'modul_screateor.dart';

class RowofCells<T extends CellModel >{
  List<Cell> cells = [];
  Map<String  , dynamic>  rowMap ={};
  T? modle;
  RowofCells(this.cells) {

    cells.map((e)=>{
      rowMap.addAll({e.name: e.value})
    }).toList();
  }
  RowofCells.model(T model){
  this.   modle = model;
    cells = model.cells !;
     cells.map((e)=>{
        rowMap.addAll({e.name: e.value})
      }).toList();
  }

  void addMap(Map<String ,dynamic> map ){
    rowMap.addAll(map);
  }
  void addCell(Cell  map ){
    rowMap.addAll(map.toMap());
  }
  RowofCells.manual(this.rowMap);
  dynamic getvalue(Cell keycell){
    return rowMap[keycell.name];
  }
  dynamic getvalueBykeyname(String  keycell){
    return rowMap[keycell ];
  }
}