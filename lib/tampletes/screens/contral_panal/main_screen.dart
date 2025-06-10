import 'package:JoDija_tamplites/tampletes/screens/contral_panal/contents/content_interface.dart';
import 'package:JoDija_tamplites/tampletes/screens/contral_panal/side_bar_tools/sid_bar_interface.dart';
import 'package:JoDija_tamplites/util/main-screen/project-screen.dart';
import 'package:JoDija_tamplites/util/main-screen/screen-type.dart';
import 'package:JoDija_tamplites/util/widgits/screen_provider/screen_viewer.dart';
import 'package:flutter/material.dart';
import 'main_logic.dart';
import 'moblie_cp.dart';
import 'web_cp.dart';

class DashboardMainScreen extends StatefulWidget {
  DashboardMainScreen(
      {super.key, required this.sideBar, required this.contents});

  List<ISideBare> sideBar = [];
  List<IContent> contents = [];
  @override
  State<DashboardMainScreen> createState() => _DashboardMainScreenState();
}

class _DashboardMainScreenState extends State<DashboardMainScreen> {
  DashboardMainServices logic = DashboardMainServices();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.sideBar = [];

    logic.contents = [];
  }

  @override
  Widget build(BuildContext context) {
    return ScreenViews<DashboardMainServices>(
      builder: (context, q, child) {
        return ProjectScreenBulder(screenBulder: (c, s, w, h) {
          if (s == ScreenType.mobile) {
            return MobCp();
          }
          return WebCp();
        });
      },
      notifier: logic,
    );
  }
}
