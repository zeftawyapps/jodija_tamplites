import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../validators/base_validator.dart';
import '../../input_output_cell_binder/intpu_cell_binder.dart';
import '../../input_text/input_text_field.dart';
import '../form_validations.dart';
import '../input_validation_item.dart';
import '../lable_desplty.dart';

/// حقل إدخال نصي مدمج مع نظام التحقق (Validation).
/// A text input field integrated with the validation system.
class TextFomrFildValidtion extends StatelessWidget
    implements InputValidationForm, InputFeildBinder {
  /// التنسيق الخاص بحقل الإدخال (مثل الحدود والألوان).
  /// The decoration of the input field (e.g., borders, colors).
  InputDecoration decoration;
  
  /// تصميم النص الذي يكتبه المستخدم.
  /// The text style of the user input.
  TextStyle textStyle;
  
  /// تصميم النص الخاص بالعنوان (Label).
  /// The text style for the label.
  TextStyle? labelStyle;
  
  /// هل الحقل مخصص لكلمة مرور (يتم إخفاء النص).
  /// Whether the field is for a password (hides the text).
  bool isPssword;

  /// نوع لوحة المفاتيح (أرقام، نصوص، بريد إلكتروني، إلخ).
  /// The type of keyboard to display (e.g., numbers, text, email).
  TextInputType textInputType = TextInputType.text;
  
  /// الهوامش الداخلية أو الخارجية للحقل.
  /// The padding around or inside the field.
  EdgeInsets? padding;
  
  /// القيمة المبدئية التي يظهر بها الحقل.
  /// The initial value displayed in the field.
  dynamic initValue;
  
  /// هل الحقل للقراءة فقط (لا يمكن تعديله).
  /// Whether the field is read-only (cannot be edited).
  bool isReadOnly;
  
  /// وظيفة يتم استدعاؤها عند الضغط على زر الإرسال (Enter/Done) في لوحة المفاتيح.
  /// Callback triggered when the submit button (Enter/Done) is pressed on the keyboard.
  final ValueChanged<String>? onFieldSubmitted;
  
  /// وظيفة يتم استدعاؤها في كل مرة يتغير فيها النص المكتوب.
  /// Callback triggered every time the written text changes.
  Function(String v)? onChange;

  /// المتحكم الخاص بالنص (TextEditingController).
  /// The text editing controller.
  TextEditingController? controller = TextEditingController();
  
  /// المتحكم الافتراضي الذي يتم استخدامه داخلياً في حال لم يتم توفير متحكم.
  /// The default controller used internally if none is provided.
  TextEditingController controllerInit = TextEditingController();
  
  /// عقدة التركيز (FocusNode) الخاصة بالحقل لتحديد حالة التركيز.
  /// The focus node for the field to manage its focus state.
  FocusNode? node;
  
  /// أقصى عدد من الأسطر يمكن كتابتها (يُستخدم للنصوص المتعددة الأسطر).
  /// The maximum number of lines allowed (used for multiline text).
  int? mulitLine;
  
  /// قائمة بشروط التحقق (Validators) التي يجب أن يستوفيها الحقل.
  /// A list of validators the field must pass.
  List<BaseValidator>? baseValidation;
  
  /// العنوان التعريفي للحقل (Label).
  /// The label text for the field.
  String? labalText = "";
  
  /// المفتاح الفريد (Key) الذي ستُخزن به قيمة الحقل في خريطة البيانات (Map).
  /// The unique key used to store the field's value in the data map.
  String keyData;

  /// نموذج التحقق (ValidationsForm) الذي يرتبط به هذا الحقل.
  /// The form validation manager (ValidationsForm) this field is linked to.
  ValidationsForm form;
  
  /// خريطة البيانات التي يُحفظ فيها ناتج هذا الحقل محلياً.
  /// The local map where the field's resulting value is stored.
  Map<String, dynamic>? mapValue;
  
  /// طريقة عرض العنوان (Label) أعلى الحقل أو بجانبه.
  /// How the label is displayed relative to the input field.
  LabelDisplay labelDisplay = LabelDisplay.none;
  TextFomrFildValidtion({
    super.key,
    /// وظيفة تُستدعى عند الإرسال من لوحة المفاتيح.
    /// Callback triggered upon submission from the keyboard.
    this.onFieldSubmitted,
    /// نموذج التحقق الأساسي.
    /// The main validation form manager.
    required this.form,
    /// قائمة بشروط التحقق الأساسية (Validators).
    /// The list of base validators.
    required this.baseValidation,
    /// نص العنوان الخاص بالحقل.
    /// The label text of the field.
    this.labalText = "",
    /// مفتاح حفظ البيانات في القاموس/الخريطة.
    /// The key to save data in the map.
    required this.keyData,
    /// تصميم نص العنوان.
    /// The style for the label text.
    this.labelStyle,
    /// خريطة لتخزين قيمة الحقل المعينة محلياً.
    /// A map to store the specific field value locally.
    this.mapValue,
    /// عدد الأسطر (يُمرر للمقالات أو النصوص الطويلة).
    /// Number of lines (used for multi-line inputs).
    this.mulitLine,
    /// لتحديد إن كان الحقل للقراءة فقط.
    /// Indicates if the field is read-only.
    this.isReadOnly = false,
    /// طريقة ظهور العنوان (Label).
    /// The display style for the label.
    this.labelDisplay = LabelDisplay.none,
    /// مدير التركيز (FocusNode).
    /// The FocusNode.
    this.node,
    /// الهوامش (Padding).
    /// Padding.
    this.padding,
    /// زخرفة الحقل المخصصة.
    /// Custom field decoration.
    this.decoration = const InputDecoration(),
    /// تصميم النص المدخل.
    /// Input text style.
    this.textStyle = const TextStyle(),
    /// لتحديد إن كان الحقل لكلمة المرور.
    /// Indicates if it's a password field.
    this.isPssword = false,
    /// نوع لوحة المفاتيح.
    /// The keyboard type.
    this.textInputType = TextInputType.text,
    /// القيمة الافتراضية للحقل.
    /// The initial value of the field.
    this.initValue,
    /// دالة استدعاء التغيير (On Change).
    /// The on change callback.
    this.onChange,
    /// متحكم النص المخصص.
    /// Custom text editing controller.
    this.controller,
  });

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
            if (onChange != null) {
              onChange!(v);
              controller!.text = v;
            }


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
                  style: labelStyle?? textStyle ,
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
              style: labelStyle?? textStyle,
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
