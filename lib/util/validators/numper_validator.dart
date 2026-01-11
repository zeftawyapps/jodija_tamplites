import 'package:flutter/cupertino.dart';

import 'base_validator.dart';

class NumperValidator extends BaseValidator {
  final String? message;
  NumperValidator({this.message});
  @override
  String getMessage(BuildContext context) {
    return message ?? "Invalid number";
  }

  @override
  bool validate(String value) {
    if (value.isEmpty) return false;
    final number = num.tryParse(value);
    return number != null;
  }
}
