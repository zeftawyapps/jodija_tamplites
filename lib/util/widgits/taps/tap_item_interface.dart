import 'package:flutter/material.dart%20';

abstract   class ITapItems {
 int index;
 TabController? tapController;
 Widget child ;
 // constrctor
  ITapItems({required this.index, required this.tapController, required this.child});
    // method
  Widget build(BuildContext context);


}