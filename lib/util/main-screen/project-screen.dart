import 'package:JoDija_tamplites/util/main-screen/screen-type.dart';
import 'package:flutter/material.dart';

class ProjectScreenBulder extends StatefulWidget {
  ProjectScreenBulder({super.key, required this.screenBulder});
// create funciotn builder widget type and has context as pram
  Widget Function(BuildContext context, ScreenType screenType, double width,
      double hight) screenBulder;
  @override
  State<ProjectScreenBulder> createState() => _ProjectScreenBulderState();
}

class _ProjectScreenBulderState extends State<ProjectScreenBulder> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: widget.screenBulder(
            context,
            ScreenTypeExtension.fromMediaQueryData(MediaQuery.of(context)),
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height));
  }
}
