// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:go_router/go_router.dart';
// import '../providers/auth_provider.dart';

// /// شاشة تسجيل الدخول
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _obscurePassword = true;

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   Future<void> _login() async {
//     if (!_formKey.currentState!.validate()) return;

//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final success = await authProvider.login(
//       _usernameController.text.trim(),
//       _passwordController.text.trim(),
//     );

//     if (success && mounted) {
//       context.go('/home');
//     } else if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('فشل في تسجيل الدخول. تحقق من بيانات الاعتماد.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(maxWidth: 400),
//             child: Card(
//               elevation: 8,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(32),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       // شعار التطبيق
//                       const Icon(
//                         Icons.lock_outline,
//                         size: 80,
//                         color: Colors.blue,
//                       ),
//                       const SizedBox(height: 24),
//                       const Text(
//                         'تسجيل الدخول',
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 8),
//                       const Text(
//                         'أدخل بيانات الاعتماد للوصول إلى التطبيق',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 32),

//                       // حقل اسم المستخدم
//                       TextFormField(
//                         controller: _usernameController,
//                         decoration: const InputDecoration(
//                           labelText: 'اسم المستخدم',
//                           prefixIcon: Icon(Icons.person),
//                           border: OutlineInputBorder(),
//                           filled: true,
//                           fillColor: Colors.white,
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'يرجى إدخال اسم المستخدم';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16),

//                       // حقل كلمة المرور
//                       TextFormField(
//                         controller: _passwordController,
//                         obscureText: _obscurePassword,
//                         decoration: InputDecoration(
//                           labelText: 'كلمة المرور',
//                           prefixIcon: const Icon(Icons.lock),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _obscurePassword
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                             ),
//                             onPressed: () {
//                               setState(
//                                   () => _obscurePassword = !_obscurePassword);
//                             },
//                           ),
//                           border: const OutlineInputBorder(),
//                           filled: true,
//                           fillColor: Colors.white,
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'يرجى إدخال كلمة المرور';
//                           }
//                           if (value.length < 6) {
//                             return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 24),

//                       // زر تسجيل الدخول
//                       Consumer<AuthProvider>(
//                         builder: (context, authProvider, child) {
//                           return ElevatedButton(
//                             onPressed: authProvider.isLoading ? null : _login,
//                             style: ElevatedButton.styleFrom(
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               backgroundColor: Colors.blue,
//                               foregroundColor: Colors.white,
//                             ),
//                             child: authProvider.isLoading
//                                 ? const SizedBox(
//                                     height: 20,
//                                     width: 20,
//                                     child: CircularProgressIndicator(
//                                       strokeWidth: 2,
//                                       valueColor: AlwaysStoppedAnimation<Color>(
//                                         Colors.white,
//                                       ),
//                                     ),
//                                   )
//                                 : const Text(
//                                     'تسجيل الدخول',
//                                     style: TextStyle(fontSize: 16),
//                                   ),
//                           );
//                         },
//                       ),
//                       const SizedBox(height: 16),

//                       // معلومات بيانات التجربة
//                       Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.blue.shade50,
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: Colors.blue.shade200),
//                         ),
//                         child: const Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'للتجربة:',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               'أدخل أي اسم مستخدم وكلمة مرور (6 أحرف على الأقل)',
//                               style: TextStyle(fontSize: 14),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
