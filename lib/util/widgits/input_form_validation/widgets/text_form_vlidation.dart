import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../validators/base_validator.dart';
import '../../input_output_cell_binder/intpu_cell_binder.dart';
import '../../input_text/input_text_field.dart';
import '../form_validations.dart';
import '../input_validation_item.dart';
import '../lable_desplty.dart';

class TextFomrFildValidtion extends StatelessWidget
    implements InputValidationForm, InputFeildBinder {
  InputDecoration decoration;
  TextStyle textStyle;
  bool isPssword;

  TextInputType textInputType = TextInputType.text;
  EdgeInsets? padding;
  dynamic initValue;
  bool isReadOnly;
  final ValueChanged<String>? onFieldSubmitted;
  Function(String v )? onChange;

  TextEditingController? controller = TextEditingController();
  TextEditingController  controllerInit  = TextEditingController();
  FocusNode? node;
  int? mulitLine;
  List<BaseValidator>? baseValidation;
  String? labalText = "";
  String keyData;

  ValidationsForm form;
  Map<String, dynamic>? mapValue;
  LabelDisplay labelDisplay = LabelDisplay.none;
  TextFomrFildValidtion(
      {super.key,
      this.onFieldSubmitted,
      required this.form,

      required this.baseValidation,
      this.labalText = "",
      required this.keyData,
      this.mapValue,
      this.mulitLine,
      this.isReadOnly = false,
      this.labelDisplay = LabelDisplay.none,
      this.node,
      this.padding,
      this.decoration = const InputDecoration(),
      this.textStyle = const TextStyle(),
      this.isPssword = false,
      this.textInputType = TextInputType.text,
      this.initValue,
        this.onChange ,
      this.controller});

  @override
  Widget build(BuildContext context) {
    form.inputValidationForm.add(this);

    if (mapValue == null) {
      mapValue = Map<String, dynamic>();
    }
    if (controller == null) {
      controller = controllerInit ;
    }



    if (labelDisplay == LabelDisplay.none) {
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
            onChange!(v);

            controller!.text = v;
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
    } else if (labelDisplay == LabelDisplay.rowDisplay) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  labalText!,
                  style: textStyle,
                )),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 10,
                  child: InputTextFormfield(
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
                      decoration: decoration,
                      onChange: (v) {
                        // if value not == mainValue then  set to mainValue

                        onChange!(v);
                        controller!.text = v;
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
                      }),
                ),
              ],
            ),
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
              style: textStyle,
            ),
            Container(
              child: InputTextFormfield(
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
                  decoration: decoration,
                  onChange: (v) {
                    // if value not == mainValue then  set to mainValue
                    onChange!(v);
                    controller!.text = v;
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
                  }),
            )
          ],
        ),
      );
    }
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

  @override
  // TODO: implement nameCaption
  get nameCaption => this.labalText;
}
