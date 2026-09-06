import 'package:flutter/cupertino.dart';
import 'base_validator.dart';

/// مدقق صحة البريد الإلكتروني (Email Address Validator)
///
/// يتحقق من مطابقة القيمة المدخلة لصيغة البريد الإلكتروني المعيارية (RFC RegExp).
///
/// English Description:
/// Validates that an input string conforms to standard RFC email address format patterns.
class EmailValidator extends BaseValidator {
  final String? message;

  EmailValidator({this.message});

  @override
  String getMessage(BuildContext context) {
    return message ?? "البريد الإلكتروني غير صحيح (Invalid email)";
  }

  @override
  bool validate(String value) {
    final emailRegExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );
    return value.isNotEmpty && emailRegExp.hasMatch(value);
  }
}
