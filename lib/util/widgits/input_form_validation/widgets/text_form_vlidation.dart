import 'package:flutter/material.dart';

import '../../../validators/base_validator.dart';
import '../../input_text/input_text_field.dart';
import '../form_validations.dart';
import '../input_validation_item.dart';

class TextFomrFildValidtion extends StatelessWidget
    implements InputValidationForm {
  InputDecoration decoration;
  TextStyle textStyle;
  bool isPssword;
  TextInputType textInputType = TextInputType.text;
  EdgeInsets? padding;
  dynamic initValue;
  bool isReadOnly;
  TextEditingController? controller;
  FocusNode? node;
  int? mulitLine;
  List<BaseValidator>? baseValidation;
  String hintText;
  String keyData;
   ValidationsForm form;
  Map<String, dynamic>? mapValue;


  TextFomrFildValidtion(
      {super.key,
       required this.form,
      required this.baseValidation,
      required this.hintText,
      required this.keyData,
      this.mapValue,
      this.mulitLine,
      this.isReadOnly = false,
      this.node,
      this.padding,
      required this.decoration,
      required this.textStyle,
      this.isPssword = false,
      this.textInputType = TextInputType.text,
      this.initValue,
      this.controller});
  @override
  Widget build(BuildContext context) {
   form.inputValidationForm .add(this);

    if (mapValue == null) {
      mapValue = Map<String, dynamic>();
    }
    return  InputTextFormfield(
            node: node,
            maxLines: mulitLine,
            readOnly: isReadOnly,
            textInputType: textInputType,
            controller: this.controller,
            mainValue: this.controller != null ? initValue : null,
            style: textStyle,
            isPressed: this.isPssword,
            decoration: decoration.copyWith(labelText: hintText),
            validate: (v) {
              if (baseValidation != null) {
                return BaseValidator.validateValue(
                    context, v.toString().trim(), baseValidation!);
              } else {
                return null;
              }
            },
            saved: (v) {
              if (textInputType == TextInputType.number)
                mapValue!["$keyData"] = int.parse(v!);
              else {
                mapValue!["$keyData"] = v;
              }
            }) ;


  }

  @override
  Widget getWedgetFormField(BuildContext context) {
    // TODO: implement getWedgetFormField
    throw UnimplementedError();
  }

  @override
  Widget getWedgetFormFieldAndAddTolist(
      BuildContext context, List<InputValidationForm> list) {
    // TODO: implement getWedgetFormFieldAndAddTolist
    throw UnimplementedError();
  }


}
