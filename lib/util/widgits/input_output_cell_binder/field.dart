import 'package:flutter/material.dart';
import '../../cell_models/cell.dart';
import '../../cell_models/cell_data_type.dart';

/// كائن الحقل (Field) الجامع بين البيانات (Cell) وواجهات الإدخال والعرض والرأس
/// Unifies Data Layer (Cell), Input Widget, Output View Widget, and Table Header.
class Field<T> extends Cell<T> {
  /// التسمية التوضيحية للحقل
  String nameCaption;

  /// عنصر واجهة الإدخال
  Widget _inputField = const SizedBox.shrink();

  /// عنصر واجهة العرض للقراءة فقط
  Widget _outputField = const SizedBox.shrink();

  /// عنصر رأس العمود (Header)
  Widget _header = const SizedBox.shrink();

  /// المتحكم الخاص بالنص
  TextEditingController controller = TextEditingController();

  Field(
    super.name, {
    super.value,
    required this.nameCaption,
    super.type = CellDataType.text,
    super.unit,
    super.options,
    super.isRequired = false,
    super.hint,
    super.defaultValue,
    Widget? inputField,
    Widget? outputField,
    Widget? header,
  }) : super(caption: nameCaption) {
    if (inputField != null) _inputField = inputField;
    if (outputField != null) _outputField = outputField;
    if (header != null) _header = header;

    // تهيئة النص في المتحكم إذا كانت هناك قيمة أولية نصية
    if (value != null) {
      controller.text = value.toString();
    }
  }

  // Getters and Setters
  Widget get header => _header;
  set header(Widget header) => _header = header;

  Widget get inputField => _inputField;
  set inputField(Widget inputField) => _inputField = inputField;

  Widget get outputField => _outputField;
  set outputField(Widget outputField) => _outputField = outputField;

  /// استنساخ الحقل
  @override
  Field<T> copyWith({
    String? name,
    T? value,
    CellDataType? type,
    String? caption,
    String? unit,
    List<String>? options,
    bool? isRequired,
    String? hint,
    T? defaultValue,
    Widget? inputField,
    Widget? outputField,
    Widget? header,
  }) {
    final f = Field<T>(
      name ?? this.name,
      value: value ?? this.value,
      nameCaption: caption ?? nameCaption,
      type: type ?? this.type,
      unit: unit ?? this.unit,
      options: options ?? (this.options != null ? List.from(this.options!) : null),
      isRequired: isRequired ?? this.isRequired,
      hint: hint ?? this.hint,
      defaultValue: defaultValue ?? this.defaultValue,
      inputField: inputField ?? _inputField,
      outputField: outputField ?? _outputField,
      header: header ?? _header,
    );
    f.controller = controller;
    return f;
  }
}
