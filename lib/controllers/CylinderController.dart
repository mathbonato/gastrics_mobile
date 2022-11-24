import 'dart:convert';

import 'package:glp_manager_mobile/config/GastricsAPiConfig.dart';
import 'package:glp_manager_mobile/models/Cylinder.dart';
import 'package:http/http.dart' as http;

class CylinderController {
    Future<List<Cylinder>> getCylinders(String companyId, String branchId) async {
        Uri route = prepareUrl("/$companyId/branch/$branchId/cylinder");
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
      Uri route = prepareUrl("/$companyId/branch/$branchId/cylinder?id=$cylinderId");
      var response = await http.get(route);

      if (response.statusCode != 200) {
        return null;
      }

      var json = jsonDecode(response.body); 

      Cylinder newCylinder = Cylinder.fromJson(json);

      return newCylinder;
    }

    Future<Cylinder?> postCylinder(String companyId, String branchId, Cylinder cylinder) async {
      Uri route = prepareUrl("/$companyId/branch/$branchId/cylinder");
      var response = await http.post(route, body: cylinder);

      if (response.statusCode != 201) {
        return null;
      }

      var json = jsonDecode(response.body); 

      Cylinder newCylinder = Cylinder.fromJson(json);

      return newCylinder;
    }

    Future<Cylinder?> updateCylinder(String companyId, String branchId, Cylinder cylinder) async {
      Uri route = prepareUrl("/$companyId/branch/$branchId/cylinder");
      var response = await http.put(route, body: cylinder);

      if (response.statusCode != 200) {
        return null;
      }

      var json = jsonDecode(response.body); 

      Cylinder updatedCylinder = Cylinder.fromJson(json);

      return updatedCylinder;
    }

    Future<bool> deleteCylinder(String companyId, String branchId, Cylinder cylinder) async {
      var cylinderId = cylinder.id;

      Uri route = prepareUrl("/$companyId/branch/$branchId/cylinder?id=$cylinderId");
      var response = await http.delete(route);

      if (response.statusCode != 200) {
        return false;
      }

      return true;
    }
}