import 'dart:convert';

import 'package:glp_manager_mobile/config/GastricsAPiConfig.dart';
import 'package:glp_manager_mobile/models/DayDataAnalytic.dart';
import 'package:http/http.dart' as http;

class AnalyticController {
  Future<DayDataAnalytic?> getAnalyticByExId(String exId) async {
    Uri route = prepareUrl("/analytics/cylinder?ex_id=$exId");
    var response = await http.get(route);

    if (response.statusCode != 200) {
      return null;
    }

    var json = jsonDecode(response.body);

    var alertFromJson = DayDataAnalytic.fromJson(json);
    
    return alertFromJson;
  }

  Future<List<DayDataAnalytic>> getAnalyticsByBranch(String branchId) async {
    Uri route = prepareUrl("/analytics/branch?branch_id=$branchId");
    var response = await http.get(route);

    if (response.statusCode != 200) {
      return [];
    }

    var json = jsonDecode(response.body);

    List<DayDataAnalytic> alerts = [];
    json?.forEach((jsonBranch) {
      var alertFromJson = DayDataAnalytic.fromJson(jsonBranch);
      alertFromJson.name = jsonBranch["name"] as String;
      alertFromJson.exId = jsonBranch["exId"] as String;
      alerts.add(alertFromJson);
    });
    
    return alerts;
  }
}