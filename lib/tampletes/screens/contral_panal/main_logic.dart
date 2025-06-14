import 'dart:async';

import 'package:JoDija_tamplites/util/main-screen/screen-type.dart';
import 'package:JoDija_tamplites/util/navigations/web_router.dart';
import 'package:JoDija_tamplites/util/widgits/screen_provider/screen_notfier.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../../theams/assets/iamges.dart';
import 'contents/content_interface.dart';
import 'side_bar_tools/sid_bar_interface.dart';

class DashboardMainServices extends ScreenStateNotifier {
// single ton object

  static DashboardMainServices? _instance;

  DashboardMainServices._();
  DashboardMainServices(
      {String tittle = "JoDija",
      String logo = "null",
      String backgroundImage = "null",
      Color? backGroundColor,
      Color? sideBarColor,
      Color? sideBarHoverColor,
      Color? headerColor,
      Color? titleTextColor}) {
    _tittle = tittle;
    _logo = logo;
    _backgroundImage = backgroundImage;
    _backGroundColor = backGroundColor ?? Colors.white;
    _sideBarColor = sideBarColor ?? Colors.grey;
    _sideBarHoverColor = sideBarHoverColor ?? Colors.blueGrey;
    _headerColor = headerColor ?? Colors.black;
    _titleTextColor = titleTextColor ?? Colors.black;
  }

  String _tittle = 'Default Title';
  String _logo = 'Default Logo';
  String _backgroundImage = 'Default Background Image';
  Color _backGroundColor = Colors.white;
  Color _sideBarColor = Colors.grey;
  Color _sideBarHoverColor = Colors.blueGrey;
  Color _headerColor = Colors.black;
  Color _titleTextColor = Colors.black;

  // GETTER
  String get tittle => _tittle;
  String get logo => _logo;
  String get backgroundImage => _backgroundImage;
  Color get backGroundColor => _backGroundColor;
  Color get sideBarColor => _sideBarColor;
  Color get sideBarHoverColor => _sideBarHoverColor;
  Color get headerColor => _headerColor;
  Color get titleTextColor => _titleTextColor;

  // SETTER in one function
  void setTheme({
    String tittle = 'Default Title',
    String logo = "assets/images/logo.png",
    String backgroundImage = "assets/images/background.jpg",
    Color? backGroundColor,
    Color? sideBarColor,
    Color? sideBarHoverColor,
    Color? headerColor,
    Color? titleTextColor,
  }) {
    _tittle = tittle;
    _logo = logo;
    _backgroundImage = backgroundImage;
    _backGroundColor = backGroundColor ??
        Theme.of(context).scaffoldBackgroundColor ??
        Colors.white;
    _sideBarColor = sideBarColor ??
        Theme.of(context).drawerTheme.backgroundColor ??
        Colors.grey;
    _sideBarHoverColor = sideBarHoverColor ?? Colors.blueGrey;
    _headerColor = headerColor ??
        Theme.of(context).appBarTheme.backgroundColor ??
        Colors.black;
    _titleTextColor = titleTextColor ??
        Theme.of(context).appBarTheme.titleTextStyle!.color ??
        Colors.black;
    notifyListeners();
  }

  List<IContent> contents = [];
  List<ISideBare> sideBar = [];
  int selectedIndex = 0;
  String currentPath = '/';
  int hoverIndex = 0;
  List<Widget> getSideBar() {
    List<Widget> list = [];
    // for with i loop
    for (var i = 0; i < sideBar.length; i++) {
      sideBar[i].index = i;
      list.add(sideBar[i].build(context));
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
    currentPath = sideBar[index].path();
    WebRouter.updateUrl(currentPath);
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

  void initWebRouter() {
    currentPath = WebRouter.getCurrentPath(currentPath);
    WebRouter.listenToPopState((path) {
      currentPath = path;
      selectedIndex = sideBar.indexWhere((element) => element.path() == path);
      if (selectedIndex == -1) {
        selectedIndex = 0; // Default to the first item if not found
      }

      notifyListeners();
    });
  }

  String getTittle() {
    return sideBar[selectedIndex].title;
  }
}
