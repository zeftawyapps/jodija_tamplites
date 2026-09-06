/// النموذج الأساسي لبيانات العرض (Base View Data Model)
///
/// يمثل الفئة الأم لكافة نماذج البيانات المعروضة في شاشات الحزمة والجداول والـ BLoC.
/// يوفر معرفاً فريداً (`id`) وقاموساً لتسلسل وفك تسلسل كائنات الـ JSON (`toJson` / `fromJson`).
///
/// English Description:
/// Foundation base entity model for all UI presentation data models in the JoDija ecosystem.
/// Provides standardized identifier mapping and JSON serialization contracts.
///
/// ### مثال للاستخدام (Usage Example):
/// ```dart
/// class ProductModel extends BaseViewDataModel {
///   final String name;
///   ProductModel({required String id, required this.name}) : super(id);
/// }
/// ```
class BaseViewDataModel {
  String? id;

  /// تحويل كائن النموذج إلى قاموس JSON (Serializes model to JSON map)
  Map<String, dynamic> toJson() {
    return {};
  }

  BaseViewDataModel(String? id) {
    this.id = id;
  }

  factory BaseViewDataModel.fromJson(Map<String, dynamic> json, String? id) {
    return BaseViewDataModel(id)..map = json;
  }

  Map<String, dynamic>? map = Map();
}