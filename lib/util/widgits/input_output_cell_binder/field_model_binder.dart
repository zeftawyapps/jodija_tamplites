import 'package:JoDija_view/util/cell_models/modul_screateor.dart';
import 'package:flutter/material.dart';

import 'field.dart';

class FeildModelBinder  <cell extends CellModel>{
  cell cellDataModel;
  FeildModelBinder({required this.cellDataModel});
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
  List<Widget> getHeaderWidgets (){
    List<Widget> widgets = [];
    _feilds.forEach((element) {
      widgets.add(element.header);
    });
    return widgets;
  }
  void addField(Field field){
    _feilds.add(field);
  }
  // clear all the fields
  void clearFields(){
    _feilds.clear();
  }
  // get the fields
  List<Field> getFields(){
    return _feilds;
  }

  Field getField(String name){
    return _feilds.firstWhere((element) => element.name == name);
  }

}