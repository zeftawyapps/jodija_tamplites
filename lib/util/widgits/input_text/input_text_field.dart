import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextFormfield extends StatefulWidget {
  final dynamic? mainValue;
  final bool enabled;
  var saved;
  Function(String)? onChange;
  final Icon? icons;
  final Image? image;
  var validate;
  final bool? isPressed;
  TextInputType _textInputType = TextInputType.text;
  final int? fontSize;
  final TextStyle? style;
  final Icon? suffixIcon;
  final Image? suffixIcon2;
  final Color? fillColor;
  final Color? hintColor;
  final Color? labelColor;
  final int? maxLines;
  final int? maxLetterLength;
  final ValueChanged<String>? onFieldSubmitted;
  final AutovalidateMode? autoValidateMode;
  FocusNode? node = FocusNode();
  TextEditingController? controller;
  TextAlign? textAlign = TextAlign.right;
  int? characterLimit;
  var onTap;
  bool readOnly ;
  InputDecoration decoration;
  InputTextFormfield({
    required this.decoration,
    this.onTap,
    this.validate,
    required this.saved,
    this.onChange,
    this.image,
    this.style,
    this.icons,
    this.maxLetterLength,
    this.autoValidateMode,
    this.isPressed,
    this.fontSize,
    this.mainValue,
    this.maxLines,
    this.suffixIcon2,
    this.enabled = true,
    this.fillColor,
    this.suffixIcon,
    this.hintColor,
    this.node,
    this.labelColor,
    this.controller,
    this.onFieldSubmitted,
    this.textAlign,
    this.characterLimit,
    this.readOnly = false,
    TextInputType? textInputType,
  }) {
    if (textInputType == null) {
      _textInputType = TextInputType.text;
    } else {
      _textInputType = textInputType;
    }
  }

  @override
  _InputTextFormfieldState createState() => _InputTextFormfieldState();
}

class _InputTextFormfieldState extends State<InputTextFormfield> {
  var arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  var enNumbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
  var form;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.mainValue != null && widget.mainValue != "") {
      widget.controller?.text = widget.mainValue!.toString();
    }

    return TextFormField(
      readOnly: widget.readOnly,
      style: widget.style,
      onTap: widget.onTap,
      focusNode: widget.node,
      textInputAction: TextInputAction.next,
      enabled: widget.enabled,
      onFieldSubmitted: widget.onFieldSubmitted,
      keyboardType: widget._textInputType,
      controller: widget.controller,
      maxLength: widget.maxLetterLength,
      maxLines: widget.maxLines ?? 1,
      autovalidateMode: widget.autoValidateMode,
      textAlign: widget.textAlign ?? TextAlign.start,
      decoration: widget.decoration,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(widget.characterLimit),
      ],
      onSaved: widget.saved,
      validator: widget.validate,
      onChanged: (value) {
        if (widget.controller != null) {
          if (widget._textInputType == TextInputType.number  || widget._textInputType == TextInputType.phone) {
            // check of input is number not string
            if (value.isNotEmpty) {
              if (value.contains(RegExp(r'[a-zA-Z]'))) {
                widget.controller!.text = widget.controller!.text
                    .substring(0, widget.controller!.text.length - 1);
                widget.controller!.selection = TextSelection.fromPosition(
                    TextPosition(offset: widget.controller!.text.length));
              }
            }
          }
        }
        if (widget.onChange != null) {
          widget.onChange!(value);
        }
      },
      obscureText: widget.isPressed == null ? false : widget.isPressed!,
    );
  }
}
