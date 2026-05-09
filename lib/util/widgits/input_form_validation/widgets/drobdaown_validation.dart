import 'package:flutter/material.dart';
import '../../../../util/validators/base_validator.dart';
import '../../input_output_cell_binder/intpu_cell_binder.dart';
import '../../input_text/dropDown_text_feild.dart';
import '../form_validations.dart';
import '../input_validation_item.dart';
import '../lable_desplty.dart';

/// قائمة منسدلة (Dropdown) مدمجة مع نظام التحقق (Validation).
/// A dropdown input field integrated with the validation system.
// ignore: must_be_immutable
class DrobDaownValidation extends StatefulWidget
    implements InputValidationForm, InputFeildBinder {
  @override
  /// قائمة شروط التحقق المطبقة.
  /// The list of validators applied.
  List<BaseValidator>? baseValidation;
  @override
  /// نموذج التحقق المرتبط بهذا الحقل.
  /// The form validation manager.
  ValidationsForm form;
  @override
  /// المفتاح الفريد لحفظ القيمة في خريطة البيانات.
  /// The unique key to save the value in the data map.
  String keyData;
  @override
  /// العنوان التعريفي للحقل.
  /// The label text of the field.
  String? labalText;
  @override
  /// خريطة البيانات التي يُحفظ فيها الناتج محلياً.
  /// The local map where the value is stored.
  Map<String, dynamic>? mapValue;

  /// قائمة العناصر (النصوص) التي ستظهر داخل القائمة المنسدلة.
  /// The list of items (strings) to display in the dropdown.
  final List<String> itemslsit;
  
  /// التنسيق الخاص بحقل الإدخال.
  /// The decoration of the input field.
  final InputDecoration decoration;
  
  /// تصميم النص الذي يظهر في الحقل (للعنصر المختار).
  /// The text style of the inputted/selected text.
  final TextStyle textStyle;
  
  /// تصميم نص العنوان (Label).
  /// The text style for the label.
  final TextStyle? labelStyle;
  
  /// دالة تُستدعى عند تغير العنصر المختار.
  /// Callback triggered when the selected item changes.
  final dynamic onChange;
  
  /// طريقة عرض العنوان (أعلى الحقل، بجانبه، أو مخفي).
  /// How the label is displayed relative to the field.
  final LabelDisplay lableDesplty;
  
  /// الفهرس المبدئي (Index) للعنصر المختار افتراضياً من القائمة.
  /// The initial selected index from the list.
  final int index;

  DrobDaownValidation({
    super.key,
    /// زخرفة الحقل.
    /// Field decoration.
    required this.decoration,
    /// تصميم النص المدخل أو المختار.
    /// Input or selected text style.
    required this.textStyle,
    /// قائمة العناصر.
    /// The list of items.
    required this.itemslsit,
    /// مفتاح حفظ القيمة.
    /// Data save key.
    required this.keyData,
    /// شروط التحقق.
    /// Validators.
    required this.baseValidation,
    /// تصميم نص العنوان.
    /// Label text style.
    this.labelStyle,
    /// نص العنوان.
    /// Label text.
    this.labalText,
    /// طريقة العرض الخاصة بالعنوان.
    /// Label display mode.
    this.lableDesplty = LabelDisplay.none,
    /// دالة لتتبع تغيير القيمة.
    /// On change callback.
    this.onChange,
    /// الفهرس الافتراضي للعنصر المختار.
    /// The default selected index.
    this.index = 0,
    /// مدير نماذج التحقق.
    /// Validation form manager.
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
