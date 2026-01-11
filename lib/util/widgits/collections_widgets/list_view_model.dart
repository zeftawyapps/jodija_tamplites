import 'package:JoDija_tamplites/util/view_data_model/base_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListViewModel<T extends BaseViewDataModel> extends StatefulWidget {
  ListViewModel(
      {super.key,
      required this.data,
      required this.listItem,
      this.canAdd = false,
      this.scrollDirection = Axis.vertical,
      this.onAdd,
      this.addWidget = null});
  
  final List<T> data;
  final bool canAdd;
  final Widget? addWidget;
  final Axis scrollDirection;
  final void Function()? onAdd;
  final Widget Function(int i, T data) listItem;

  @override
  State<ListViewModel<T>> createState() => _ListViewModelState<T>();
}

class _ListViewModelState<T extends BaseViewDataModel> extends State<ListViewModel<T>> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    final itemCount = widget.canAdd ? widget.data.length + 1 : widget.data.length;
    _controllers = List.generate(
      itemCount,
      (index) => AnimationController(
        duration: Duration(milliseconds: 400),
        vsync: this,
      )..forward(),
    );
  }

  @override
  void didUpdateWidget(ListViewModel<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data.length != widget.data.length) {
      _disposeControllers();
      _initControllers();
    }
  }

  void _disposeControllers() {
    for (var controller in _controllers) {
      controller.dispose();
    }
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: widget.scrollDirection,
      itemCount: widget.canAdd ? widget.data.length + 1 : widget.data.length,
      itemBuilder: (context, index) {
        if (index >= _controllers.length) {
          return SizedBox.shrink();
        }

        final animation = CurvedAnimation(
          parent: _controllers[index],
          curve: Curves.easeOutCubic,
        );

        if (widget.canAdd && index == widget.data.length) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: widget.scrollDirection == Axis.vertical 
                  ? const Offset(0, 0.5)
                  : const Offset(0.5, 0),
              end: Offset.zero,
            ).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: widget.onAdd,
                  child: widget.addWidget ??
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
              ),
            ),
          );
        }

        return SlideTransition(
          position: Tween<Offset>(
            begin: widget.scrollDirection == Axis.vertical 
                ? const Offset(0, 0.5)
                : const Offset(0.5, 0),
            end: Offset.zero,
          ).animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: widget.listItem(index, widget.data[index]),
          ),
        );
      },
    );
  }
}
