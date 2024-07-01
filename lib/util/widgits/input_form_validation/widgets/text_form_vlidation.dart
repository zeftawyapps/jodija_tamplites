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
  final ValueChanged<String>? onFieldSubmitted;

  TextEditingController? controller;
  FocusNode? node;
  int? mulitLine;
  List<BaseValidator>? baseValidation;
  String? labalText = "";
  String keyData;

  ValidationsForm form;
  Map<String, dynamic>? mapValue;

  TextFomrFildValidtion({super.key,
    this.onFieldSubmitted ,
    required this.form,
    required this.baseValidation,
    this.labalText = "",
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
    form.inputValidationForm.add(this);

    if (mapValue == null) {
      mapValue = Map<String, dynamic>();
    }
    if (controller == null ){ controller = TextEditingController() ;}
    return InputTextFormfield(
        onFieldSubmitted: (v) {
          onSubmitted(v);
           onFieldSubmitted!(v);
        },
        node: node,
        maxLines: mulitLine,
        readOnly: isReadOnly,
        textInputType: textInputType,
        controller: this.controller,
        mainValue: this.controller != null ? initValue : null,
        style: textStyle,
        isPressed: this.isPssword,
        decoration: labalText != ""
            ? decoration.copyWith(labelText: labalText)
            : decoration,
        onChange: (v) {
          // if value not == mainValue then  set to mainValue

        },
        validate: (v) {
          if (baseValidation != null) {
            return BaseValidator.validateValue(
                context, v.toString().trim(), baseValidation!);
          } else {
            return null;
          }
        },
        saved: (v) {
          onSubmitted(v);
        });
  }
  onSubmitted(v) {
    if (textInputType == TextInputType.number) {
      String value = v.toString().trim();
      // if value have .0 then parse to double else to int
      if (value.contains(".")) {
        mapValue!["${keyData}"] = double.parse(v!);
      } else {
        mapValue!["${keyData}"] = int.parse(v!);
      }
    } else {
      mapValue!["${keyData}"] = v;
    }
  }
}