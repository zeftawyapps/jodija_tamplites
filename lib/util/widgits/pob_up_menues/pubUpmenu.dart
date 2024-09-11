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
  Map<int, Function> map = {};
  @override
  Widget build(BuildContext context) {
map = actions();
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
            map[value]!();
          }),
     );
  }

  Map<int, Function> actions() {
    Map<int, Function> maps =  items.asMap().map((key, value) => MapEntry(value.value, value.onTap));
    return maps as Map<int, Function>;
  }
}
