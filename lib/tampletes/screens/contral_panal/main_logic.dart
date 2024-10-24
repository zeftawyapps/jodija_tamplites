import 'dart:async';

import 'package:JoDija_view/util/main-screen/screen-type.dart';
import 'package:JoDija_view/util/widgits/screen_provider/screen_notfier.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
  import 'package:provider/provider.dart';

import 'contents/content_interface.dart';
import 'side_bar_tools/sid_bar_interface.dart';


class DashboardMainServices extends ScreenStateNotifier {
// single ton object
  static DashboardMainServices? _instance;
  DashboardMainServices._();
   DashboardMainServices() {

  }
  List<IContent> contents = [];
List<ISideBare> sideBar = [];
   int selectedIndex = 0;
  int hoverIndex = 0;
   List<Widget> getSideBar() {
    List<Widget> list = [];
    // for with i loop
     for (var i = 0; i < sideBar.length; i++) {
       sideBar[i].index   = i;
      list.add(sideBar[i].build(context)

      );

    }
    return list;
  }
  List<Widget> getContents() {
    List<Widget> list = [];
    // check if the contents length is  equal to  side bar length
    if (contents.length != sideBar.length) {
      throw Exception('contents length must be equal to side bar length');
    }
    // for with i loop
    for (var i = 0; i < contents.length; i++) {
      list.add(contents[i].build(context));
    }
    return list;
  }

  Widget getContent() {
    return contents[selectedIndex].build(context);
  }

  // on side bar item click
  void onSideBarClick(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  // on side bar item hover
  void onSideBarHover(int index) {
    hoverIndex = index;
    notifyListeners();
  }
  // on side bar item exit
  void onSideBarExit(int index) {
    hoverIndex = -1;
    notifyListeners();
  }

  @override
  void createproviers(BuildContext contxt) {
    context = contxt;
  }

  String getTittle() {
    return sideBar[selectedIndex].title;
  }
}
