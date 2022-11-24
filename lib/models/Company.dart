import 'package:glp_manager_mobile/models/Branch.dart';
import 'package:glp_manager_mobile/models/Employee.dart';

class Company {
  String id = '';
  String name = '';
  String cnpj = '';
  List<Branch> branches = [];
  List<Employee> employees = [];

  Company(this.id, this.name, this.cnpj, this.branches, this.employees);

  factory Company.fromJson(dynamic json) {
    const List<Employee> employees = [];
    const List<Branch> branches = [];

    json['branches']?.forEach((jsonBranch) {
      var branchFromJson = Branch.fromJson(jsonBranch);
      branches.add(branchFromJson);
    });

    json['employees']?.forEach((jsonEmployee) {
      var employeeFromJson = Employee.fromJson(jsonEmployee);
      employees.add(employeeFromJson);
    });

    return Company(
      json['id'] as String,
      json['name'] as String,
      json['cnpj'] as String,
      branches,
      employees,
    );
  }
}