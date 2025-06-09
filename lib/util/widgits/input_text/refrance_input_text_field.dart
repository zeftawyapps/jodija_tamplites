import 'package:JoDija_tamplites/util/functions/date_time.dart';
import 'package:flutter/material.dart';

import 'input_text_field.dart';

class RefranceFormField extends StatefulWidget {
  RefranceFormField({
    Key? key,
    required this.decoration,
    required this.textStyle,
    required this.hintText,
    required this.onSave,
    this.onChange,
    required this.onvlaidate,
    required this.onTap,
    this.controller,
  }) : super(key: key);
  TextEditingController? controller;
  InputDecoration decoration;

  String? hintText;
  TextStyle textStyle;

  var onvlaidate, onSave, onChange, onTap;

  @override
  State<RefranceFormField> createState() => _RefranceFormFieldState();
}

class _RefranceFormFieldState extends State<RefranceFormField> {
  DateTime? value = null;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.controller == null) {
      widget.controller = TextEditingController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InputTextFormfield(
        addTools: true,
        style: widget.textStyle,
        readOnly: true,
        controller: widget.controller,
        onChange: widget.onChange,
        onTap: widget.onTap,
        decoration: widget.decoration,
        validate: widget.onvlaidate,
        saved: widget.onSave,
        mainValue: this.value == null ? null : "");
  }
}
