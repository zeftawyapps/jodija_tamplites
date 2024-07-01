import 'package:flutter/material.dart';

import '../../../../util/validators/base_validator.dart';
import '../../../functions/show_dialog.dart';
import '../../../view_data_model/base_data_model.dart';
import '../../input_text/dateTime_input_text_field.dart';
import '../../input_text/refrance_input_text_field.dart';
import '../form_validations.dart';
import '../input_validation_item.dart';

class RefranceValidaion<T extends BaseViewDataModel> extends StatelessWidget
    implements InputValidationForm {
  InputDecoration decoration;
  TextStyle textStyle;
  List<BaseValidator>? baseValidation;
  ValidationsForm form;
  String? labalText;
  String keyDesplay;
  String keyData;
  Map<String, dynamic>? mapValue;
  var onChange;
  void Function(T? data) onResult;
  TextEditingController? controller;
  ShowInputFieldsDialogs<T> showInputDialoge;

  RefranceValidaion(
      {required this.decoration,
      required this.textStyle,
      required this.keyData,
      required this.keyDesplay,
      required this.baseValidation,
      required this.labalText,
      this.mapValue,
      required this.form,
      this.onChange,
      required this.onResult,
      required this.showInputDialoge,
      this.controller});

  @override
  Widget build(BuildContext context) {
    mapValue = Map<String, dynamic>();
    form.inputValidationForm.add(this);
    if (controller == null) controller = TextEditingController();
    return RefranceFormField(
        controller: controller,
        textStyle: textStyle,
        decoration: decoration,
        hintText: labalText,
        onTap: () {
          showInputDialoge.showCleintDialogs(context, onResult: (data) {
            if (data != null) {
              mapValue = data.map;
              String text = mapValue![keyDesplay];
              controller!.text = text;
              onResult(data!);
              if (onChange != null) {
                onChange(data);
              }
            }
          });
        },
        onChange: (v) {},
        onvlaidate: (v) {
          if (baseValidation != null) {
            return BaseValidator.validateValue(
                context, v.toString().trim(), baseValidation!);
          } else {
            return null;
          }
        },
        onSave: (v) {
        mapValue![keyData] = mapValue;
        });
  }
}
