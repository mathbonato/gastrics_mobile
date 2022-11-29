import 'dart:convert';

import 'package:glp_manager_mobile/config/GastricsAPiConfig.dart';
import 'package:glp_manager_mobile/models/Alert.dart';
import 'package:http/http.dart' as http;

class AlertController {
  Future<List<Alert>> getAlerts(String companyId) async {
        Uri route = prepareUrl("/company/$companyId/alert");
        var response = await http.get(route);

        if (response.statusCode != 200) {
          return [];
        }

        var json = jsonDecode(response.body);

        List<Alert> alerts = [];
        json?.forEach((jsonBranch) {
          var alertFromJson = Alert.fromJson(jsonBranch);
          alerts.add(alertFromJson);
        });
        
        return alerts;
    }
}