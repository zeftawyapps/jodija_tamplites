import 'package:flutter/material.dart';
import 'base_validator.dart';

/// مدقق كلمة المرور والأمان (Password Length & Security Validator)
///
/// يتحقق من طول كلمة المرور (الافتراضي بين 6 و 20 محرفاً).
///
/// English Description:
/// Validates password inputs ensuring compliance with length requirements (default: 6-20 characters).
class PasswordValidator extends BaseValidator {
  final String? message;
  final int minLength;
  final int maxLength;

  PasswordValidator({
    this.message,
    this.minLength = 6,
    this.maxLength = 20,
  });

  @override
  String getMessage(BuildContext context) {
    return message ?? "كلمة المرور يجب أن تكون بين $minLength و $maxLength محرفاً (Invalid password)";
  }

  @override
  bool validate(String value) {
    return value.length >= minLength && value.length <= maxLength;
  }
}
