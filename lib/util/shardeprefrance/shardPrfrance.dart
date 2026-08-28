import 'package:shared_preferences/shared_preferences.dart';

/// مدير التخزين المحلي المشترك (Shared Preferences Manager)
///
/// يوفر وصولاً مركزياً بنمط (Singleton) لتخزين واسترجاع بيانات الجلسة والمصادقة محلياً،
/// مثل: بيانات المستخدم، حالة تسجيل الدخول، والـ Tokens المشتركة مع `matger-express`.
class SharedPrefranceData {
  /// مفتاح تخزين بيانات المستخدم بصيغة JSON.
  static const String USER_DATA = "userData";

  /// مفتاح التحقق من اكتمال تسجيل المستخدم.
  static const String USER_ISREJESTED = "userIsREjestId";

  /// مفتاح حفظ البريد الإلكتروني.
  static const String USER_EMAIL = "userEmail";

  /// مفتاح حفظ كلمة المرور المشفرة.
  static const String USER_PASS = "userPass";

  /// مفتاح المعرف الفريد للمستخدم (User UID).
  static const String USER_UID = "userUid";

  /// مفتاح رمز المصادقة (Auth Token / JWT).
  static const String USER_TOKen = "userToken";

  /// مثيل SharedPreferences الفعلي.
  late SharedPreferences sharedPrefrance;

  static final SharedPrefranceData _data = SharedPrefranceData.instance();

  SharedPrefranceData.instance() {
    loadData();
  }

  factory SharedPrefranceData() {
    return _data;
  }

  /// تحميل وتهيئة مثيل SharedPreferences عند بدء التشغيل.
  Future loadData() async {
    sharedPrefrance = await SharedPreferences.getInstance();
  }
}

