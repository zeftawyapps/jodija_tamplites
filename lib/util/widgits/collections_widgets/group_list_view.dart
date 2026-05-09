import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../view_data_model/base_data_model.dart';
/// ويدجت لعرض بيانات مجمعة (Grouped Data) بحيث يكون هناك عنوان للمجموعة (Parent) وأسفلها قائمة من العناصر (Children List).
/// A widget for displaying grouped data where each group has a parent header and a list of children below it.
class GroupedMapListWidget<parent , child > extends StatelessWidget {
  /// قائمة البيانات الأساسية المجمعة.
  /// The main list of grouped data.
  final List<BaseViewDataModel> data;
  
  /// فيزياء التمرير.
  /// Scroll physics.
  ScrollPhysics physics;
  
  /// دالة لاستخراج بيانات المجموعة (Parent) من الخريطة.
  /// Callback to extract parent data from the map.
  parent Function (  Map<String, dynamic >  data)  parentData;
  
  /// دالة لاستخراج بيانات العنصر الفرعي (Child) من الخريطة.
  /// Callback to extract child data from the map.
  child Function ( Map<String , dynamic > data)  childData;
  
  /// دالة بناء الواجهة لعنوان المجموعة (Parent Widget).
  /// Builder for the parent widget.
  Widget Function (parent pdata  )  parentWidget;
  
  /// دالة بناء الواجهة للعنصر الفرعي (Child Widget).
  /// Builder for the child widget.
  Widget Function (child cdata  )  childWidget;

  /// المفتاح المستخدم للوصول إلى قائمة العناصر الفرعية داخل خريطة المجموعة.
  /// The key used to access the children list inside the group map.
  String chidlKey;
  GroupedMapListWidget({Key? key,
    /// البيانات.
    /// The data.
    required this.data,
    /// بيانات الأب.
    /// Parent data extractor.
    required this.parentData,
    /// بيانات الابن.
    /// Child data extractor.
    required this.childData,
    /// مفتاح الأبناء.
    /// Children key.
    required this.chidlKey,
    /// واجهة الأب.
    /// Parent widget builder.
    required this.parentWidget,
    /// واجهة الابن.
    /// Child widget builder.
    required this.childWidget,
    /// فيزياء التمرير.
    /// Scroll physics.
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
