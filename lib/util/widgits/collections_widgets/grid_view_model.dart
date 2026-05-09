import 'package:JoDija_tamplites/util/view_data_model/base_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// ويدجت تعرض البيانات في شبكة (GridView) مع دعم الحركات وزر للإضافة.
/// A widget that displays data in a GridView with animation support and an optional add button.
class GridViewModel<T extends BaseViewDataModel> extends StatefulWidget {
  GridViewModel({
    super.key,
    /// البيانات.
    /// The data.
    required this.data,
    /// بناء العنصر.
    /// Item builder.
    required this.listItem,
    /// إمكانية الإضافة.
    /// Can add item.
    this.canAdd = false,
    /// ويدجت الإضافة.
    /// Custom add widget.
    this.addWidget,
    /// إعدادات الشبكة.
    /// Grid delegate.
    this.gridDelegate,
    /// دالة الإضافة.
    /// On add callback.
    this.onAdd,
    /// متحكم التمرير.
    /// Scroll controller.
    this.scrollController,
    /// فيزياء التمرير.
    /// Scroll physics.
    this.physics,
    /// هل الشبكة تلتف حول محتواها.
    /// Shrink wrap the grid.
    this.shrinkWrap = false,
  });
  /// متحكم التمرير للشبكة.
  /// The scroll controller for the grid.
  final ScrollController? scrollController;
  
  /// قائمة البيانات.
  /// The list of data to be displayed.
  final List<T> data;
  
  /// هل يمكن إضافة عنصر جديد.
  /// Whether a new item can be added.
  final bool canAdd;
  
  /// هل الشبكة تلتف حول محتواها.
  /// Whether the grid should shrink wrap its content.
  final bool shrinkWrap;
  
  /// فيزياء التمرير.
  /// The scroll physics.
  final ScrollPhysics? physics;
  
  /// إعدادات تقسيم الشبكة (عدد الأعمدة، المسافات، إلخ).
  /// The grid delegate for configuring the layout (columns, spacing, etc).
  final SliverGridDelegateWithFixedCrossAxisCount? gridDelegate;
  
  /// ويدجت زر الإضافة المخصص.
  /// The custom add button widget.
  final Widget? addWidget;
  
  /// دالة استدعاء عند الضغط على زر الإضافة.
  /// Callback triggered when the add button is pressed.
  final void Function()? onAdd;
  
  /// دالة بناء عناصر الشبكة بناءً على الفهرس والبيانات.
  /// A builder function for each grid item based on index and data.
  final Widget Function(int i, T data) listItem;

  @override
  State<GridViewModel<T>> createState() => _GridViewModelState<T>();
}

class _GridViewModelState<T extends BaseViewDataModel> extends State<GridViewModel<T>> with TickerProviderStateMixin {
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
  void didUpdateWidget(GridViewModel<T> oldWidget) {
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
    bool isSmall = MediaQuery.of(context).size.width < 600;

    return GridView.builder(
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics ?? AlwaysScrollableScrollPhysics(),
      controller: widget.scrollController ?? ScrollController(),
      gridDelegate: widget.gridDelegate ??
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isSmall ? 2 : 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
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
              begin: const Offset(0, 0.5),
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
            begin: const Offset(0, 0.5),
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
