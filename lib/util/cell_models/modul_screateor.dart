import "package:collection/collection.dart";

import "cell.dart";




 abstract class CellModel{

  List<Cell>? cells =[]  ;

  Map< String , dynamic > ? map  =  Map<String , dynamic > ();

  Map<String , dynamic > cellToMap(List<Cell> cells ){
    int i , c ;
    c = cells.length ;
    i = 0 ;
    do {
      map!.addAll({ cells [i].name:cells [i].value});
      i++ ;
    }while (i<c ) ;
return map! ;
  }
  List<Cell>  cellValueFromMap(List<Cell> cells ,   Map<String , dynamic >map ){
    if (cells .length>0){
      cells.forEach((element) {
        element.value = map[element.name] ;
      });
    }
    return cells ;
  }
  List<Cell>? toCells();



 }






