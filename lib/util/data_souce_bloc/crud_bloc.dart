import '../view_data_model/base_data_model.dart';

abstract class DataSourceDataActionsBloc<T extends BaseViewDataModel>  {
  void insertData(T  data);
  void updateData(T  data, String id);
  void deleteData(String id);
  void getListData();
}