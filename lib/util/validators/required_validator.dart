import 'package:flutter/cupertino.dart';

import 'base_validator.dart';

class RequiredValidator extends BaseValidator {

  @override
  String getMessage(BuildContext context , {String? msg }) {
    return msg ?? "هذا الخقل مطلوب";
  }

  @override
  bool validate(String? value) {
    return value != null && value.isNotEmpty;
  }
}