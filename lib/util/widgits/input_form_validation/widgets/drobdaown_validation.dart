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
  Map<String, dynamic>? mapValue;

  DrobDaownValidation(
      {required this.decoration,
      required this.textStyle,
      required this.itemslsit,
      required this.keyData,
      required this.baseValidation,
      required this.hintText,
      this.mapValue,
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
