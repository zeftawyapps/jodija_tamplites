import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../view_data_model/base_data_model.dart';
 class GroupedMapListWidget<parent , child > extends StatelessWidget {
  final List<BaseViewDataModel> data;
  ScrollPhysics physics;
 parent Function (  Map<String, dynamic >  data)  parentData;
  child Function ( Map<String , dynamic > data)  childData;
  Widget Function (parent pdata  )  parentWidget;
  Widget Function (child cdata  )  childWidget;

  String chidlKey;
  GroupedMapListWidget({Key? key, required this.data
    ,required this.parentData
    ,required this.childData
    ,required this.chidlKey
,required this.parentWidget ,
 required this.childWidget ,
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
          children: [
            // Group title

            parentWidget(pdata),
            // Grid view for items
            ListView.builder(

              shrinkWrap: true, // Wrap content vertically
              physics: NeverScrollableScrollPhysics(), // Disable grid scrolling

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
