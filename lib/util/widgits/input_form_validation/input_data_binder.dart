  class InputDataGenerator{
 String keyData ;
 dynamic value;
InputTypeWidget  inputTypeWidget;
  InputDataGenerator({required this.keyData, required this.value
  , required this.inputTypeWidget
  });
}

enum InputTypeWidget{
   text ,
    dropDown ,
  dateTiem
}