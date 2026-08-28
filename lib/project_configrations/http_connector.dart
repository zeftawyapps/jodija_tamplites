/// واجهة موصل الشبكة والاتصال بالخادم (HTTP & API Connector Contract)
///
/// يمثل هذا الكلاس التجريدي العقد الأساسي لربط تطبيقات الواجهة الأمامية (`matger-management-app`, `matger-client-app`)
/// مع خادم الباك إند المركزي (`matger-express`).
///
/// يتيح هذا العقد توحيد:
/// - الـ Base URL ونقاط النهاية (Endpoints).
/// - إدارة الـ Headers المشتركة والـ Authorization Tokens.
/// - معالجة الأخطاء والـ Interceptors وإعادة المحاولة.
abstract class AppHttpConnector {

}