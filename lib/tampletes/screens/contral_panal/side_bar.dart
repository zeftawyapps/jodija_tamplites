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
    logic =  Provider.of<DashboardMainServices>(context);



    return Container(
      width: 200  ,
      color: Theme.of(context).drawerTheme.backgroundColor,
      child: Column(
        children: [
          Container(
              height: 200 ,
              width: 200 ,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage( ""),
                fit: BoxFit.fill
              )
            ),



          ),
          ...logic.getSideBar()
        ],
      ),
    );
  }
}
