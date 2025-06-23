import 'package:flutter/material.dart';

import '../side_bar_tools/sid_bar_interface.dart';

mixin   IContent {
  ISideBare? sideBar ;
  int index = 0;


  Widget build(BuildContext context);
}