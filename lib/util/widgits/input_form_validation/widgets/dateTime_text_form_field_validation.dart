import 'package:flutter/material.dart';

import '../../../../util/validators/base_validator.dart';
import '../../input_output_cell_binder/intpu_cell_binder.dart';
import '../../input_text/dateTime_input_text_field.dart';
import '../form_validations.dart';
import '../input_validation_item.dart';
import '../lable_desplty.dart';

/// حقل إدخال مخصص لاختيار التاريخ، مدمج مع نظام التحقق (Validation).
/// A custom input field for picking a date, integrated with the validation system.
class DateTimeTextFieldValidaion extends StatelessWidget
    implements InputValidationForm, InputFeildBinder, DataTableFieldBinder {
  /// التنسيق الخاص بحقل الإدخال.
  /// The decoration of the input field.
  InputDecoration decoration;
  
  /// التاريخ المبدئي، وأقدم تاريخ، وأحدث تاريخ مسموح باختياره.
  /// The initial, earliest, and latest selectable dates.
  DateTime? initDate, firestDate, lastDate;
  
  /// تصميم النص الذي يظهر في الحقل.
  /// The text style of the inputted text.
  TextStyle textStyle;
  
  /// تصميم نص العنوان (Label).
  /// The text style for the label.
  TextStyle? labelStyle;
  
  /// قائمة شروط التحقق المطبقة.
  /// The list of validators applied.
  List<BaseValidator>? baseValidation;
  
  /// نموذج التحقق المرتبط بهذا الحقل.
  /// The form validation manager.
  ValidationsForm form;
  
  /// العنوان التعريفي للحقل.
  /// The label text of the field.
  String? labalText;
  
  /// المفتاح الفريد لحفظ القيمة في خريطة البيانات.
  /// The unique key to save the value in the data map.
  String keyData;
  
  /// وضع إدخال منتقي التاريخ (مثال: تقويم Calendar).
  /// The entry mode for the date picker (e.g., calendar).
  DatePickerEntryMode entryMode = DatePickerEntryMode.calendar;
  
  /// خريطة البيانات التي يُحفظ فيها الناتج محلياً.
  /// The local map where the value is stored.
  Map<String, dynamic>? mapValue;
  
  /// وضع منتقي التاريخ (عرض الأيام أو السنين).
  /// The initial date picker mode (days or years).
  DatePickerMode datePickerMode = DatePickerMode.day;
  
  /// دالة تُستدعى عند تغير التاريخ المختار.
  /// Callback triggered when the selected date changes.
  var onChange;
  
  /// طريقة عرض العنوان (أعلى الحقل، بجانبه، أو مخفي).
  /// How the label is displayed relative to the field.
  LabelDisplay labelDisplay = LabelDisplay.none;
  DateTimeTextFieldValidaion({
    /// التاريخ المبدئي.
    /// Initial date.
    this.initDate,
    /// أقدم تاريخ مسموح.
    /// Earliest selectable date.
    this.firestDate,
    /// أحدث تاريخ مسموح.
    /// Latest selectable date.
    this.lastDate,
    /// وضع التقويم المبدئي (يوم أو سنة).
    /// Initial date picker mode.
    this.datePickerMode = DatePickerMode.day,
    /// زخرفة الحقل.
    /// Field decoration.
    required this.decoration,
    /// تصميم النص المدخل.
    /// Input text style.
    required this.textStyle,
    /// تصميم نص العنوان.
    /// Label text style.
    this.labelStyle,
    /// مفتاح حفظ القيمة.
    /// Data save key.
    required this.keyData,
    /// شروط التحقق.
    /// Validators.
    required this.baseValidation,
    /// نص العنوان.
    /// Label text.
    required this.labalText,
    /// طريقة العرض الخاصة بالعنوان.
    /// Label display mode.
    this.labelDisplay = LabelDisplay.none,
    /// خريطة البيانات المخصصة.
    /// Data map.
    this.mapValue,
    /// مدير نماذج التحقق.
    /// Validation form manager.
    required this.form,
    /// دالة لتتبع تغيير القيمة.
    /// On change callback.
    this.onChange,
    /// وضع إدخال منتقي التاريخ.
    /// Date picker entry mode.
    this.entryMode = DatePickerEntryMode.calendar,
  });

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
              child: Text(labalText!,  style: labelStyle ??  textStyle ,)),
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
        Text(labalText!,    style: labelStyle?? textStyle ,),
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
