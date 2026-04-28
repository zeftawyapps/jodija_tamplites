import 'package:flutter/material.dart';
import '../../../../util/validators/base_validator.dart';
import '../../input_output_cell_binder/intpu_cell_binder.dart';
import '../../input_text/dropDown_text_feild.dart';
import '../form_validations.dart';
import '../input_validation_item.dart';
import '../lable_desplty.dart';

// ignore: must_be_immutable
class DrobDaownValidation extends StatefulWidget
    implements InputValidationForm, InputFeildBinder {
  @override
  List<BaseValidator>? baseValidation;
  @override
  ValidationsForm form;
  @override
  String keyData;
  @override
  String? labalText;
  @override
  Map<String, dynamic>? mapValue;

  final List<String> itemslsit;
  final InputDecoration decoration;
  final TextStyle textStyle;
  final TextStyle? labelStyle;
  final dynamic onChange;
  final LabelDisplay lableDesplty;
  final int index;

  DrobDaownValidation({
    super.key,
    required this.decoration,
    required this.textStyle,
    required this.itemslsit,
    required this.keyData,
    required this.baseValidation,
    this.labelStyle,
    this.labalText,
    this.lableDesplty = LabelDisplay.none,
    this.onChange,
    this.index = 0,
    required this.form,
  });

  @override
  State<DrobDaownValidation> createState() => _DrobDaownValidationState();

  @override
  get nameCaption => labalText;

  @override
  Widget build(BuildContext context) {
    // This is required by the interface but not used by Flutter for StatefulWidget.
    // Flutter will call the build method in the State class.
    return const SizedBox.shrink();
  }
}

class _DrobDaownValidationState extends State<DrobDaownValidation> {
  @override
  void initState() {
    super.initState();
    widget.mapValue = <String, dynamic>{};
    if (widget.itemslsit.isNotEmpty &&
        widget.index >= 0 &&
        widget.index < widget.itemslsit.length) {
      widget.mapValue![widget.keyData] = widget.itemslsit[widget.index];
    }
    widget.form.inputValidationForm.add(widget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.lableDesplty == LabelDisplay.none) {
      return DropDownInputTextField(
        textStyle: widget.textStyle,
        itemslsit: widget.itemslsit,
        hintText: widget.labalText ?? "",
        decoration: widget.decoration,
        val: widget.itemslsit[widget.index],
        onChange: (v) {
          widget.mapValue![widget.keyData] = v;
          if (widget.onChange != null) {
            widget.onChange(v);
          }
        },
        validation: (v) {
          if (widget.baseValidation != null) {
            return BaseValidator.validateValue(
                context, v.toString().trim(), widget.baseValidation!);
          } else {
            return null;
          }
        },
        onsaved: (v) {
          widget.mapValue![widget.keyData] = v;
        },
      );
    } else if (widget.lableDesplty == LabelDisplay.rowDisplay) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                widget.labalText!,
                style: widget.labelStyle ?? widget.textStyle,
              )),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 10,
                child: DropDownInputTextField(
                  textStyle: widget.labelStyle,
                  itemslsit: widget.itemslsit,
                  hintText: widget.labalText ?? "",
                  decoration: widget.decoration,
                  val: widget.itemslsit[widget.index],
                  onChange: (v) {
                    widget.mapValue![widget.keyData] = v;
                    if (widget.onChange != null) {
                      widget.onChange(v);
                    }
                  },
                  validation: (v) {
                    if (widget.baseValidation != null) {
                      return BaseValidator.validateValue(
                          context, v.toString().trim(), widget.baseValidation!);
                    } else {
                      return null;
                    }
                  },
                  onsaved: (v) {
                    widget.mapValue![widget.keyData] = v;
                  },
                ),
              ),
            ],
          ));
    } else {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.labalText!,
                style: widget.labelStyle ?? widget.textStyle,
              ),
              DropDownInputTextField(
                textStyle: widget.textStyle,
                itemslsit: widget.itemslsit,
                hintText: widget.labalText ?? "",
                decoration: widget.decoration,
                val: widget.itemslsit[widget.index],
                onChange: (v) {
                  widget.mapValue![widget.keyData] = v;
                  if (widget.onChange != null) {
                    widget.onChange(v);
                  }
                },
                validation: (v) {
                  if (widget.baseValidation != null) {
                    return BaseValidator.validateValue(
                        context, v.toString().trim(), widget.baseValidation!);
                  } else {
                    return null;
                  }
                },
                onsaved: (v) {
                  widget.mapValue![widget.keyData] = v;
                },
              ),
            ],
          ));
    }
  }
}
