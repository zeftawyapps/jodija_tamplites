import 'package:JoDija_view/util/widgits/input_form_validation/input_validation_item.dart';
import 'package:flutter/cupertino.dart';

abstract class InputFeildBinder extends InputValidationForm {


  InputFeildBinder({required super.form, required super.keyData , required super.labalText});
  get nameCaption => super.labalText;
  Widget build(BuildContext context);
}

abstract class DataTableFieldBinder {
  Widget build(BuildContext context);
}