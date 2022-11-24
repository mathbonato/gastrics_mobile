import 'dart:convert';

import 'package:glp_manager_mobile/config/GastricsAPiConfig.dart';
import 'package:glp_manager_mobile/models/LoginResponse.dart';

import 'package:http/http.dart' as http;

class LoginController {
  Future<LoginResponse?> login(String email, String pass) async {
    Uri route = prepareUrl("/login");
    var response = await http.post(route, body: {
      email, pass,
    });

    if (response.statusCode != 200) {
      return null;
    }

    var json = jsonDecode(response.body);
    LoginResponse loginResponse = LoginResponse.fromJson(json);

    return loginResponse;
  }
}