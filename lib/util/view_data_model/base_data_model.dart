class BaseViewDataModel{

  String? id ;
  // create to json method and factory forJson
  Map<String, dynamic> toJson(){return {} ; }

  BaseViewDataModel(String ?id  ){
    this.id = id;
  }
  factory BaseViewDataModel.fromJson(Map<String, dynamic> json , String? id ) {

    return BaseViewDataModel(id  )
      .. map = json;

  }
  Map<String, dynamic>?  map = Map();

}