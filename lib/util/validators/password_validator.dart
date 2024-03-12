import 'package:flutter/material.dart';
import 'base_validator.dart';

class PasswordValidator extends BaseValidator {
  final String? message;
  PasswordValidator({this.message});
  @override
  String getMessage(BuildContext context) {
    return message ?? "Invalid password";
  }

  @override
  bool validate(String value) {
    final _passwordRegExp = RegExp(r'^.{6,20}$');
    return value != null && _passwordRegExp.hasMatch(value);
  }
}
