import 'package:flutter/material.dart';

abstract class DarkColors {
  Color primary() ;
  Color secondary() ;
  Color accent() ;
  Color background() ;
  Color surface() ;
  Color error() ;
  // fonts text color
  Color TitleText() ;
  Color SubTitleText() ;
  Color BodyText() ;
  Color CaptionText() ;
  Color ButtonText() ;
  // controls and widgets
  Color ButtonColor() ;
  List<Colors> ButtonGradintsColor() ;
  Color IconColor() ;
  Color DividerColor() ;
  List<Colors> ScaffoldBackgroundColor() ;
  List<Colors> AppBarBackgroundColor() ;
// other colors


}