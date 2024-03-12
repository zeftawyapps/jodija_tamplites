import 'package:flutter/material.dart';

import 'input_text_field.dart';

class DatePickerFormFieldValidation extends StatefulWidget {
    DatePickerFormFieldValidation({Key? key , required this.decoration ,
    this.initDate , this.lastDate , this  .firestDate ,

      required this.textStyle,
     required   this.hintText , required this.onSave , required this.onvlaidate
    }) : super(key: key);
    InputDecoration decoration ;
    DateTime? initDate , firestDate , lastDate ;
    String hintText ;
    TextStyle textStyle ;
    var onvlaidate , onSave ;
  @override
  State<DatePickerFormFieldValidation> createState() => _DatePickerFormFieldValidationState();
}

class _DatePickerFormFieldValidationState extends State<DatePickerFormFieldValidation> {
 DateTime? value = null ;
 TextEditingController controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    DateTime init = widget .  initDate??DateTime.now() ;
    DateTime first = widget .  firestDate??DateTime.now() ;
    DateTime last = widget .  lastDate ?? first.add(Duration(days: 1)) ;

    return InputTextFormfield(
     style: widget .  textStyle,
      readOnly: true,
      controller: controller ,
      onTap: (){
        showDatePicker(context: context, initialDate: init, firstDate: first, lastDate: last )
            .then((value)   {

          setState(() {
            this.value = value ;
          });
        });
      },
      decoration: widget .  decoration.copyWith(labelText: widget .  hintText),
        validate: widget.onvlaidate ,
        saved  :widget.onSave   ,mainValue: this.value == null ? null : this.value.toString()
    );
  }
}
