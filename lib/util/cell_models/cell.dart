class Cell <T>{
  Cell(this.name ,  {  this.value}) ;
  String name ;
  T? value ;

  Map<String , dynamic >  toMap (){

    return {name : value} ;
  }

}