import 'package:flutter/material.dart';

import '../../../../util/validators/base_validator.dart';
import '../../input_text/dateTime_input_text_field.dart';
import '../form_validations.dart';
import '../input_validation_item.dart';

class DateTimeTextFieldValidaion extends StatelessWidget
    implements InputValidationForm {
  InputDecoration decoration;
  DateTime? initDate, firestDate, lastDate;
  TextStyle textStyle;
  List<BaseValidator>? baseValidation;
  ValidationsForm form;
  String hintText;
  String keyData;
  DatePickerEntryMode entryMode = DatePickerEntryMode.calendar;
  Map<String, dynamic>? mapValue;
  DatePickerMode datePickerMode = DatePickerMode.day;
  DateTimeTextFieldValidaion(
      {this.initDate,
      this.firestDate,
      this.lastDate,
      this.datePickerMode = DatePickerMode.day,
      required this.decoration,
      required this.textStyle,
      required this.keyData,
      required this.baseValidation,
      required this.hintText,
      this.mapValue,
      required this.form,
      this.entryMode = DatePickerEntryMode.calendar});

  @override
  Widget build(BuildContext context) {
    DateTime init = initDate ?? DateTime.now();
    DateTime first = firestDate ?? DateTime.now();
    DateTime last = lastDate ?? first.add(Duration(days: 1));
    DatePickerMode mode =  datePickerMode;
    mapValue = Map<String, dynamic>();
    form.inputValidationForm.add(this);
    return DatePickerFormFieldValidation(
        entryMode: entryMode,
        initialDatePickerMode: mode,
        initDate: init,
        firestDate: firestDate,
        lastDate: last,
        textStyle: textStyle,
        decoration: decoration,
        hintText: hintText,
        onvlaidate: (v) {
          if (baseValidation != null) {
            return BaseValidator.validateValue(
                context, v.toString().trim(), baseValidation!);
          } else {
            return null;
          }
        },
        onSave: (v) {
          mapValue!["$keyData"] = v;
        });
  }
}
