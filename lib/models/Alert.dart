class Alert {
  String id ;
  String name;
  String type;
  String status;
  String cylinderExId;

  Alert(this.id, this.name, this.type, this.status, this.cylinderExId);

  factory Alert.fromJson(dynamic json) {
    return Alert(
      json["id"] as String,
      json["name"] as String,
      json["type"] as String,
      json["status"] as String,
      json["cylinderExId"] as String,
    );
  }
}