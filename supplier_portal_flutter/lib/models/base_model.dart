abstract class BaseModel {
  late int id;
  
  Map<String, dynamic> serializeToJson();
  void deserializeJson(Map<String, dynamic> json);
}

