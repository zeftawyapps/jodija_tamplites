import 'package:flutter/material.dart';
import '../../../../util/validators/base_validator.dart';
import '../../input_output_cell_binder/intpu_cell_binder.dart';
import '../../input_text/dropDown_text_feild.dart';
import '../form_validations.dart';
import '../input_validation_item.dart';
import '../lable_desplty.dart';

class DrobDaownValidation extends StatelessWidget
    implements InputValidationForm, InputFeildBinder {
  List<String> itemslsit;
  InputDecoration decoration;
  TextStyle textStyle;
  TextStyle ? labelStyle;
  List<BaseValidator>? baseValidation;
  ValidationsForm form;
  String? labalText;
  String keyData;
  int index = 0;

  Map<String, dynamic>? mapValue;
  // call back to get the value of the drop down
  var onChange;
  LabelDisplay lableDesplty = LabelDisplay.none;

  DrobDaownValidation(
      {required this.decoration,
      required this.textStyle,
      required this.itemslsit,
      required this.keyData,
      required this.baseValidation,

      this.labalText,
      this.lableDesplty = LabelDisplay.none,
      this.mapValue,
      this.onChange,
      this.index = 0,
      required this.form});
  @override
  Widget build(BuildContext context) {
    mapValue = Map<String, dynamic>();
    form.inputValidationForm.add(this);
    if (lableDesplty == LabelDisplay.none) {
      return DropDownInputTextField(
        textStyle: textStyle,
        itemslsit: itemslsit,
        hintText: labalText != null ? labalText! : "",
        decoration: decoration,
        val: itemslsit[index],
        onChange: (v) {
          mapValue!["$keyData"] = v;
          if (onChange != null) {
            onChange(v);
          }
        },
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
    } else if (lableDesplty == LabelDisplay.rowDisplay) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
          child: Row(
        children: [
          Expanded (child: Text(labalText! , style:  labelStyle??textStyle ,)),
          SizedBox(width: 5,),
          Expanded(flex:  10 ,
            child: DropDownInputTextField(
              textStyle: labelStyle,
              itemslsit: itemslsit,
              hintText: labalText != null ? labalText! : "",
              decoration: decoration,
              val: itemslsit[index],
              onChange: (v) {
                mapValue!["$keyData"] = v;
                if (onChange != null) {
                  onChange(v);
                }
              },
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
            ),
          ),
        ],
      ));
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labalText! , style: labelStyle?? textStyle ,),
          Container(
            child: DropDownInputTextField(
              textStyle: textStyle,
              itemslsit: itemslsit,
              hintText: labalText != null ? labalText! : "",
              decoration: decoration,
              val: itemslsit[index],
              onChange: (v) {
                mapValue!["$keyData"] = v;
                if (onChange != null) {
                  onChange(v);
                }
              },
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
            ),
          ),
        ],
      ));
    }
  }

  @override
  // TODO: implement nameCaption
  get nameCaption => labalText;
}
