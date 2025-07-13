// import 'package:flutter/material.dart';

// /// مزود حالة المصادقة
// class AuthProvider extends ChangeNotifier {
//   bool _isLoggedIn = false;
//   String? _userToken;
//   String? _userName;
//   bool _isLoading = false;

//   bool get isLoggedIn => _isLoggedIn;
//   String? get userToken => _userToken;
//   String? get userName => _userName;
//   bool get isLoading => _isLoading;

//   /// تسجيل الدخول
//   Future<bool> login(String username, String password) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       // محاكاة استدعاء API
//       await Future.delayed(const Duration(seconds: 2));

//       // تحقق بسيط (استبدل بالمصادقة الحقيقية)
//       if (username.isNotEmpty && password.isNotEmpty) {
//         _isLoggedIn = true;
//         _userToken = 'fake_token_${DateTime.now().millisecondsSinceEpoch}';
//         _userName = username;
//         _isLoading = false;
//         notifyListeners();
//         return true;
//       }
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     } catch (e) {
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   /// تسجيل الخروج
//   void logout() {
//     _isLoggedIn = false;
//     _userToken = null;
//     _userName = null;
//     notifyListeners();
//   }

//   /// فحص حالة المصادقة عند بدء التطبيق
//   Future<void> checkAuthStatus() async {
//     _isLoading = true;
//     notifyListeners();

//     // محاكاة فحص الرمز المحفوظ
//     await Future.delayed(const Duration(seconds: 1));

//     // في التطبيق الحقيقي، تحقق من SharedPreferences أو التخزين الآمن
//     // الآن، افترض أن المستخدم غير مسجل دخول
//     _isLoggedIn = false;
//     _isLoading = false;
//     notifyListeners();
//   }

//   /// تحقق من صحة الرمز المميز
//   Future<bool> validateToken() async {
//     if (_userToken == null) return false;

//     try {
//       // محاكاة تحقق من الخادم
//       await Future.delayed(const Duration(seconds: 1));
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
// }
