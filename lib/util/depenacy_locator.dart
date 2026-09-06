import 'package:get_it/get_it.dart';

/// مثيل GetIt المركزي لحاقن التبعيات (Dependency Locator Instance)
var joDijaLocator = GetIt.instance;

/// الواجهة التجريدية لحاقن التبعيات وحقن الخدمات (Dependency Injection Locator Contract)
///
/// تنظم عملية تسجيل وحقن طبقات التطبيق المختلفة وفق الترتيب المعماري النظيف:
/// 1. الـ BLoC وطبقة إدارة الحالة.
/// 2. الـ Repositories ومستودعات البيانات.
/// 3. الـ DataSources ومصادر الاتصال.
/// 4. الـ Utils والخدمات المساعدة.
/// 5. الخدمات والحزم الخارجية (External).
///
/// English Description:
/// Architectural service locator contract coordinating clean dependency injection
/// across BLoCs, repositories, data sources, and external clients using [GetIt].
abstract class ILocator {
  /// تهيئة وحقن كافة التبعيات بالترتيب (Initializes and registers all dependencies sequentially)
  Future<void> setupLocator() async {
    await _setUpBloc();
    await _setUpRepository();
    await _setUpDatasource();
    await _setUpUtils();
    await _setUpExternal();
  }

  Future<void> _setUpBloc();
  Future<void> _setUpRepository();
  Future<void> _setUpDatasource();
  Future<void> _setUpUtils();
  Future<void> _setUpExternal();
}
