 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../view_data_model/base_data_model.dart';
  class GroupedMapWidget<parent , child > extends StatelessWidget {
  final List<BaseViewDataModel> data;
  ScrollPhysics physics;
 parent Function (  Map<String, dynamic >  data)  parentData;
  child Function ( Map<String , dynamic > data)  childData;
  Widget Function (parent pdata  )  parentWidget;
  Widget Function (child cdata  )  childWidget;
  SliverGridDelegate gridDelegate;
  String chidlKey;
  MainAxisAlignment mainAxisAlignment;
  CrossAxisAlignment crossAxisAlignment;
  TextDirection? textDirection;


    GroupedMapWidget({Key? key, required this.data
    ,required this.parentData
    ,required this.childData
    ,required this.chidlKey
,required this.parentWidget ,
 required this.childWidget ,
 required this.gridDelegate ,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.textDirection,



      this.physics = const NeverScrollableScrollPhysics()
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    parent pdata  ;
    child cdata ;
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final groupData = data[index].map as Map<String, dynamic>;
        pdata = parentData(groupData);
        final groupName = groupData['name'];
        final items = groupData['${chidlKey}']??[] as List<dynamic>;
        return Column(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          textDirection: textDirection,
          children: [
            // Group title

            parentWidget(pdata),
            // Grid view for items
            GridView.builder(

              shrinkWrap: true, // Wrap content vertically
              physics: NeverScrollableScrollPhysics(), // Disable grid scrolling
              gridDelegate: gridDelegate ,
              itemCount: items.length,
              itemBuilder: (context, index) {
                cdata = childData(items[index]);
                return childWidget(cdata);
              },
            ),
          ],
        );
      },
    );
  }
}
