import 'package:flutter/cupertino.dart';
import 'base_validator.dart';

/// مدقق القيم الرقمية (Numeric Value Validator)
///
/// يتحقق من أن القيمة المدخلة تمثل رقماً صحيحاً أو عشرياً صالحاً (`num.tryParse`).
///
/// English Description:
/// Validates that an input string parses successfully into a valid numeric value ([num]).
class NumperValidator extends BaseValidator {
  final String? message;

  NumperValidator({this.message});

  @override
  String getMessage(BuildContext context) {
    return message ?? "يجب إدخال قيمة رقمية صحيحة (Invalid number)";
  }

  @override
  bool validate(String value) {
    if (value.trim().isEmpty) return false;
    final number = num.tryParse(value.trim());
    return number != null;
  }
}
