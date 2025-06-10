import 'package:JoDija_tamplites/theams/colors/colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_logic.dart';
import 'side_bar.dart';

class MobCp extends StatefulWidget {
  const MobCp({super.key});

  @override
  State<MobCp> createState() => _MobCpState();
}

class _MobCpState extends State<MobCp> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DashboardMainServices>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            provider.getTittle(),
            style: TextStyle(color: provider.titleTextColor),
          ),
          backgroundColor: provider.headerColor,
        ),
        drawer: Drawer(
          width: 150,
          child: SideBar(),
        ),
        body: FadeIn(
          child: Container(
            // reach text using q['name']
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage(
            //       provider.logo,
            //     ),
            //     fit: BoxFit.fill,
            //   ),
            // ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: provider.getContent(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
