import 'dart:convert';

import 'package:glp_manager_mobile/config/GastricsAPiConfig.dart';
import 'package:glp_manager_mobile/models/Employee.dart';
import 'package:http/http.dart' as http;

class EmployeeController {
    Future<List<Employee>> getEmployees(String companyId) async {
        Uri route = prepareUrl("/company/$companyId/employee");
        var response = await http.get(route);

        if (response.statusCode != 200) {
          return [];
        }

        var json = jsonDecode(response.body);

        List<Employee> employees = [];
        json?.forEach((jsonEmployee) {
          var employeeFromJson = Employee.fromJson(jsonEmployee);
          employees.add(employeeFromJson);
        });
        
        return employees;
    }

    Future<Employee?> getEmployee(String companyId, String employeeId) async {
      Uri route = prepareUrl("/company/$companyId/employee?id=$employeeId");
      var response = await http.get(route);

      if (response.statusCode != 200) {
        return null;
      }

      var json = jsonDecode(response.body); 

      Employee newEmployee = Employee.fromJson(json);

      return newEmployee;
    }

    Future<Employee?> postEmployee(String companyId, Employee employee) async {
      Uri route = prepareUrl("/company/$companyId/employee");
      var response = await http.post(route, body: employee);

      if (response.statusCode != 201) {
        return null;
      }

      var json = jsonDecode(response.body); 

      Employee newEmployee = Employee.fromJson(json);

      return newEmployee;
    }

    Future<Employee?> updateEmployee(String companyId, Employee employee) async {
      Uri route = prepareUrl("/company/$companyId/employee");
      var response = await http.put(route, body: employee);

      if (response.statusCode != 200) {
        return null;
      }

      var json = jsonDecode(response.body); 

      Employee updatedEmployee = Employee.fromJson(json);

      return updatedEmployee;
    }

    Future<bool> deleteEmployee(String companyId, Employee employee) async {
      var employeeId = employee.id;

      Uri route = prepareUrl("/company/$companyId/employee?id=$employeeId");
      var response = await http.delete(route);

      if (response.statusCode != 200) {
        return false;
      }

      return true;
    }
}