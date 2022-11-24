import 'package:glp_manager_mobile/models/Company.dart';
import 'package:glp_manager_mobile/models/Employee.dart';

class LoginEmployee extends Employee {
  Company? company;

  LoginEmployee(String id, String name, String lastName, String type, DateTime birth, String cpf, String email, this.company) : super(id, name, lastName, type, birth, cpf, email);

  factory LoginEmployee.fromJson(dynamic json) {
    Company company = Company.fromJson(json['company']);

    return LoginEmployee(
      json['id'],
      json['name'],
      json['lastName'],
      json['type'],
      json['birth'],
      json['cpf'],
      json['email'],
      company
    );
  }
}