import 'package:flutter/material.dart';

import 'input_validation_item.dart';

class ValidationsForm {
  ValidationsForm(){

  }
  List<InputValidationForm> inputValidationForm = [];
  Map<String, dynamic>? dataMap;
  GlobalKey<FormState> form = GlobalKey();


  Widget build(
      BuildContext context, { required  Widget child}) {


    return Container(
      child: Form(
        key: form,
        child:  child,
      ),
    );
  }

  Widget buildChildrenWithColumn(
      {required BuildContext context,
      required List<Widget> children,
      MainAxisAlignment? mainAxisAlignment = MainAxisAlignment.center}) {
    this.inputValidationForm = inputValidationForm;

    return Container(
      child: Form(
        key: form,
        child: Container(
          child: Column(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }
  Map<String, dynamic> getInputData() {
    Map<String, dynamic> dataMap = Map();
    if (form.currentState!.validate()) {
      form.currentState!.save();
      inputValidationForm.map((e) {
        if (e.mapValue != null) {
          dataMap[e.keyData] = e.mapValue![e.keyData];
        }
      }).toList();
    }

    return dataMap!;
  }
}
