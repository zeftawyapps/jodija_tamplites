import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/models/route_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/sidebar_item_widget.dart';
import '../laaunser.dart';
import '../providers/sidebar_provider.dart';
import '../providers/status_provider.dart';
import '../theam/theam.dart';

class SidebarWidget extends StatefulWidget {
  final List<dynamic> items;
  final int selectedIndex;

  const SidebarWidget({
    super.key,
    required this.items,
    required this.selectedIndex,
  });

  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  /// Track if navigation is happening
  bool _isNavigating = false;

  /// Check if a specific group is expanded by its index
  bool isGroupExpanded(int groupIndex) {
    final statusProvider = context.read<StatusProvider>();
    return statusProvider.OpenedSubMenuIndex == groupIndex;
  }

  /// Get the index of the currently opened group
  int getOpenedGroupIndex() {
    final statusProvider = context.read<StatusProvider>();
    return statusProvider.OpenedSubMenuIndex;
  }

  /// Close all groups
  void collapseAllGroups() {
    final statusProvider = context.read<StatusProvider>();
    statusProvider.setOpenedSubMenuExtesionsIndex(-1);
    print('All groups collapsed');
  }

  /// Expand a specific group by index
  void expandGroup(int groupIndex) {
    final statusProvider = context.read<StatusProvider>();
    statusProvider.setOpenedSubMenuExtesionsIndex(groupIndex);
    print('Group at index $groupIndex expanded');
  }

  /// Toggle a specific group by index
  void toggleGroup(int groupIndex) {
    final statusProvider = context.read<StatusProvider>();
    if (statusProvider.OpenedSubMenuIndex == groupIndex) {
      statusProvider.setOpenedSubMenuExtesionsIndex(-1);
      print('Group at index $groupIndex closed');
    } else {
      statusProvider.setOpenedSubMenuExtesionsIndex(groupIndex);
      print('Group at index $groupIndex opened');
    }
  }

  /// Organize items into groups (parent with children) and standalone items
  Map<String, dynamic> _organizeItems(List<dynamic> allItems) {
    final groupedItems = <String, List<dynamic>>{};
    final standaloneItems = <dynamic>[];

    for (var item in allItems) {
      if (item.isSideBarRouted == false || item.isVisableInSideBar == false) {
        continue;
      }

      if (item.isChildItem) {
        // Group by parent name
        final parentName = item.parentName ?? 'default';
        groupedItems.putIfAbsent(parentName, () => []);
        groupedItems[parentName]!.add(item);
      } else {
        // Add to standalone items
        standaloneItems.add(item);
      }
    }

    return {
      'grouped': groupedItems,
      'standalone': standaloneItems,
    };
  }

  /// Animation builder: Slide + Fade (from side based on direction)
  Widget _buildSlideAndFadeAnimation(
    Widget child,
    double value,
    SideBarNavigationTheames theme,
  ) {
    final offset = theme.getAnimationOffset(value);
    return Transform.translate(
      offset: offset,
      child: Opacity(
        opacity: value,
        child: child,
      ),
    );
  }

  /// Animation builder: Scale Up (grow from small to full size)
  Widget _buildScaleUpAnimation(
    Widget child,
    double value,
    SideBarNavigationTheames theme,
  ) {
    return Transform.scale(
      scale: value,
      alignment: Alignment.centerLeft,
      child: Opacity(
        opacity: value,
        child: child,
      ),
    );
  }

  /// Animation builder: Fade Only (no movement, just opacity)
  Widget _buildFadeOnlyAnimation(
    Widget child,
    double value,
    SideBarNavigationTheames theme,
  ) {
    return Opacity(
      opacity: value,
      child: child,
    );
  }

  /// Animation builder: Slide From Top (slide down from top)
  Widget _buildSlideFromTopAnimation(
    Widget child,
    double value,
    SideBarNavigationTheames theme,
  ) {
    final offset = Offset(0, -theme.animationSlideDistance * (1 - value));
    return Transform.translate(
      offset: offset,
      child: Opacity(
        opacity: value,
        child: child,
      ),
    );
  }

