import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/main_navigation_service.dart';
import 'package:JoDija_tamplites/util/app_settings/settings_inherted.dart';
import 'package:JoDija_tamplites/util/main-screen/screen-type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

 import 'interface/sid_bar_interface.dart';

class SideListItme extends StatelessWidget with IRoutedSideBare {
  SideListItme({
    super.key,
    required this.title,
    required this.pageRouteName,
    this.clickColor,
    this.color,
    this.textColor = Colors.white,
    this.textColoronclick = Colors.black,
    this.textColoronHover = Colors.white,
    this.hoverColor,
    this.fontSize = 5,
  });
  String title;
  String pageRouteName;
  int fontSize = 6;
  Color? color = Colors.green;
  Color? textColor = Colors.black;
  Color? textColoronclick = Colors.black;
  Color? textColoronHover = Colors.black;

  Color? hoverColor = Color(0xffF5F5F5);
  Color? clickColor = Color(0xff3e1ab5);
  int index = 0;

  bool isHover = false;
  bool isClick = false;
  bool isActioned = false;
  RoutedContralPanalServices? mainLogic;

  @override
  Widget build(BuildContext context) {
    ScreenType screenType = SettingChangeLestner.of(context).state.screenType!;

    int ScreenfontSize = 0;
    if (screenType == ScreenType.mobile) {
      ScreenfontSize = 10;
    } else {
      ScreenfontSize = fontSize;
    }

    loadLogic(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (e) {
        onHover(index);
      },
      onExit: (e) {
        onExit(index);
      },
      child: GestureDetector(
        onTap: () {
          onClick(index);
        },
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: colorsOpartion(),
                    boxShadow: [
                      BoxShadow(
                          color: isHover
                              ? Colors.black.withOpacity(0.2)
                              : Colors.transparent,
                          blurRadius: isHover ? 0 : 3,
                          offset: Offset(0, 5))
                    ],
                    borderRadius: BorderRadius.circular(2)),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(title,
                            style: TextStyle(
                                fontSize: ScreenfontSize.toDouble(),
                                color: textcholor())),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: textcholor(),
                      )
                    ],
                  ),
                )))),
      ),
    );
  }

  Color textcholor() {
    if (isClick) {
      return textColoronclick!;
    } else if (isHover) {
      return textColoronHover!;
    } else {
      return textColor!;
    }
  }

  @override
  int selectedIndex = 0;
  int hoverIndex = 0;

  @override
  void onClick(int index) {
    mainLogic!.onSideBarClick(index);
  }

  @override
  void onExit(int index) {
    mainLogic!.onSideBarExit(index);
  }

  @override
  void onHover(int index) {
    mainLogic!.onSideBarHover(index);
  }

  @override
  String path() {
    return pageRouteName;
  }
}
