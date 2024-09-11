import 'package:JoDija_view/util/main-screen/screen-type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'items.dart';

class PopUpMenu extends StatelessWidget {
  PopUpMenu(
      {super.key,
      required this.items,
      this.textStyle = const TextStyle(fontSize: 10),
      this.iconSize,
      this.iconColor ,
      this.alignment = Alignment.topRight
      });
  List<pubMenuItems> items;
  TextStyle? textStyle = TextStyle(fontSize: 10 , color: Colors.black);
  int? iconSize ;
  Color? iconColor ;
  Alignment alignment = Alignment.topRight;

  @override
  Widget build(BuildContext context) {

    if (iconSize == null) {
      iconSize = textStyle!.fontSize!.toInt();
    }
    if (iconColor == null) {
      iconColor = textStyle!.color??Colors.black;
    }
     return Align(
        alignment: alignment,
       child: PopupMenuButton(
         iconColor: iconColor,

          iconSize:  iconSize!.toDouble() ,
          itemBuilder: (context) {
            return items
                .map((e) => PopupMenuItem(
                      value: e.value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(e.icon,
                              color: iconColor, size: iconSize!.toDouble()),

                          Text(e.title, style: textStyle!),
                        ],
                      ),
                    ))
                .toList();
          },
          onSelected: (value) {
            actions()[value]!();
          }),
     );
  }

  Map<int, Function> actions() {
    var maps = items.map((e) => {e.value: e.onTap});
    return maps as Map<int, Function>;
  }
}
