import 'package:JoDija_tamplites/util/main-screen/screen-type.dart';
import 'package:flutter/material.dart';

/// باني الشاشات التكيفي المتجاوب (Responsive Project Screen Builder)
///
/// ودجة تقوم بحساب أبعاد الشاشة الحالية وتصنيفها إلى [ScreenType]
/// وتمرير الأبعاد والنوع مباشرة إلى دالة البناء `screenBulder`.
///
/// English Description:
/// Adaptive builder widget computing current screen breakpoints, viewport dimensions,
/// and [ScreenType] classification, providing them to a responsive builder callback.
class ProjectScreenBulder extends StatefulWidget {
  ProjectScreenBulder({super.key, required this.screenBulder});

  /// دالة بناء الودجة التكيفية مع الأبعاد
  final Widget Function(
    BuildContext context,
    ScreenType screenType,
    double width,
    double hight,
  ) screenBulder;

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
        MediaQuery.of(context).size.height,
      ),
    );
  }
}
