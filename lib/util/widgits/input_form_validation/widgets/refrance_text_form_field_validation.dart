import 'package:JoDija_tamplites/util/widgits/input_form_validation/lable_desplty.dart';
import 'package:flutter/material.dart';

import '../../../../util/validators/base_validator.dart';
import '../../../functions/show_dialog.dart';
import '../../../view_data_model/base_data_model.dart';
import '../../input_output_cell_binder/intpu_cell_binder.dart';
import '../../input_text/dateTime_input_text_field.dart';
import '../../input_text/refrance_input_text_field.dart';
import '../form_validations.dart';
import '../input_validation_item.dart';

/// حقل إدخال مرجعي (Reference Input) يتيح اختيار قيمة من قائمة أو نافذة منبثقة، مدمج مع نظام التحقق.
/// A reference input field that allows selecting a value from a list or dialog, integrated with the validation system.
class RefranceValidaion<T extends BaseViewDataModel> extends StatelessWidget
    implements InputValidationForm, InputFeildBinder {
  /// التنسيق الخاص بحقل الإدخال.
  /// The decoration of the input field.
  InputDecoration decoration;
  
  /// تصميم النص المكتوب أو المختار.
  /// The text style of the inputted/selected text.
  TextStyle textStyle;
  
  /// تصميم نص العنوان (Label).
  /// The text style for the label.
  TextStyle? labelStyle;
  
  /// قائمة شروط التحقق المطبقة على هذا الحقل.
  /// The list of validators applied to this field.
  List<BaseValidator>? baseValidation;
  
  /// نموذج التحقق الأساسي (ValidationsForm) الذي يرتبط به هذا الحقل.
  /// The form validation manager (ValidationsForm) this field is linked to.
  ValidationsForm form;
  
  /// العنوان التعريفي للحقل.
  /// The label text of the field.
  String? labalText;
  
  /// المفتاح المستخدم لعرض القيمة المختارة (مثل: name).
  /// The key used to display the selected value (e.g., name).
  String keyDesplay;
  
  /// المفتاح الفريد المستخدم لحفظ القيمة الفعلية في البيانات (مثل: id).
  /// The unique key used to save the actual value in the data (e.g., id).
  String keyData;
  
  /// خريطة البيانات التي يُحفظ فيها ناتج هذا الحقل محلياً.
  /// The local map where the field's resulting value is stored.
  Map<String, dynamic>? mapValue;
  
  /// طريقة عرض العنوان (Label) أعلى الحقل أو بجانبه.
  /// How the label is displayed relative to the input field.
  LabelDisplay labelDisplay = LabelDisplay.none;
  
  /// دالة تُستدعى عند تغير القيمة.
  /// Callback triggered when the value changes.
  var onChange;
  
  /// دالة تُستدعى عندما يتم اختيار قيمة من النافذة أو القائمة، وتُرجع الكائن المختار بالكامل.
  /// Callback triggered when a value is selected, returning the fully selected object.
  void Function(T? data) onResult;
  
  /// المتحكم الخاص بالنص (TextEditingController).
  /// The text editing controller.
  TextEditingController? controller;
  
  /// الإعدادات الخاصة بالنافذة المنبثقة لاختيار العنصر المرجعي.
  /// Configuration for the dialog used to select the reference item.
  ShowInputFieldsDialogs<T> showInputDialoge;

  RefranceValidaion({
    /// زخرفة الحقل.
    /// Field decoration.
    required this.decoration,
    /// تصميم النص المدخل أو المختار.
    /// Input or selected text style.
    required this.textStyle,
    /// مفتاح حفظ البيانات في الخريطة.
    /// Data save key.
    required this.keyData,
    /// مفتاح عرض البيانات.
    /// Data display key.
    required this.keyDesplay,
    /// شروط التحقق.
    /// Validation rules.
    required this.baseValidation,
    /// تصميم نص العنوان.
    /// Label text style.
    this.labelStyle,
    /// نص العنوان الخاص بالحقل.
    /// Label text of the field.
    required this.labalText,
    /// خريطة حفظ القيمة محلياً.
    /// Value saving map.
    this.mapValue,
    /// نموذج التحقق الأساسي.
    /// Main validation form.
    required this.form,
    /// طريقة عرض العنوان (Label).
    /// Label display mode.
    this.labelDisplay = LabelDisplay.none,
    /// دالة تغير القيمة.
    /// On change callback.
    this.onChange,
    /// دالة استلام الكائن المختار.
    /// Callback receiving the selected object.
    required this.onResult,
    /// مربع الحوار لاختيار العنصر.
    /// Dialog to select item.
    required this.showInputDialoge,
    /// متحكم النص المخصص.
    /// Custom text controller.
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    mapValue = Map<String, dynamic>();
    form.inputValidationForm.add(this);
    if (controller == null) controller = TextEditingController();
    if (labelDisplay == LabelDisplay.none) {
      return RefranceFormField(
          controller: controller,
          textStyle: textStyle,
          decoration: labalText == null
              ? InputDecoration()
              : InputDecoration(
                  labelText: labalText,
                ),
          hintText: labalText,
          onTap: () {
            showInputDialoge.showDialogs(context, onResult: (data) {
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
    } else if (labelDisplay == LabelDisplay.rowDisplay) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
        child: Row(
          children: [
            Expanded(
              child: Text(
                labalText!,
                style: labelStyle ?? textStyle,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 10,
              child: RefranceFormField(
                  controller: controller,
                  textStyle: textStyle,
                  decoration: decoration,
                  hintText: labalText,
                  onTap: () {
                    showInputDialoge.showDialogs(context, onResult: (data) {
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
                  }),
            )
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labalText!,
              style: labelStyle ?? textStyle,
            ),
            Container(
                child: RefranceFormField(
                    controller: controller,
                    textStyle: textStyle,
                    decoration: decoration,
                    hintText: labalText,
                    onTap: () {
                      showInputDialoge.showDialogs(context, onResult: (data) {
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
                    }))
          ],
        ),
      );
    }
  }

  @override
  // TODO: implement nameCaption
  get nameCaption => labalText;
}
