import 'package:glp_manager_mobile/models/Company.dart';
import 'package:glp_manager_mobile/models/Employee.dart';

class LoginEmployee extends Employee {
  Company? company;

  LoginEmployee(String id, String name, String lastName, String type, DateTime birth, String cpf, String email, this.company) : super(id, name, lastName, type, birth, cpf, email);

  factory LoginEmployee.fromJson(dynamic json) {
    Company company = Company.fromJson(json['company']);
    DateTime birth = DateTime.parse(json['birth']);

    return LoginEmployee(
      json['id'] as String,
      json['name'] as String,
      json['lastName'] as String,
      json['type'] as String,
      birth,
      json['cpf'] as String,
      json['email'] as String,
      company
    );
  }
}