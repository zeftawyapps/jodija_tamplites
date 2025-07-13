import 'package:JoDija_tamplites/util/view_data_model/base_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GridViewModel<T extends BaseViewDataModel> extends StatelessWidget {
  GridViewModel(
      {super.key,
      required this.data,
      required this.listItem,
      this.canAdd = false,
      this.addWidget = null,
      this.gridDelegate,
      this.onAdd,
      this.scrollController,
      this.physics,
      this.shrinkWrap = false});

  ScrollController? scrollController;

  List<T> data;
  bool canAdd = false;
  bool shrinkWrap = false;
  ScrollPhysics? physics = AlwaysScrollableScrollPhysics();
  SliverGridDelegateWithFixedCrossAxisCount? gridDelegate;
  Widget? addWidget = Container();
  void Function()? onAdd;
  Widget Function(int i, T data) listItem;
  bool buttonVisible = false;
  @override
  Widget build(BuildContext context) {
    bool isSmall = MediaQuery.of(context).size.width < 600;

    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics ?? AlwaysScrollableScrollPhysics(),
      controller: scrollController ?? ScrollController(),
      gridDelegate: gridDelegate ??
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isSmall ? 2 : 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
      itemCount: canAdd ? data.length + 1 : data.length,
      itemBuilder: (context, index) {
        if (canAdd && index == data.length) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onAdd,
              child: addWidget ??
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        size: 50,
                      ),
                    ),
                  ),
            ),
          );
        }

        return listItem(index, data[index]);
      },
    );
  }
}
