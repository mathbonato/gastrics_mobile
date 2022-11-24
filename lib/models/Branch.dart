import 'package:glp_manager_mobile/models/Cylinder.dart';
import 'package:glp_manager_mobile/models/Receipt.dart';
import 'package:glp_manager_mobile/models/User.dart';

class Branch {
  String id = '';
  String name = '';
  String address = '';
  String img = '';
  List<Cylinder> cylinders = [];
  List<Receipt> canisters = [];
  List<User> users = [];

  Branch(this.id, this.name, this.address, this.cylinders);

  factory Branch.fromJson(dynamic json) {
    List<Cylinder> cylindersFromJson = [];
    json['cylinders']?.forEach((jsonCylinder) {
      var cylinderToAdd = Cylinder.fromJson(jsonCylinder);
      cylindersFromJson.add(cylinderToAdd);
    });
    return Branch(
      json['id'] as String, 
      json['name'] as String, 
      json['address'] as String, 
      cylindersFromJson
    );
  }
}
