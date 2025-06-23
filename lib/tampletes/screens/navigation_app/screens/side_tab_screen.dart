import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/navigation_provider.dart';

/// شاشة تجمع بين الشريط الجانبي والتبويبات العلوية
class SideTabScreen extends StatefulWidget {
  // final int tabIndex;
  final int sideIndex;
  final Widget bodyWidget;

  const SideTabScreen({
    Key? key,
    // required this.tabIndex,
    required this.sideIndex,
    required this.bodyWidget,
  }) : super(key: key);

  @override
  State<SideTabScreen> createState() => _SideTabScreenState();
}

class _SideTabScreenState extends State<SideTabScreen>
    with TickerProviderStateMixin {
  // تغيير من SingleTickerProviderStateMixin إلى TickerProviderStateMixin
  TabController? _tabController;
  bool _isInitializing = false; // لمنع تهيئة مضاعفة للـ TabController

  @override
  void initState() {
    super.initState();
    // تهيئة الـ TabController بعد بناء الويدجت للحصول على سياق Provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _initTabController();
    });
  }

  // void _initTabController() {
  //   if (!mounted || _isInitializing) return;
  //
  //   _isInitializing = true;
  //
  //   // إلغاء المستمع القديم وتخليص الموارد
  //   _disposeTabController();
  //
  //   final provider = Provider.of<NavigationProvider>(context, listen: false);
  //
  //   // التأكد من وجود عناصر تنقل
  //   if (provider.navigationItems.isEmpty) {
  //     _isInitializing = false;
  //     return;
  //   }
  //
  //   // إنشاء وتهيئة TabController
  //   // _tabController = TabController(
  //   //   length: provider.navigationItems.length,
  //   //   vsync: this,
  //   //   initialIndex:
  //   //       widget.tabIndex < provider.navigationItems.length
  //   //           ? widget.tabIndex
  //   //           : 0,
  //   // );
  //   //
  //   // // إضافة مستمع للتغييرات
  //   // _tabController!.addListener(_handleTabChangeListener);
  //
  //   // تحديث واجهة المستخدم
  //   if (mounted) setState(() {});
  //
  //   _isInitializing = false;
  // }

  void _handleTabChangeListener() {
    // تحديث URL عند تغيير التبويب
    if (mounted && _tabController != null && !_tabController!.indexIsChanging) {
      _handleTabChange(_tabController!.index);
    }
  }

  void _disposeTabController() {
    if (_tabController != null) {
      _tabController!.removeListener(_handleTabChangeListener);
      _tabController!.dispose();
      _tabController = null;
    }
  }

  @override
  void dispose() {
    _disposeTabController();
    super.dispose();
  }

  void _handleTabChange(int index) {
    if (_tabController?.indexIsChanging ?? true) return;

    final provider = Provider.of<NavigationProvider>(context, listen: false);
    // التحقق من أن المؤشر صالح
    if (index >= 0 && index < provider.navigationItems.length) {
      // استخدام GoRouter لتغيير المسار
      context.go(provider.navigationItems[index].path);
    }
  }

  @override
  void didUpdateWidget(SideTabScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!mounted) return;

    // إعادة تهيئة TabController عند تغيير عدد عناصر التنقل
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    // final currentTabCount = _tabController?.length ?? 0;
    //
    // if (currentTabCount != provider.navigationItems.length) {
    //   // إذا تغير عدد العناصر، أعد تهيئة TabController بأمان
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     if (mounted && !_isInitializing) {
    //       _initTabController();
    //     }
    //   });
    // } else if (widget.tabIndex != oldWidget.tabIndex &&
    //     _tabController != null) {
    //   // إذا تغير فقط المؤشر المحدد، قم بتحديث المؤشر
    //   if (widget.tabIndex < _tabController!.length) {
    //     _tabController!.animateTo(widget.tabIndex);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    // استماع للتغييرات في NavigationProvider (إضافة أو إزالة عناصر)
    final navigationProvider = Provider.of<NavigationProvider>(context);

    // إعادة تهيئة TabController إذا كان عدد العناصر مختلفًا
    if ((_tabController?.length ?? 0) !=
            navigationProvider.navigationItems.length &&
        !_isInitializing) {
      // جدولة إعادة التهيئة بعد بناء الإطار الحالي
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_isInitializing) {
          // _initTabController();
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('تطبيق متعدد التنقل'),
        // bottom:
              // TabBar(
              //     controller: _tabController,
              //     tabs:
              //         navigationProvider.navigationItems.map((item) {
              //           return Tab(icon: Icon(item.icon), text: item.label);
              //         }).toList(),
              //   ),
      ),
      body: Row(
        children: [
          // القائمة الجانبية
          NavigationRail(
            extended:
                MediaQuery.of(context).size.width >
                800, // توسيع القائمة إذا كانت الشاشة واسعة
            selectedIndex:
                widget.sideIndex < navigationProvider.navigationItems.length
                    ? widget.sideIndex
                    : 0,
            onDestinationSelected: (int index) {
              // التنقل عند النقر على عنصر في القائمة الجانبية
              _handleSideNavigation(index, context);
            },
            destinations:
                navigationProvider.navigationItems.isEmpty
                    ? [
                      const NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('الرئيسية'),
                      ),
                    ]
                    : navigationProvider.navigationItems.map((item) {
                      return NavigationRailDestination(
                        icon: Icon(item.icon),
                        label: Text(item.label),
                      );
                    }).toList(),
          ),
          // خط فاصل
          const VerticalDivider(thickness: 1, width: 1),
          // المحتوى الرئيسي
          Expanded(child: widget.bodyWidget),
        ],
      ),
    );
  }

  void _handleSideNavigation(int index, BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    // التحقق من أن المؤشر صالح
    if (index >= 0 && index < provider.navigationItems.length) {
      // استخدام GoRouter لتغيير المسار
      context.go(provider.navigationItems[index].path);
    }
  }
}
