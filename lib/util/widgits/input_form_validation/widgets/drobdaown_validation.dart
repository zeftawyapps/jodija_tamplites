import 'package:flutter/material.dart';
import '../../../../util/validators/base_validator.dart';
import '../../input_text/dropDown_text_feild.dart';
import '../form_validations.dart';
import '../input_validation_item.dart';

class DrobDaownValidation extends StatelessWidget implements InputValidationForm {
  List<String> itemslsit;
  InputDecoration decoration;
  TextStyle textStyle;
  List<BaseValidator>? baseValidation;
  ValidationsForm form;
  String hintText;
  String keyData;
  int index = 0;

  Map<String, dynamic>? mapValue;
  // call back to get the value of the drop down
  var onChange;

  DrobDaownValidation(
      {required this.decoration,
      required this.textStyle,
      required this.itemslsit,
      required this.keyData,
      required this.baseValidation,
      required this.hintText,
      this.mapValue,
this.onChange,
        this.index = 0,
      required this.form});
  @override
  Widget build(BuildContext context) {

    mapValue = Map<String , dynamic>();
    form.inputValidationForm.add(this);
    return DropDownInputTextField(
      textStyle: textStyle,
      itemslsit: itemslsit,
      hintText: hintText,
      decoration: decoration,
      val: itemslsit[index],
      onChange: (v){
        mapValue!["$keyData"] = v;
        if(onChange != null){
          onChange(v);
        }
      },
      validation: (v) {
        if (baseValidation != null) {
          return BaseValidator.validateValue(
              context, v.toString().trim(), baseValidation!);
        } else {
          return null;
        }
      },
      onsaved: (v) {
        mapValue!["$keyData"] = v;
      },
    );
  }
}
