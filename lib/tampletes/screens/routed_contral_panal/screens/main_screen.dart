import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/sidebar_provider.dart';
import '../widgets/sidebar_item_widget.dart';

/// الشاشة الرئيسية مع الشريط الجانبي
class MainScreen extends StatefulWidget {
  final Widget contentWidget;

  const MainScreen({super.key, required this.contentWidget});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // إنشاء محتوى الشريط الجانبي
  Widget _buildSidebarContent(
    BuildContext context,
    List<dynamic> items,
    int selectedIndex,
  ) {
    return Column(
      children: [
        // شعار التطبيق
        Container(
          height: 80,
          alignment: Alignment.center,
          child: const Text(
            'تطبيقي',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),

        // قائمة العناصر
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return SidebarItemWidget(
                icon: items[index].icon,
                label: items[index].label,
                isSelected: selectedIndex == index,
                onTap: () {
                  context.go(items[index].path);
                  // إذا كان الـ Drawer مفتوحًا، أغلقه بعد النقر
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
              );
            },
          ),
        ),

        // زر إضافة عنصر جديد
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final sidebarProvider = Provider.of<SidebarProvider>(context);
    final items = sidebarProvider.sidebarItems;
    final selectedIndex = sidebarProvider.selectedIndex;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 800;

    return Scaffold(
      // إظهار زر القائمة في الـ AppBar عندما تكون الشاشة صغيرة
      appBar:
          isSmallScreen
              ? AppBar(
                title: const Text(
                  'تطبيقي',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                actions: [
                  // يمكن إضافة المزيد من الأزرار هنا
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      // إضافة إجراءات إضافية إذا لزم الأمر
                    },
                  ),
                ],
              )
              : null,

      // إضافة درج تنقل عندما تكون الشاشة صغيرة
      drawer:
          isSmallScreen
              ? Drawer(
                width: 280,
                child: _buildSidebarContent(context, items, selectedIndex),
              )
              : null,

      body: Row(
        children: [
          // إظهار الشريط الجانبي فقط إذا كانت الشاشة كبيرة
          if (!isSmallScreen)
            Container(
              width: 240,
              color: Colors.grey.shade100,
              child: _buildSidebarContent(context, items, selectedIndex),
            ),

          // إظهار الخط الفاصل فقط إذا كانت الشاشة كبيرة
          if (!isSmallScreen) Container(width: 1, color: Colors.grey.shade300),

          // المحتوى الرئيسي
          Expanded(child: widget.contentWidget),
        ],
      ),
    );
  }
}
