
import 'package:flutter/material.dart';
class pubMenuItems  {
  final String title;
  final IconData icon;
  final Function onTap;
  int value;
  bool isEnable = true;
  bool isvisale = true;
  pubMenuItems({required this.title, required this.icon, required this.onTap , required this.value
  ,this.isEnable = true , this.isvisale = true
  });

}