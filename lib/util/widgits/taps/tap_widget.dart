import 'package:flutter/material.dart';

import 'tap_item_interface.dart';

class TapWidget extends StatefulWidget {
  TapWidget(
      {super.key,
      required this.taps,
      this.tapController  ,
      required this.children,
      this.decoration = const BoxDecoration(
        color: Colors.white,),
      this.height = 50,
      });
  List<ITapItems> taps;
  TabController? tapController;
  List<Widget> children = [];
  BoxDecoration  decoration;
  int height = 50;

  @override
  State<TapWidget> createState() => _TapWidgetState();
}

class _TapWidgetState extends State<TapWidget>
    with SingleTickerProviderStateMixin {
  ValueNotifier<int> tabControllerNotifier = ValueNotifier(0);
late   TabController controller ;
  @override
  void initState() {
    super.initState();
    if (widget.tapController == null) {
       controller  =
          TabController(length: widget.taps.length, vsync: this);
    }else {
      controller = widget.tapController!;
    }
    controller.addListener(() {
        tabControllerNotifier.value = controller.index;
        FocusManager.instance.primaryFocus?.unfocus();
      });
  }
 @override
  void dispose() {
   controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.height.toDouble(),
          decoration: widget.decoration,
          child: TabBar(
            controller: controller,
            tabs: widget.taps
                .map((e) => Tab(
                      child: e.child,
                    ))
                .toList(),
          ),
        ),
        Expanded(

          child: TabBarView(
            controller: controller,
            children: widget.children,
          ),
        ),
      ],
    );
  }
}
