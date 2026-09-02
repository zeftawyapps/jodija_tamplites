import 'cell_data_type.dart';

/// كائن الخلية الأساسي لتمثيل أي حقل أو خاصية في النظام
/// Supports generic typing, metadata, validation, and JSON serialization.
class Cell<T> {
  /// الاسم البرمجي / المفتاح الفريد للخلية (Key)
  String name;

  /// القيمة المخزنة في الخلية
  T? value;

  /// نوع البيانات الخاص بالخلية (نص، رقم، تاريخ، قائمة، متكرر...)
  CellDataType type;

  /// العنوان أو التسمية التوضيحية المعروضة للمستخدم (Label / Caption)
  String? caption;

  /// وحدة القياس (مثل: kg, mmHg, mg/dL)
  String? unit;

  /// قائمة الخيارات المتاحة (للقوائم المنسدلة، الاختيار المتعدد، إلخ)
  List<String>? options;

  /// هل الحقل إلزامي؟
  bool isRequired;

  /// نص المساعدة أو التلميح (Hint / Helper)
  String? hint;

  /// القيمة الافتراضية
  T? defaultValue;

  Cell(
    this.name, {
    this.value,
    this.type = CellDataType.text,
    this.caption,
    this.unit,
    this.options,
    this.isRequired = false,
    this.hint,
    this.defaultValue,
  }) {
    // إذا لم تُمرر قيمة وكانت هناك قيمة افتراضية، نعيّنها
    if (value == null && defaultValue != null) {
      value = defaultValue;
    }
  }

  /// تحويل الخلية إلى Map كلاسيكية متوافقة مع النظام القديم
  Map<String, dynamic> toMap() {
    return {name: value};
  }

  /// تحويل الخلية وبياناتها الوصفية كاملة إلى JSON
  Map<String, dynamic> toSchemaJson() {
    return {
      'name': name,
      'value': value,
      'type': type.name,
      'caption': caption,
      'unit': unit,
      'options': options,
      'isRequired': isRequired,
      'hint': hint,
      'defaultValue': defaultValue,
    };
  }

  /// استيراد خلية من JSON
  factory Cell.fromSchemaJson(Map<String, dynamic> json) {
    CellDataType detectedType = CellDataType.text;
    if (json['type'] != null) {
      detectedType = CellDataType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => CellDataType.text,
      );
    }

    return Cell<T>(
      json['name'] ?? '',
      value: json['value'] as T?,
      type: detectedType,
      caption: json['caption'],
      unit: json['unit'],
      options: json['options'] != null ? List<String>.from(json['options']) : null,
      isRequired: json['isRequired'] ?? false,
      hint: json['hint'],
      defaultValue: json['defaultValue'] as T?,
    );
  }

  /// استنساخ الخلية مع إمكانية تعديل بعض القيم
  Cell<T> copyWith({
    String? name,
    T? value,
    CellDataType? type,
    String? caption,
    String? unit,
    List<String>? options,
    bool? isRequired,
    String? hint,
    T? defaultValue,
  }) {
    return Cell<T>(
      name ?? this.name,
      value: value ?? this.value,
      type: type ?? this.type,
      caption: caption ?? this.caption,
      unit: unit ?? this.unit,
      options: options ?? (this.options != null ? List.from(this.options!) : null),
      isRequired: isRequired ?? this.isRequired,
      hint: hint ?? this.hint,
      defaultValue: defaultValue ?? this.defaultValue,
    );
  }
}