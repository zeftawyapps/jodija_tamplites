import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/models/route_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/sidebar_item_widget.dart';
import '../laaunser.dart';
import '../providers/sidebar_provider.dart';
import '../providers/status_provider.dart';
import 'sidebar_group_item_widget.dart';

class DrawerbarWidget extends StatelessWidget {
  final List<RouteItem> items;
  final int selectedIndex;

  const DrawerbarWidget({
    super.key,
    required this.items,
    required this.selectedIndex,
  });

  /// Organize items into groups (parent with children) and standalone items
  Map<String, dynamic> _organizeItems(List<RouteItem> allItems) {
    final groupedItems = <String, List<RouteItem>>{};
    final standaloneItems = <RouteItem>[];

    for (var item in allItems) {
      if (item.isSideBarRouted == false ||
          item.isVisableInSideBar == false ||
          item.isUnViasibleInSideBarIfSmall == true) {
        continue;
      }

      if (item.isChildItem) {
        final parentName = item.parentName ?? 'default';
        groupedItems.putIfAbsent(parentName, () => []);
        groupedItems[parentName]!.add(item);
      } else {
        standaloneItems.add(item);
      }
    }

    return {
      'grouped': groupedItems,
      'standalone': standaloneItems,
    };
  }

  /// Find the group index containing the selected index
  int _findSelectedGroupIndex(List<RouteItem> allItems, int selectedIdx) {
    final organizedItems = _organizeItems(allItems);
    final groupedItems = organizedItems['grouped'] as Map<String, List<RouteItem>>;
    
    int groupIndex = 0;
    for (var parentName in groupedItems.keys) {
      final childItems = groupedItems[parentName]!;
      for (var childItem in childItems) {
        if (allItems.indexOf(childItem) == selectedIdx) {
          return groupIndex;
        }
      }
      groupIndex++;
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    // Get the theme from the provider
    final theme = AdaptiveAppShell.getTheme(context);
    // Get sidebar header configuration
    final headerConfig = AdaptiveAppShell.getSidebarHeader(context);

    // Auto expand parent group on load if not set
    final statusProvider = context.read<StatusProvider>();
    final selectedGroupIndex = _findSelectedGroupIndex(items, selectedIndex);
    if (selectedGroupIndex != -1 && statusProvider.OpenedSubMenuIndex == -1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final provider = context.read<StatusProvider>();
        if (provider.OpenedSubMenuIndex == -1) {
          provider.setOpenedSubMenuExtesionsIndex(selectedGroupIndex);
        }
      });
    }

    final organizedItems = _organizeItems(items);
    final groupedItems = organizedItems['grouped'] as Map<String, List<RouteItem>>;
    final standaloneItems = organizedItems['standalone'] as List<RouteItem>;

    final listChildren = <Widget>[];
    int groupIndex = 0;

    // Add standalone items
    for (var item in standaloneItems) {
      final isSelected = selectedIndex == items.indexOf(item);
      listChildren.add(
        SidebarItemWidget(
          icon: item.icon,
          label: item.label,
          isSelected: isSelected,
          theme: theme,
          onTap: () {
            final appShellProvider =
                Provider.of<AppShellRouterProvider>(context, listen: false);
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            appShellProvider.handleItemTapByPath(
                context, item.path!, item.resolvedPath);
          },
        ),
      );
    }

    // Add grouped items with ExpansionTiles
    groupedItems.forEach((parentName, childItems) {
      final parentItem = childItems.first;
      final currentGroupIndex = groupIndex;
      groupIndex++;

      // Check if one of the children is selected
      bool isParentSelected = false;
      for (var childItem in childItems) {
        if (selectedIndex == items.indexOf(childItem)) {
          isParentSelected = true;
          break;
        }
      }

      listChildren.add(
        Consumer<StatusProvider>(
          builder: (context, statusProvider, child) {
            final isExpanded =
                statusProvider.OpenedSubMenuIndex == currentGroupIndex;

            return SidebarGroupItemWidget(
              parentName: parentName,
              parentIcon: parentItem.parentIcon,
              theme: theme,
              isExpanded: isExpanded,
              isParentSelected: isParentSelected,
              onExpansionChanged: (newIsExpanded) {
                if (newIsExpanded) {
                  statusProvider.setOpenedSubMenuExtesionsIndex(currentGroupIndex);
                } else {
                  statusProvider.setOpenedSubMenuExtesionsIndex(-1);
                }
              },
              children: childItems.map((childItem) {
                final childIsSelected = selectedIndex == items.indexOf(childItem);
                return Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: SidebarItemWidget(
                    icon: childItem.icon,
                    label: childItem.label,
                    isSelected: childIsSelected,
                    theme: theme,
                    onTap: () {
                      final appShellProvider =
                          Provider.of<AppShellRouterProvider>(context, listen: false);
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                      appShellProvider.handleItemTapByPath(
                          context, childItem.path!, childItem.resolvedPath);
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
      );
    });

    return Container(
      width: theme.itemHeight * 5, // Dynamic width based on theme
      color: theme.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            // Custom or default header
            if (headerConfig != null)
              headerConfig.buildHeader(context)
            else
              // Default header if no custom header is provided
              Container(
                height: theme.itemHeight * 1.7, // Responsive based on theme
                alignment: Alignment.center,
                color: theme.backgroundColor,
                child: Text(
                  'تطبيقي',
                  style: TextStyle(
                    fontSize: theme.fontSize * 1.6,
                    fontWeight: theme.selectedFontWeight,
                    color: theme.textColor,
                  ),
                ),
              ),

            // قائمة العناصر
            Expanded(
              child: ListView(
                children: listChildren,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
