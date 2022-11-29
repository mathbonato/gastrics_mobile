class Cylinder {
  String id = '';
  String exId = '';
  String name = '';
  String gasType = '';
  String type = '';
  double weightShell = 0.0;
  double maxWeight = 0.0;
  int alertWhen = 0;

  Cylinder(this.id, this.exId, this.name, this.gasType,  this.type, this.weightShell, this.maxWeight, this.alertWhen);

  factory Cylinder.fromJson(dynamic json) {
    double weight = json['weightShell'] + .0;
    double maxWeight = json['maxWeight'] + .0;
    int alertWhen = json['alertWhen'] == null ? 0 : json['alertWhen'] as int;

    return Cylinder(
      json['id'] as String,
      json['exId'] as String,
      json['name'] as String, 
      json['gasType'] as String, 
      json['type'] as String, 
      weight,
      maxWeight,
      alertWhen,
    );
  }
}