class InputDataBinder {
  String keyData;
  dynamic value;
  InputTypeWidget inputType;
  InputDataBinder({required this.keyData, this.value, required this.inputType});
}

enum InputTypeWidget { text, dropDown, dateTiem }
