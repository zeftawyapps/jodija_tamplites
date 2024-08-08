import 'package:flutter/material.dart';

import 'field.dart';

class FeildModelBinder{
  List<Field>_feilds = [];
  List<Field> get feilds => _feilds;
  List<Widget> getInputWidgets (){
    List<Widget> widgets = [];
    _feilds.forEach((element) {
      widgets.add(element.inputField);
    });
    return widgets;
  }
  List<Widget> getOutputWidgets (){
    List<Widget> widgets = [];
    _feilds.forEach((element) {
      widgets.add(element.outputField);
    });
    return widgets;
  }
  void addField(Field field){
    _feilds.add(field);
  }



}