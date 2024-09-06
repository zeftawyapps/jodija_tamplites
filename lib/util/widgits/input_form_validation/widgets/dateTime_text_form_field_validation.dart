import 'package:flutter/material.dart';

import '../../../../util/validators/base_validator.dart';
import '../../input_output_cell_binder/intpu_cell_binder.dart';
import '../../input_text/dateTime_input_text_field.dart';
import '../form_validations.dart';
import '../input_validation_item.dart';
import '../lable_desplty.dart';

class DateTimeTextFieldValidaion extends StatelessWidget
    implements InputValidationForm, InputFeildBinder, DataTableFieldBinder {
  InputDecoration decoration;
  DateTime? initDate, firestDate, lastDate;
  TextStyle textStyle;
  List<BaseValidator>? baseValidation;
  ValidationsForm form;
  String? labalText;
  String keyData;
  DatePickerEntryMode entryMode = DatePickerEntryMode.calendar;
  Map<String, dynamic>? mapValue;
  DatePickerMode datePickerMode = DatePickerMode.day;
  var onChange;
  LabelDisplay labelDisplay = LabelDisplay.none;
  DateTimeTextFieldValidaion(
      {this.initDate,
      this.firestDate,
      this.lastDate,
      this.datePickerMode = DatePickerMode.day,
      required this.decoration,
      required this.textStyle,
      required this.keyData,
      required this.baseValidation,
      required this.labalText,
      this.labelDisplay = LabelDisplay.none,
      this.mapValue,
      required this.form,
      this.onChange,
      this.entryMode = DatePickerEntryMode.calendar});

  @override
  Widget build(BuildContext context) {
    DateTime init = initDate ?? DateTime.now();
    DateTime first = firestDate ?? DateTime.now();
    DateTime last = lastDate ?? first.add(Duration(days: 1));
    DatePickerMode mode = datePickerMode;
    mapValue = Map<String, dynamic>();
    form.inputValidationForm.add(this);
    if (labelDisplay == LabelDisplay.none) {
      return DatePickerFormField(
          entryMode: entryMode,
          initialDatePickerMode: mode,
          initDate: init,
          firestDate: firestDate,
          lastDate: last,
          textStyle: textStyle,
          decoration:  labalText != ""
              ? decoration.copyWith(labelText: labalText)
              : decoration,
          hintText: labalText,
          onChange: (v) {
            var sDate = v.toString();
            if (onChange != null) {
              DateTime date = DateTime.parse(sDate);
              onChange(date);
            }
          },
          onvlaidate: (v) {
            if (baseValidation != null) {
              return BaseValidator.validateValue(
                  context, v.toString().trim(), baseValidation!);
            } else {
              return null;
            }
          },
          onSave: (v) {
            var sDate = v.toString();
            DateTime date = DateTime.parse(sDate);
            mapValue!["$keyData"] = date;
          });
    } else if (labelDisplay == LabelDisplay.rowDisplay) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
          child: Row(
        children: [
          Expanded(
              child: Text(labalText!, style: textStyle)),
            SizedBox(width: 5,),
            Expanded(flex:  10 ,
              child: DatePickerFormField(
                  entryMode: entryMode,
                  initialDatePickerMode: mode,
                  initDate: init,
                  firestDate: firestDate,
                  lastDate: last,
                  textStyle: textStyle,
                  decoration: decoration,
                  hintText: labalText,
                  onChange: (v) {
                    var sDate = v.toString();
                    if (onChange != null) {
                      DateTime date = DateTime.parse(sDate);
                      onChange(date);
                    }
                  },
                  onvlaidate: (v) {
                    if (baseValidation != null) {
                      return BaseValidator.validateValue(
                          context, v.toString().trim(), baseValidation!);
                    } else {
                      return null;
                    }
                  },
                  onSave: (v) {
                    var sDate = v.toString();
                    DateTime date = DateTime.parse(sDate);
                    mapValue!["$keyData"] = date;
                  }),
            ),

        ],
      ));
    } else {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(labalText!, style: textStyle),
        Container(
          child: DatePickerFormField(
              entryMode: entryMode,
              initialDatePickerMode: mode,
              initDate: init,
              firestDate: firestDate,
              lastDate: last,
              textStyle: textStyle,
              decoration: decoration,
              hintText: labalText,
              onChange: (v) {
                var sDate = v.toString();
                if (onChange != null) {
                  DateTime date = DateTime.parse(sDate);
                  onChange(date);
                }
              },
              onvlaidate: (v) {
                if (baseValidation != null) {
                  return BaseValidator.validateValue(
                      context, v.toString().trim(), baseValidation!);
                } else {
                  return null;
                }
              },
              onSave: (v) {
                var sDate = v.toString();
                DateTime date = DateTime.parse(sDate);
                mapValue!["$keyData"] = date;
              }),
        ),
      ]));
    }
  }

  @override
  // TODO: implement nameCaption
  get nameCaption => labalText;
}
