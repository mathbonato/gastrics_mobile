class Cylinder {
  String id = '';
  String exId = '';
  String name = '';
  String gasType = '';
  String type = '';
  double weightShell = 0.0;

  Cylinder(this.id, this.exId, this.name, this.gasType,  this.type, this.weightShell);

  factory Cylinder.fromJson(dynamic json) {
    double weight = json['weightShell'] == 0 ? 0.0 : json['weightShell'];

    return Cylinder(
      json['id'] as String,
      json['exId'] as String,
      json['name'] as String, 
      json['gasType'] as String, 
      json['type'] as String, 
      weight,
    );
  }
}