import '../view_data_model/base_data_model.dart';

/// واجهة إجراءات وعمليات BLoC للبيانات (Data Source BLoC CRUD Actions Contract)
///
/// توفر عقداً قياسياً لدوال تنفيذ العمليات المباشرة (إضافة، تعديل، حذف، واسترجاع القائمة)
/// داخل كلاسات الـ BLoC الخاصة بالبيانات.
///
/// English Description:
/// Contract interface establishing standard CRUD action dispatches (insert, update, delete, get)
/// for data-driven BLoC and Cubit components.
abstract class DataSourceDataActionsBloc<T extends BaseViewDataModel> {
  /// إدراج عنصر بيانات جديد (Inserts a new item).
  void insertData(T data);

  /// تحديث عنصر موجود بواسطة معرفه (Updates an existing record by ID).
  void updateData(T data, String id);

  /// حذف عنصر بواسطة معرفه (Deletes a record by ID).
  void deleteData(String id);

  /// جلب واسترجاع قائمة البيانات (Fetches records list).
  void getListData();
}