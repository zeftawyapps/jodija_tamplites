import 'package:JoDija_tamplites/util/view_data_model/base_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// ويدجت تعرض قائمة من البيانات (ListView) مع دعم الحركات (Animations) وزر للإضافة.
/// A widget that displays a ListView of data with animation support and an optional add button.
class ListViewModel<T extends BaseViewDataModel> extends StatefulWidget {
  ListViewModel({
    super.key,
    /// البيانات.
    /// The data.
    required this.data,
    /// دالة بناء العنصر.
    /// Item builder.
    required this.listItem,
    /// إمكانية الإضافة.
    /// Can add item.
    this.canAdd = false,
    /// اتجاه التمرير.
    /// Scroll direction.
    this.scrollDirection = Axis.vertical,
    /// دالة الإضافة.
    /// On add callback.
    this.onAdd,
    /// ويدجت الإضافة المخصص.
    /// Custom add widget.
    this.addWidget,
  });
  /// قائمة البيانات التي سيتم عرضها.
  /// The list of data to be displayed.
  final List<T> data;
  
  /// هل يظهر زر الإضافة في نهاية القائمة.
  /// Whether an add button should appear at the end of the list.
  final bool canAdd;
  
  /// الويدجت المخصص لزر الإضافة (اختياري).
  /// The custom widget for the add button (optional).
  final Widget? addWidget;
  
  /// اتجاه التمرير للقائمة (عمودي أو أفقي).
  /// The scroll direction of the list (vertical or horizontal).
  final Axis scrollDirection;
  
  /// دالة تُستدعى عند الضغط على زر الإضافة.
  /// Callback triggered when the add button is pressed.
  final void Function()? onAdd;
  
  /// دالة بناء عنصر القائمة بناءً على الفهرس والبيانات.
  /// A builder function for each list item based on index and data.
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
