import 'package:JoDija_view/util/view_data_model/base_data_model.dart';

class DataGroupModel<peren extends BaseViewDataModel , child extends BaseViewDataModel>{
  List<BaseViewDataModel> data ;
  String chidlKey;
  peren Function(Map<String, dynamic> data) parentData;
   child  Function(Map<String, dynamic> data) childData;
 List< peren> ? _parentDataModel ;
  List <child> ? _listChildDataModel= [] ;
Map<int  , List <child>> _childDataMap = {};
  // constructor
  DataGroupModel({required this.data , required this.chidlKey,
  required this. parentData,
  required this .  childData
  }){
    _parentDataModel = data.map((e) => parentData(e.map as Map<String, dynamic>)).toList();
    _childDataMap =  data.asMap().map((key, value) {
      final groupData = value.map as Map<String, dynamic>;
      final items = groupData['${chidlKey}']??[] as List<dynamic>;
      final List<child>   childDataList = [];
      // add to childDataList useing for each loop
      items.forEach((element) {
        childDataList.add(childData(element));
        _listChildDataModel!.add(childData(element));
      });
      return MapEntry(key, childDataList);
    });

  }
  List<peren> get parentDataModel => _parentDataModel!;
  List<child> get listChildDataModel => _listChildDataModel!;
  Map<int  , List <child>> get childDataMap => _childDataMap;
}