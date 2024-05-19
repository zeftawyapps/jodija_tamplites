import 'package:flutter/material.dart';



class DropDownInputTextField extends StatefulWidget {
  DropDownInputTextField(
      {Key? key,
      required this.itemslsit,
        this.val,

      this.onsaved,
      this.validation,
        this.icon,
        this.textStyle ,
      required this.hintText,
      this.useicon = true,
        this.onChange ,
      this.textFieldColor  , required this.decoration})
      : super(key: key);
InputDecoration decoration ;
 var onChange ;
  bool useicon = true;
  List<String> itemslsit;
  String? val;

  String hintText;
TextStyle? textStyle ;
  var onsaved;

  Icon? icon;
  var validation;
  Color? textFieldColor;
  @override
  _DropDownInputTextFieldState createState() => _DropDownInputTextFieldState();
}

class _DropDownInputTextFieldState extends State<DropDownInputTextField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: widget.itemslsit.map((String category) {
        return DropdownMenuItem(
            value: category,
            child: Text(
              category,
              style:
                   widget.textStyle != null ? widget.textStyle : TextStyle(fontSize: 20 , color: Colors.black)
            ));
      }).toList(),
      onChanged: (v){

        setState(() {
          widget.val = v;
          widget.onChange(v);

        });
      },
      value: widget.val != null ? widget.val : widget.itemslsit[0],
      onSaved: widget.onsaved,
      validator: widget.validation,
      style: widget.textStyle != null ? widget.textStyle  :  TextStyle(fontSize: 20 , color: Colors.black),
      decoration: widget.decoration.copyWith(labelText: widget.hintText ) ,
    );
  }
}
