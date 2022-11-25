import 'package:glp_manager_mobile/models/Employee.dart';

class LoginResponse {
  Employee? employee;
  String token = '';

  LoginResponse(this.employee, this.token);

  factory LoginResponse.fromJson(dynamic json) {
    Employee employee = Employee.fromJson(json['employee']);
    
    return LoginResponse(
      employee,
      json['token'] as String
    );
  }
}