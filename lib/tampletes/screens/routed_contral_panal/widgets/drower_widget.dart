import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/models/route_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/sidebar_item_widget.dart';
import '../laaunser.dart';
import '../providers/sidebar_provider.dart';

class DrawerbarWidget extends StatelessWidget {
  final List<RouteItem> items;
  final int selectedIndex;

  const DrawerbarWidget({
    super.key,
    required this.items,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {

   List<RouteItem> filteredItems = this.items.where((item) => item.isSideBarRouted == true || item.isVisableInSideBar == true && item.isUnViasibleInSideBarIfSmall == false  ).toList();

    // Get the theme from the provider
    final theme = AdaptiveAppShell.getTheme(context);
    // Get sidebar header configuration
    final headerConfig =
        AdaptiveAppShell.getSidebarHeader(context);

    return Container(
      width: theme.itemHeight * 5, // Dynamic width based on theme
      color: theme.backgroundColor,
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
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final isSelected = selectedIndex == index;
                  if (filteredItems[index].isSideBarRouted == false || filteredItems[index].isVisableInSideBar == false
                || filteredItems[index].isUnViasibleInSideBarIfSmall == true
                  ) {
                    // إذا كان العنصر ليس مسارًا جانبيًا، لا نعرضه
                    return const SizedBox.shrink();
                  }

                return SidebarItemWidget(
                  icon: items[index].icon,
                  label: items[index].label,
                  isSelected: isSelected,
                  theme: theme, // Pass the theme to the item widget
                  onTap: () {
                    final appShellProvider =
                        Provider.of<AppShellRouterProvider>(context, listen: false);
                    // final authProvider =
                    //     Provider.of<AuthProvider>(context, listen: false);

                    // Handle special logout case

                    // Use the provider's handle method
                    // appShellProvider.handleItemTap(context, items[index], index);
                    appShellProvider.handleItemTapByPath(context, items[index].path!);

                    // إذا كان الـ Drawer مفتوحًا، أغلقه بعد النقر
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
