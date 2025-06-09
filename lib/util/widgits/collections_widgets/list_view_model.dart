import 'package:JoDija_tamplites/util/view_data_model/base_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';

class ListViewModel<T extends BaseViewDataModel> extends StatelessWidget {
  ListViewModel(
      {super.key,
      required this.data,
      required this.listItem,
      this.canAdd = false,
      this.scrollDirection = Axis.vertical,
      this.onAdd,
      this.addWidget = null});
  List<T> data;
  bool canAdd = false;
  Widget? addWidget = Container();
  Axis scrollDirection = Axis.horizontal;
  void Function()? onAdd;

  Widget Function(int i, T data) listItem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: scrollDirection,
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
