import 'package:glp_manager_mobile/models/Employee.dart';
import 'package:glp_manager_mobile/models/LoginEmployee.dart';

class LoginResponse {
  LoginEmployee? employee;
  String token = '';

  LoginResponse(this.employee, this.token);

  factory LoginResponse.fromJson(dynamic json) {
    LoginEmployee employee = LoginEmployee.fromJson(json['employee']);
    
    return LoginResponse(
      employee,
      json['token'] as String
    );
  }
}