import 'dart:convert';

import 'package:glp_manager_mobile/config/GastricsAPiConfig.dart';
import 'package:glp_manager_mobile/models/Cylinder.dart';
import 'package:http/http.dart' as http;

class CylinderController {
    Future<List<Cylinder>> getCylinders(String companyId, String branchId) async {
        Uri route = prepareUrl("/company/$companyId/branch/$branchId/cylinder");
        var response = await http.get(route);

        if (response.statusCode != 200) {
          return [];
        }

        var json = jsonDecode(response.body);

        List<Cylinder> cylinders = [];
        json?.forEach((jsonCylinder) {
          var cylinderFromJson = Cylinder.fromJson(jsonCylinder);
          cylinders.add(cylinderFromJson);
        });
        
        return cylinders;
    }

    Future<Cylinder?> getCylinder(String companyId, String branchId, String cylinderId) async {
      Uri route = prepareUrl("/company/$companyId/branch/$branchId/cylinder?id=$cylinderId");
      var response = await http.get(route);

      if (response.statusCode != 200) {
        return null;
      }

      var json = jsonDecode(response.body); 

      Cylinder newCylinder = Cylinder.fromJson(json);

      return newCylinder;
    }

    Future<Cylinder?> postCylinder(String companyId, String branchId, Cylinder cylinder) async {
      Map cylinderData = {
        'exId': cylinder.exId,
        'name': cylinder.name,
        'gasType': cylinder.gasType,
        'type': cylinder.type,
      };
      var bodyData = jsonEncode(cylinderData);

      Uri route = prepareUrl("/company/$companyId/branch/$branchId/cylinder");

      var response = await http.post(
        route,
        body: bodyData,
        headers: {"Content-Type": "application/json"}
      );

      if (response.statusCode != 201) {
        return null;
      }

      var json = jsonDecode(response.body); 

      Cylinder newCylinder = Cylinder.fromJson(json);

      return newCylinder;
    }

    Future<Cylinder?> updateCylinder(String companyId, String branchId, Cylinder cylinder) async {
      Map cylinderData = {
        'id': cylinder.id,
        'exId': cylinder.exId,
        'name': cylinder.name,
        'gasType': cylinder.gasType,
        'type': cylinder.type,
      };
      var bodyData = jsonEncode(cylinderData);

      Uri route = prepareUrl("/company/$companyId/branch/$branchId/cylinder");
      
      var response = await http.put(
        route,
        body: bodyData,
        headers: {"Content-Type": "application/json"}
      );

      if (response.statusCode != 200) {
        return null;
      }

      var json = jsonDecode(response.body); 

      Cylinder updatedCylinder = Cylinder.fromJson(json);

      return updatedCylinder;
    }

    Future<bool> deleteCylinder(String companyId, String branchId, Cylinder cylinder) async {
      var cylinderId = cylinder.id;

      Uri route = prepareUrl("/company/$companyId/branch/$branchId/cylinder?id=$cylinderId");
      var response = await http.delete(route);

      if (response.statusCode != 200) {
        return false;
      }

      return true;
    }
}