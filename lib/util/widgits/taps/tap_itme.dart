import 'package:JoDija_view/util/widgits/taps/tap_item_interface.dart';
import 'package:flutter/material.dart';
 class TapItem extends StatelessWidget  implements ITapItems {
  TapItem({super.key
  , required this.index,
    this.tapController ,
      required this .child ,
  });

  @override
  Widget build(BuildContext context) {
    return  child ;
  }

  @override
  int index;

  @override
  TabController? tapController;

  @override
  Widget child;
}
