import 'package:flutter/material.dart';

/// أنواع البيانات المدعومة في محرك الخلايا والحقول (Cell & Field Data Types)
enum CellDataType {
  /// نص قصير سطر واحد (اسم، عنوان، كود...)
  text,

  /// نص طويل متعدد الأسطر (ملاحظات، تقارير سريرية...)
  multilineText,

  /// بريد إلكتروني
  email,

  /// رقم هاتف
  phone,

  /// كلمة مرور / نص مخفي
  password,

  /// عدد صحيح (عمر، تكرارات، أيام...)
  integer,

  /// رقم عشري دقيق (وزن، جرعة، حرارة...)
  decimal,

  /// قيمة رقمية مرتبطة بوحدة قياس (مثل: 120 mmHg, 5.5 mg/dL)
  measuredValue,

  /// اختيار واحد من قائمة منسدلة
  dropdown,

  /// اختيار واحد من أزرار معروضة (Radio Group)
  radio,

  /// اختيار متعدد من قائمة خيارات (Multi-select / Checkbox list)
  multiSelect,

  /// قيمة منطقية ثنائية (Switch / Checkbox - صح أو خطأ)
  boolean,

  /// تاريخ فقط (يوم / شهر / سنة)
  date,

  /// وقت فقط (ساعة : دقيقة)
  time,

  /// تاريخ ووقت معاً
  dateTime,

  /// نطاق زمني (من تاريخ إلى تاريخ)
  dateRange,

  /// صورة (من الكاميرا أو المعرض)
  image,

  /// ملف أو مستند مرفق (PDF، تقرير...)
  file,

  /// مرجع أو ربط بسجل من جدول آخر (Reference / Lookup)
  reference,

  /// إدخال متعدد متكرر (Repeater / Nested List of Cells)
  repeater,
}

/// ملحقات ومساعدات للتعامل مع أنواع البيانات
extension CellDataTypeExtension on CellDataType {
  /// الاسم العربي المعروض للنوع
  String get displayNameAr {
    switch (this) {
      case CellDataType.text:
        return 'نص قصير';
      case CellDataType.multilineText:
        return 'نص متعدد الأسطر';
      case CellDataType.email:
        return 'بريد إلكتروني';
      case CellDataType.phone:
        return 'رقم هاتف';
      case CellDataType.password:
        return 'كلمة مرور';
      case CellDataType.integer:
        return 'رقم صحيح (Integer)';
      case CellDataType.decimal:
        return 'رقم عشري (Decimal)';
      case CellDataType.measuredValue:
        return 'قيمة مع وحدة قياس';
      case CellDataType.dropdown:
        return 'قائمة منسدلة (Dropdown)';
      case CellDataType.radio:
        return 'اختيار مفرد (Radio)';
      case CellDataType.multiSelect:
        return 'اختيار متعدد (Multi-Select)';
      case CellDataType.boolean:
        return 'مفتاح منطقي (Boolean / Switch)';
      case CellDataType.date:
        return 'تاريخ (Date)';
      case CellDataType.time:
        return 'وقت (Time)';
      case CellDataType.dateTime:
        return 'تاريخ ووقت (DateTime)';
      case CellDataType.dateRange:
        return 'فترة زمنية (Date Range)';
      case CellDataType.image:
        return 'صورة (Image)';
      case CellDataType.file:
        return 'ملف مرفق (File / Document)';
      case CellDataType.reference:
        return 'ربط مرجعي (Reference / Lookup)';
      case CellDataType.repeater:
        return 'إدخال متكرر (Repeater / Sub-Form)';
    }
  }

  /// أيقونة تمثل نوع البيانات
  IconData get icon {
    switch (this) {
      case CellDataType.text:
        return Icons.text_fields_rounded;
      case CellDataType.multilineText:
        return Icons.notes_rounded;
      case CellDataType.email:
        return Icons.email_outlined;
      case CellDataType.phone:
        return Icons.phone_outlined;
      case CellDataType.password:
        return Icons.lock_outline_rounded;
      case CellDataType.integer:
        return Icons.pin_outlined;
      case CellDataType.decimal:
        return Icons.calculate_outlined;
      case CellDataType.measuredValue:
        return Icons.speed_rounded;
      case CellDataType.dropdown:
        return Icons.arrow_drop_down_circle_outlined;
      case CellDataType.radio:
        return Icons.radio_button_checked_rounded;
      case CellDataType.multiSelect:
        return Icons.checklist_rounded;
      case CellDataType.boolean:
        return Icons.toggle_on_outlined;
      case CellDataType.date:
        return Icons.calendar_today_rounded;
      case CellDataType.time:
        return Icons.access_time_rounded;
      case CellDataType.dateTime:
        return Icons.event_available_rounded;
      case CellDataType.dateRange:
        return Icons.date_range_rounded;
      case CellDataType.image:
        return Icons.image_outlined;
      case CellDataType.file:
        return Icons.attach_file_rounded;
      case CellDataType.reference:
        return Icons.link_rounded;
      case CellDataType.repeater:
        return Icons.playlist_add_rounded;
    }
  }

  /// هل الحقل رقمي؟
  bool get isNumeric =>
      this == CellDataType.integer ||
      this == CellDataType.decimal ||
      this == CellDataType.measuredValue;

  /// هل الحقل تاريخ أو وقت؟
  bool get isDateTime =>
      this == CellDataType.date ||
      this == CellDataType.time ||
      this == CellDataType.dateTime ||
      this == CellDataType.dateRange;

  /// هل الحقل اختيار من خيارات؟
  bool get isSelection =>
      this == CellDataType.dropdown ||
      this == CellDataType.radio ||
      this == CellDataType.multiSelect;

  /// هل الحقل مكرر متعدد الصفوف؟
  bool get isRepeater => this == CellDataType.repeater;

  /// لوحة المفاتيح المناسبة لنوع البيانات
  TextInputType get keyboardType {
    switch (this) {
      case CellDataType.email:
        return TextInputType.emailAddress;
      case CellDataType.phone:
        return TextInputType.phone;
      case CellDataType.integer:
        return TextInputType.number;
      case CellDataType.decimal:
      case CellDataType.measuredValue:
        return const TextInputType.numberWithOptions(decimal: true);
      case CellDataType.multilineText:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }
}
