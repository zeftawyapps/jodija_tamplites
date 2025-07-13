// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:go_router/go_router.dart';
// import '../providers/auth_provider.dart';

// /// شاشة البداية لفحص حالة المصادقة
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // إعداد الرسوم المتحركة
//     _animationController = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeIn,
//     ));

//     _scaleAnimation = Tween<double>(
//       begin: 0.5,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.elasticOut,
//     ));

//     _animationController.forward();
//     _checkAuthStatus();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   Future<void> _checkAuthStatus() async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);

//     // انتظار لإتمام الرسوم المتحركة
//     await Future.delayed(const Duration(seconds: 3));

//     await authProvider.checkAuthStatus();

//     if (mounted) {
//       if (authProvider.isLoggedIn) {
//         context.go('/dashboard');
//       } else {
//         context.go('/login');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue.shade50,
//       body: Center(
//         child: AnimatedBuilder(
//           animation: _animationController,
//           builder: (context, child) {
//             return FadeTransition(
//               opacity: _fadeAnimation,
//               child: ScaleTransition(
//                 scale: _scaleAnimation,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // شعار التطبيق
//                     Container(
//                       padding: const EdgeInsets.all(32),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.blue.shade200,
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: const Icon(
//                         Icons.dashboard,
//                         size: 80,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     const SizedBox(height: 32),

//                     // اسم التطبيق
//                     const Text(
//                       'تطبيق الشريط الجانبي',
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     const SizedBox(height: 16),

//                     // وصف التطبيق
//                     const Text(
//                       'نظام إدارة متقدم مع واجهة سهلة الاستخدام',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 48),

//                     // مؤشر التحميل
//                     Consumer<AuthProvider>(
//                       builder: (context, authProvider, child) {
//                         return Column(
//                           children: [
//                             const CircularProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation<Color>(
//                                 Colors.blue,
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             Text(
//                               authProvider.isLoading
//                                   ? 'جاري التحقق من بيانات المصادقة...'
//                                   : 'جاري التحميل...',
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
