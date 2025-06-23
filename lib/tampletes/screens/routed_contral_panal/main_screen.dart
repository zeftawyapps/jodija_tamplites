import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/custom_sidebar.dart';
import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/providers/navigation_provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  String oldlen = "ar";
  bool animation = true;
  late AnimationController _animatedContainer;
  late NavigationProvider provider;
  @override
  void initState() {
    super.initState();
    _animatedContainer = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    provider = Provider.of<NavigationProvider>(context, listen: false);

    // Example of adding navigation items - you should customize this for your needs
    if (provider.navigationItems.isEmpty) {
      _setupNavigationItems();
    }
  }

  void _setupNavigationItems() {
    // Example of adding navigation items
    provider.addNavigationItem(
      label: 'Dashboard',
      icon: Icons.dashboard,
      path: '/dashboard',
      page: const Center(child: Text('Dashboard Page')),
    );

    provider.addNavigationItem(
      label: 'Users',
      icon: Icons.people,
      path: '/users',
      page: const Center(child: Text('Users Page')),
    );

    provider.addNavigationItem(
      label: 'Settings',
      icon: Icons.settings,
      path: '/settings',
      page: const Center(child: Text('Settings Page')),
    );

    // Set the logo and title if needed
    // provider.setLogo("assets/images/logo.png");
    provider.setTitle("Admin Control Panel");
  }

  @override
  Widget build(BuildContext context) {
    // var dd = SettingChangeLestner.of(context);
    // String lang = dd.state.language!;

    return SafeArea(
      child: Scaffold(
        body: FadeIn(
          controller: (controller) => _animatedContainer = controller,
          animate: animation,
          duration: Duration(seconds: 1),
          child: Container(
            // reach text using q['name']
            decoration: provider.logo == "null"
                ? BoxDecoration()
                : BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        provider.logo,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          blurRadius: 50,
                          offset: Offset(0, 20))
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomSidebar(),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.7),
                                        blurRadius: 60,
                                        offset: Offset(0, 5))
                                  ],
                                ),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // add image logo

                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Text(provider.getTitle(),
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                              child: Container(
                                child: provider.getCurrentPage(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
