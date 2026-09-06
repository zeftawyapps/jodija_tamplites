import 'package:flutter/cupertino.dart';
import 'base_validator.dart';

/// مدقق الحقول الإلزامية (Required Field Validator)
///
/// يتحقق من أن القيمة المدخلة ليست فارغة وليست null.
///
/// English Description:
/// Ensures that an input field contains non-empty, non-whitespace string content.
class RequiredValidator extends BaseValidator {
  final String? customMessage;

  RequiredValidator({this.customMessage});

  @override
  String getMessage(BuildContext context, {String? msg}) {
    return customMessage ?? msg ?? "هذا الحقل مطلوب";
  }

  @override
  bool validate(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
}