/// واجهة موصل الشبكة والاتصال بالخادم (HTTP & API Connector Contract)
///
/// يمثل هذا الكلاس التجريدي العقد الأساسي لربط تطبيقات الواجهة الأمامية (`matger-management-app`, `matger-client-app`)
/// مع خادم الباك إند المركزي (`matger-express`).
///
/// English Description:
/// Abstract HTTP Connector contract governing network communication between
/// frontend applications and central backend microservices. Standardizes Base URL
/// handling, authentication header injection, interceptors, and error handling.
///
/// ### مثال للاستخدام (Usage Example):
/// ```dart
/// class MyHttpConnector extends AppHttpConnector {
///   @override
///   String get baseUrl => "https://api.example.com";
/// }
/// ```
abstract class AppHttpConnector {
  /// الرابط الأساسي للخادم (Base URL)
  /// The base URL string for backend network requests.
  String get baseUrl => "";

  /// ترويسات الطلبات الافتراضية (Default HTTP Headers)
  /// Default HTTP headers injected into outgoing network requests.
  Map<String, String> get defaultHeaders => {};
}