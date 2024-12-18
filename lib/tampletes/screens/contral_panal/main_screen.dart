import 'package:JoDija_view/util/main-screen/project-screen.dart';
import 'package:JoDija_view/util/main-screen/screen-type.dart';
import 'package:JoDija_view/util/widgits/screen_provider/screen_viewer.dart';
import 'package:flutter/material.dart';
 import 'main_logic.dart';
 import 'moblie_cp.dart';
import 'web_cp.dart';

class DashboardMainScreen extends StatefulWidget {
  const DashboardMainScreen({super.key});

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
