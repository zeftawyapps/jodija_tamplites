import 'package:JoDija_view/util/widgits/input_form_validation/lable_desplty.dart';
import 'package:flutter/material.dart';

import '../../../../util/validators/base_validator.dart';
import '../../../functions/show_dialog.dart';
import '../../../view_data_model/base_data_model.dart';
import '../../input_output_cell_binder/intpu_cell_binder.dart';
import '../../input_text/dateTime_input_text_field.dart';
import '../../input_text/refrance_input_text_field.dart';
import '../form_validations.dart';
import '../input_validation_item.dart';

class RefranceValidaion<T extends BaseViewDataModel> extends StatelessWidget
    implements InputValidationForm, InputFeildBinder {
  InputDecoration decoration;
  TextStyle textStyle;
  TextStyle? labelStyle;
  List<BaseValidator>? baseValidation;
  ValidationsForm form;
  String? labalText;
  String keyDesplay;
  String keyData;
  Map<String, dynamic>? mapValue;
  LabelDisplay labelDisplay = LabelDisplay.none;
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
      this.labelDisplay = LabelDisplay.none,
      this.onChange,
      required this.onResult,
      required this.showInputDialoge,
      this.controller});

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
            SizedBox(width: 5,),
            Expanded(flex:  10 ,
              child:  RefranceFormField(
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
    }else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labalText!,
              style: labelStyle ?? textStyle,
            ),
            Container(child: RefranceFormField(
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
