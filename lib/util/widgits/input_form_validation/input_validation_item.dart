 import 'package:flutter/material.dart';

import '../../../util/validators/base_validator.dart';
import 'form_validations.dart';
abstract  class InputValidationForm{

    String hintText ;
    String keyData ;
    ValidationsForm form;
    Map<String , dynamic>? mapValue;
    List<BaseValidator>? baseValidation ;
   InputValidationForm( {
     required this.form,
     required this.keyData , this.baseValidation ,
      required this.hintText , this.mapValue});


}