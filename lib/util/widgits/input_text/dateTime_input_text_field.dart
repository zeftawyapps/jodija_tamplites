import 'package:JoDija_view/util/functions/date_time.dart';
 import 'package:flutter/material.dart';

import 'input_text_field.dart';

class DatePickerFormField extends StatefulWidget {
  DatePickerFormField(
      {Key? key,
      required this.decoration,
      this.initDate,
      this.lastDate,
      this.firestDate,
      this.entryMode = DatePickerEntryMode.calendar,
      this.initialDatePickerMode = DatePickerMode.day,
      required this.textStyle,
      required this.hintText,
      required this.onSave,
        this.formate = 'yyyy-MM-dd',
        this.onChange ,
      required this.onvlaidate})
      : super(key: key);
  DatePickerEntryMode entryMode = DatePickerEntryMode.calendar;
  InputDecoration decoration;
  DateTime? initDate, firestDate, lastDate;
  String? hintText;
  TextStyle textStyle;
  DatePickerMode initialDatePickerMode;
  var onvlaidate, onSave , onChange;
  String formate = 'yyyy-MM-dd';
  @override
  State<DatePickerFormField> createState() =>
      _DatePickerFormFieldState();
}

class _DatePickerFormFieldState
    extends State<DatePickerFormField> {
  DateTime? value = null;
  TextEditingController controller = TextEditingController();


  DateTime init = DateTime.now();
  DateTime first = DateTime.now();
  DateTime last = DateTime.now().add(Duration(days: 1));
  DateTime? dateSelected ;
@override
  void initState() {
    // TODO: implement initState


  super.initState();
  }


  @override
  Widget build(BuildContext context) {
value = dateSelected ??  widget.initDate;

init = widget.initDate ?? DateTime.now();
first = widget.firestDate ?? DateTime.now();
last = widget.lastDate ?? first.add(Duration(days: 1));

    return InputTextFormfield(
      addTools: true,
        style: widget.textStyle,
        readOnly: true,
        controller: controller,
        onChange: widget.onChange,
        onTap: () {
          showDatePicker(
                   context: context,
                  initialDate: init,
                  firstDate: first,
                  lastDate: last,
                  initialEntryMode: widget.entryMode,
                  initialDatePickerMode: widget.initialDatePickerMode)
              .then((value) {
            setState(() {
              this.dateSelected = value;
              // this.controller.text = value!.toStringFormat(formate: widget.formate);
                widget.onChange(value);
            });
          });
        },
        decoration: widget.decoration ,
        validate: widget.onvlaidate,
        saved: widget.onSave,
        mainValue: this.value == null ? null : this.value!.toStringFormat(formate:   widget.formate));
  }
}
