import 'package:flutter/material.dart';

/// الواجهة التجريدية لمدققات الحقول والمدخلات (Base Form Field Validator Contract)
///
/// تمثل الأساس لكافة أدوات التحقق من صحة البيانات (البريد، كلمة المرور، الحقول الإلزامية، الأرقام).
/// توفر دالة الفحص `validate` ودالة جلب رسالة الخطأ المترجمة `getMessage`.
///
/// English Description:
/// Abstract validation strategy contract for input fields and form validation.
/// Defines rule evaluation via [validate] and localized error message retrieval via [getMessage].
///
/// ### مثال للاستخدام (Usage Example):
/// ```dart
/// final error = BaseValidator.validateValue(context, text, [
///   RequiredValidator(),
///   EmailValidator(),
/// ]);
/// ```
abstract class BaseValidator {
  /// التحقق من صحة القيمة المدخلة (Evaluates validity of given string value)
  bool validate(String value);

  /// استرجاع رسالة الخطأ المترجمة (Returns localized error message)
  String getMessage(BuildContext context);

  /// فحص القيمة عبر قائمة من المدققات بالترتيب (Validates value sequentially against validators list)
  static String? validateValue(
    BuildContext context,
    String value,
    List<BaseValidator> validators,
  ) {
    for (int i = 0; i < validators.length; i++) {
      if (!validators[i].validate(value)) {
        return validators[i].getMessage(context);
      }
    }
    return null;
  }
}