  /// Animation builder: Slide From Bottom (slide up from bottom)
  Widget _buildSlideFromBottomAnimation(
    Widget child,
    double value,
    SideBarNavigationTheames theme,
  ) {
    final offset = Offset(0, theme.animationSlideDistance * (1 - value));
    return Transform.translate(
      offset: offset,
      child: Opacity(
        opacity: value,
        child: child,
      ),
    );
  }

  /// Animation builder: Scale + Fade (grow while fading in)
  Widget _buildScaleAndFadeAnimation(
    Widget child,
    double value,
    SideBarNavigationTheames theme,
  ) {
    return Transform.scale(
      scale: Curves.easeOutBack.transform(value),
      alignment: Alignment.centerLeft,
      child: Opacity(
        opacity: value,
        child: child,
      ),
    );
  }

  /// Animation builder: Rotate + Scale (rotate while growing)
  Widget _buildRotateAndScaleAnimation(
    Widget child,
    double value,
    SideBarNavigationTheames theme,
  ) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateZ(value * 0.3)
        ..scale(value, value),
      alignment: Alignment.centerLeft,
      child: Opacity(
        opacity: value,
        child: child,
      ),
    );
  }

  /// Dispatch to appropriate animation builder based on theme animationType
  Widget _buildAnimationByType(
    Widget child,
    double value,
    SideBarNavigationTheames theme,
  ) {
    switch (theme.animationType) {
      case SidBarAnimationType.slideAndFade:
        return _buildSlideAndFadeAnimation(child, value, theme);
      case SidBarAnimationType.scaleUp:
        return _buildScaleUpAnimation(child, value, theme);
      case SidBarAnimationType.fadeOnly:
        return _buildFadeOnlyAnimation(child, value, theme);
      case SidBarAnimationType.slideFromTop:
        return _buildSlideFromTopAnimation(child, value, theme);
      case SidBarAnimationType.slideFromBottom:
        return _buildSlideFromBottomAnimation(child, value, theme);
      case SidBarAnimationType.scaleAndFade:
        return _buildScaleAndFadeAnimation(child, value, theme);
      case SidBarAnimationType.rotateAndScale:
        return _buildRotateAndScaleAnimation(child, value, theme);
    }
  }

  /// Build animation wrapper for items
  /// If app is initialized, return child without animation
  /// If app is initializing, apply selected animation type based on layoutDirection
  Widget _buildAnimatedItem(
      Widget child, int index, SideBarNavigationTheames theme) {
    // Check if app initialization is complete
    final statusProvider = context.read<StatusProvider>();
    final isAppInitialized = statusProvider.isAppInit;

    // If app is already initialized, return child without animation
    if (isAppInitialized) {
      return child;
    }

    // Otherwise, apply animation during initialization with direction awareness
    return TweenAnimationBuilder<double>(
      duration: Duration(
        milliseconds: theme.animationDuration.inMilliseconds + (index * 50),
      ),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: theme.animationCurve,
      builder: (context, value, child) {
        // Dispatch to the appropriate animation builder based on animationType
        return _buildAnimationByType(child!, value, theme);
      },
      child: child,
    );
  }

  /// Build individual sidebar item
  Widget _buildSidebarItem(
    BuildContext context,
    RouteItem item,
    int index,
    SideBarNavigationTheames theme,
    bool isSelected,
  ) {
    return _buildAnimatedItem(
      AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: SidebarItemWidget(
          icon: item.icon,
          label: item.label,
          isSelected: isSelected,
          theme: theme,
          onTap: () {
            // Set navigation flag to prevent expansion tile closing
            _isNavigating = true;

            final appShellProvider =
                Provider.of<AppShellRouterProvider>(context, listen: false);

            // 1. أغلق القائمة أولاً لو كانت مفتوحة (في حالة الموبايل مثلاً)
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }

            // 2. اذهب للرابط الجديد
            appShellProvider.handleItemTapByPath(
                context, item.path!, item.resolvedPath);

            // Reset navigation flag after a short delay
            Future.delayed(const Duration(milliseconds: 300), () {
              if (mounted) {
                _isNavigating = false;
              }
            });
          },
        ),
      ),
      index,
      theme,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = AdaptiveAppShell.getTheme(context);
    final headerConfig = AdaptiveAppShell.getSidebarHeader(context);
    final isColumn = theme.isSidebarInCulomn;

    return Consumer<StatusProvider>(
      builder: (context, statusProvider, child) {
        final isCollapsed = statusProvider.isSidebarCollapsed;
        final collapsedWidth = theme.itemHeight * 1.5;
        final expandedWidth = theme.itemHeight * 5;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          width: isCollapsed ? collapsedWidth : expandedWidth,
          color: theme.backgroundColor,
          child: Column(
            children: [
              // Header
              _buildHeader(
                  context, theme, headerConfig, isCollapsed, statusProvider),

              // Collapse/Expand button at top
              _buildCollapseButton(context, theme, isCollapsed, statusProvider),

              // Sidebar Items
              Expanded(
                child: isCollapsed
                    ? _buildCollapsedLayout(context, theme)
                    : isColumn
                        ? _buildColumnLayout(context, theme)
                        : _buildExpandableLayout(context, theme),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Build header with optional collapse functionality
  Widget _buildHeader(
    BuildContext context,
    SideBarNavigationTheames theme,
    dynamic headerConfig,
    bool isCollapsed,
    StatusProvider statusProvider,
  ) {
    if (isCollapsed) {
      return const SizedBox.shrink();
    }

    if (headerConfig != null) {
      return headerConfig.buildHeader(context);
    }

    return Container(
      height: theme.itemHeight * 1.7,
      alignment: Alignment.center,
      color: theme.backgroundColor,
      child: Text(
        theme.titleApp ?? 'تطبيقي',
        style: TextStyle(
          fontSize: theme.fontSize * 1.6,
          fontWeight: theme.selectedFontWeight,
          color: theme.textColor,
        ),
      ),
    );
  }

  /// Build collapse/expand button
  Widget _buildCollapseButton(
    BuildContext context,
    SideBarNavigationTheames theme,
    bool isCollapsed,
    StatusProvider statusProvider,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: isCollapsed 
          ? Alignment.center 
          : (theme.layoutDirection == TextDirection.rtl ? Alignment.centerLeft : Alignment.centerRight),
      child: IconButton(
        onPressed: () {
          statusProvider.toggleSidebarCollapsed();
        },
        icon: AnimatedRotation(
          duration: const Duration(milliseconds: 250),
          turns: isCollapsed ? 0.5 : 0,
          child: Icon(
            theme.layoutDirection == TextDirection.rtl
                ? Icons.keyboard_double_arrow_right
                : Icons.keyboard_double_arrow_left,
            color: theme.iconColor,
            size: theme.iconSize,
          ),
        ),
        tooltip: isCollapsed ? 'توسيع' : 'تصغير',
      ),
    );
  }

  /// Build collapsed layout (icons only)
  Widget _buildCollapsedLayout(
      BuildContext context, SideBarNavigationTheames theme) {
    final organizedItems = _organizeItems(widget.items);
    final groupedItems =
        organizedItems['grouped'] as Map<String, List<dynamic>>;
    final standaloneItems = organizedItems['standalone'] as List<dynamic>;

    final listChildren = <Widget>[];
    int itemIndex = 0;

    // Add standalone items at the beginning
    for (var item in standaloneItems) {
      final isSelected = widget.selectedIndex == widget.items.indexOf(item);
      itemIndex++;

      listChildren.add(
        _buildAnimatedItem(
          Tooltip(
            message: item.label,
            preferBelow: false,
            child: InkWell(
              onTap: () {
                _isNavigating = true;

                final appShellProvider =
                    Provider.of<AppShellRouterProvider>(context, listen: false);
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }

                appShellProvider.handleItemTapByPath(
                    context, item.path!, item.resolvedPath);

                Future.delayed(const Duration(milliseconds: 300), () {
                  if (mounted) {
                    _isNavigating = false;
                  }
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                height: theme.itemHeight,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.selectedBackgroundColor
                      : theme.backgroundColor,
                  border: isSelected
                      ? Border(
                          left: theme.layoutDirection == TextDirection.ltr
                              ? BorderSide(
                                  color: theme.selectedBorderColor,
                                  width: theme.selectedBorderWidth,
                                )
                              : BorderSide.none,
                          right: theme.layoutDirection == TextDirection.rtl
                              ? BorderSide(
                                  color: theme.selectedBorderColor,
                                  width: theme.selectedBorderWidth,
                                )
                              : BorderSide.none,
                        )
                      : null,
                ),
                child: Icon(
                  item.icon,
                  color: isSelected ? theme.selectedIconColor : theme.iconColor,
                  size: theme.iconSize,
                ),
              ),
            ),
          ),
          itemIndex,
          theme,
        ),
      );
    }

    // Add grouped items (parents)
    groupedItems.forEach((parentName, childItems) {
      final parentItem = childItems.first;
      itemIndex++;

      bool isParentSelected = false;
      for (var childItem in childItems) {
        if (widget.selectedIndex == widget.items.indexOf(childItem)) {
          isParentSelected = true;
          break;
        }
      }

      listChildren.add(
        _buildAnimatedItem(
          PopupMenuButton<dynamic>(
            tooltip: parentName,
            offset: Offset(theme.itemHeight * 1.5, 0),
            color: theme.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: theme.selectedBorderColor ?? Colors.transparent,
              ),
            ),
            onSelected: (childItem) {
              _isNavigating = true;

              final appShellProvider =
                  Provider.of<AppShellRouterProvider>(context, listen: false);

              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }

              appShellProvider.handleItemTapByPath(
                  context, childItem.path!, childItem.resolvedPath);

              Future.delayed(const Duration(milliseconds: 300), () {
                if (mounted) {
                  _isNavigating = false;
                }
              });
            },
            itemBuilder: (BuildContext context) {
              return childItems.map((childItem) {
                final isChildSelected =
                    widget.selectedIndex == widget.items.indexOf(childItem);

                return PopupMenuItem<dynamic>(
                  value: childItem,
                  child: Row(
                    children: [
                      Icon(
                        childItem.icon,
                        color: isChildSelected
                            ? theme.selectedIconColor
                            : theme.iconColor,
                        size: theme.iconSize * 0.8,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        childItem.label,
                        style: TextStyle(
                          color: isChildSelected
                              ? (theme.selectedTextColor ?? theme.selectedIconColor)
                              : theme.textColor,
                          fontSize: theme.fontSize,
                          fontWeight: isChildSelected
                              ? theme.selectedFontWeight
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList();
            },
            child: Tooltip(
              message: parentName,
              preferBelow: false,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                height: theme.itemHeight,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isParentSelected
                      ? theme.selectedBackgroundColor
                      : theme.backgroundColor,
                  border: isParentSelected
                      ? Border(
                          left: theme.layoutDirection == TextDirection.ltr
                              ? BorderSide(
                                  color: theme.selectedBorderColor,
                                  width: theme.selectedBorderWidth,
                                )
                              : BorderSide.none,
                          right: theme.layoutDirection == TextDirection.rtl
                              ? BorderSide(
                                  color: theme.selectedBorderColor,
                                  width: theme.selectedBorderWidth,
                                )
                              : BorderSide.none,
                        )
                      : null,
                ),
                child: Icon(
                  parentItem.parentIcon ?? Icons.folder,
                  color: isParentSelected ? theme.selectedIconColor : theme.iconColor,
                  size: theme.iconSize,
                ),
              ),
            ),
          ),
          itemIndex,
          theme,
        ),
      );
    });

    return ListView(
      children: listChildren,
    );
  }

  /// Build column layout (isSidebarInCulomn = true)
  Widget _buildColumnLayout(
      BuildContext context, SideBarNavigationTheames theme) {
    int itemIndex = 0;

    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        if (item.isSideBarRouted == false || item.isVisableInSideBar == false) {
          return const SizedBox.shrink();
        }

        final isSelected = widget.selectedIndex == index;
        itemIndex++;
        return _buildSidebarItem(context, item, itemIndex, theme, isSelected);
      },
    );
  }

  /// Build expandable layout with ExpansionTiles (isSidebarInCulomn = false)
  Widget _buildExpandableLayout(
      BuildContext context, SideBarNavigationTheames theme) {
    final organizedItems = _organizeItems(widget.items);
    final groupedItems =
        organizedItems['grouped'] as Map<String, List<dynamic>>;
    final standaloneItems = organizedItems['standalone'] as List<dynamic>;

    final listChildren = <Widget>[];
    int groupIndex = 0;
    int itemIndex = 0;

    // Add standalone items at the beginning
    for (var item in standaloneItems) {
      final isSelected = widget.selectedIndex == widget.items.indexOf(item);
      listChildren.add(
        _buildSidebarItem(context, item, itemIndex++, theme, isSelected),
      );
    }

    // Add grouped items with ExpansionTiles
    groupedItems.forEach((parentName, childItems) {
      final parentItem = childItems.first;
      final currentGroupIndex = groupIndex;
      groupIndex++;

      listChildren.add(
        _buildAnimatedItem(
          Consumer<StatusProvider>(
            builder: (context, statusProvider, child) {
              final isExpanded =
                  statusProvider.OpenedSubMenuIndex == currentGroupIndex;

              return ExpansionTile(
                key: ValueKey(parentName),
                initiallyExpanded: isExpanded,
                leading: Icon(
                  parentItem.parentIcon ?? Icons.folder,
                  color: isExpanded ? theme.expandedIconColor : theme.iconColor,
                ),
                title: Text(
                  parentName,
                  style: TextStyle(
                    color:
                        isExpanded ? theme.expandedTextColor : theme.textColor,
                    fontSize: theme.fontSize,
                    fontWeight: theme.selectedFontWeight,
                  ),
                ),
                iconColor:
                    isExpanded ? theme.expandedArrowColor : theme.iconColor,
                collapsedIconColor: theme.iconColor,
                backgroundColor: isExpanded
                    ? theme.expandedBackgroundColor
                    : theme.backgroundColor,
                collapsedBackgroundColor: theme.backgroundColor,
                onExpansionChanged: (newIsExpanded) {
                  // Don't allow closing while navigating
                  if (_isNavigating && !newIsExpanded) {
                    print(
                        'Navigation in progress - preventing $parentName from closing');
                    return;
                  }

                  // Use the statusProvider from Consumer builder
                  if (newIsExpanded) {
                    statusProvider
                        .setOpenedSubMenuExtesionsIndex(currentGroupIndex);
                    print(
                        '$parentName (index: $currentGroupIndex) ExpansionTile OPENED');
                  } else {
                    statusProvider.setOpenedSubMenuExtesionsIndex(-1);
                    print(
                        '$parentName (index: $currentGroupIndex) ExpansionTile CLOSED');
                  }
                },
                children: childItems.map((childItem) {
                  final childIsSelected =
                      widget.selectedIndex == widget.items.indexOf(childItem);
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: SidebarItemWidget(
                      icon: childItem.icon,
                      label: childItem.label,
                      isSelected: childIsSelected,
                      theme: theme,
                      onTap: () {
                        // Set navigation flag to prevent expansion tile closing
                        _isNavigating = true;

                        final appShellProvider =
                            Provider.of<AppShellRouterProvider>(context,
                                listen: false);
                        // 1. أغلق القائمة
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }

                        // 2. اذهب للرابط
                        appShellProvider.handleItemTapByPath(
                            context, childItem.path!, childItem.resolvedPath);

                        // Reset navigation flag after a short delay
                        Future.delayed(const Duration(milliseconds: 300), () {
                          if (mounted) {
                            _isNavigating = false;
                          }
                        });
                      },
                    ),
                  );
                }).toList(),
              );
            },
          ),
          itemIndex,
          theme,
        ),
      );
    });

    return ListView(
      children: listChildren,
    );
  }
}
