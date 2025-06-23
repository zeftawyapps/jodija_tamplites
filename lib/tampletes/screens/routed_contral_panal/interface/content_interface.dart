import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/interface/sid_bar_interface.dart';
import 'package:flutter/material.dart';


mixin   IRoutedContent {
  IRoutedSideBare? sideBar ;
  int index = 0;


  Widget build(BuildContext context);
}