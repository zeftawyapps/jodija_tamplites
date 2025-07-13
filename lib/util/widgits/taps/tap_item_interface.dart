import 'package:flutter/material.dart';

abstract   class ITapItems {
 int index;
 TabController? tapController;
 Widget child ;
 // constrctor
  ITapItems({required this.index, required this.tapController, required this.child});
    // method
  Widget build(BuildContext context);


}