import 'package:JoDija_tamplites/util/cell_models/cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Field<T> extends Cell {
  String nameCaption;
  Field(super.name, {T? value, required this.nameCaption}) {
    this.value = value;
  }
  Widget _InputField = Container();
  Widget _outputField = Container();
  Widget _header = Container();
  TextEditingController controller = TextEditingController();
  // getter and setter for the header
  Widget get header => _header;
  set header(Widget header) {
    _header = header;
  }

  // getter and setter for the input field
  Widget get inputField => _InputField;
  set inputField(Widget inputField) {
    _InputField = inputField;
  }

  // getter and setter for the output field
  Widget get outputField => _outputField;
  set outputField(Widget outputField) {
    _outputField = outputField;
  }
}
