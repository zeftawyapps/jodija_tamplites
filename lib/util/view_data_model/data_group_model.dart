import 'package:JoDija_tamplites/util/view_data_model/base_data_model.dart';

/// نموذج تجميع البيانات في علاقات رئيسية وفرعية (Hierarchical Data Group Model)
///
/// يدير تجميع البيانات المعقدة في نمط Parent-Child، مثل الفئات والمنتجات التابعة لها،
/// ويفصل بيانات العناصر الرئيسية عن العناصر الفرعية مع فهرسة سريعة.
///
/// English Description:
/// Hierarchical collection data model organizing nested datasets into Parent-Child relationships
/// (such as categories and child products) with automatic map-based child indexation.
class DataGroupModel<peren extends BaseViewDataModel,
    child extends BaseViewDataModel> {
  List<BaseViewDataModel> data;
  String chidlKey;
  peren Function(Map<String, dynamic> data) parentData;
  child Function(Map<String, dynamic> data) childData;
  List<peren>? _parentDataModel;
  final List<child> _listChildDataModel = [];
  Map<int, List<child>> _childDataMap = {};

  DataGroupModel({
    required this.data,
    required this.chidlKey,
    required this.parentData,
    required this.childData,
  }) {
    _parentDataModel =
        data.map((e) => parentData(e.map as Map<String, dynamic>)).toList();
    _childDataMap = data.asMap().map((key, value) {
      final groupData = value.map;
      final items = (groupData?[chidlKey] as List<dynamic>?) ?? [];
      final List<child> childDataList = [];
      for (final element in items) {
        childDataList.add(childData(element));
        _listChildDataModel.add(childData(element));
      }
      return MapEntry(key, childDataList);
    });
  }

  /// قائمة العناصر الرئيسية (Parent models list)
  List<peren> get parentDataModel => _parentDataModel!;

  /// قائمة كافة العناصر الفرعية المجمعة (Flattened child models list)
  List<child> get listChildDataModel => _listChildDataModel;

  /// خريطة العناصر الفرعية مفهرسة بمؤشر العنصر الأب (Indexed parent-to-child map)
  Map<int, List<child>> get childDataMap => _childDataMap;
}
