abstract class BaseModel {
  late int id;
  
  Map<String, dynamic> serializeToJson();
  BaseModel deserializeJson(Map<String, dynamic> json);
}

