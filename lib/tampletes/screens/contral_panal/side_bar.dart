import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'main_logic.dart';
import 'package:provider/provider.dart';

import 'side_bar_tools/side_bar_widget.dart';

class SideBar extends StatelessWidget {
  SideBar({super.key});

  DashboardMainServices logic = DashboardMainServices();

  @override
  Widget build(BuildContext context) {
    logic = Provider.of<DashboardMainServices>(context);

    return Container(
      width: 200,
      color: logic.sideBarColor,
      child: Column(
        children: [
          logic.logo == "null"
              ? Container()
              : Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(logic.logo), fit: BoxFit.fill)),
                ),
          ...logic.getSideBar()
        ],
      ),
    );
  }
}
