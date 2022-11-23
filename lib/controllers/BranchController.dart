import 'dart:convert';

import 'package:glp_manager_mobile/config/GastricsAPiConfig.dart';
import 'package:glp_manager_mobile/models/Branch.dart';
import 'package:http/http.dart' as http;

class BranchController {
    Future<List<Branch>> getBranches(String companyId) async {
        Uri route = prepareUrl("/$companyId/branch");
        var response = await http.get(route);
        var json = jsonDecode(response.body);

        List<Branch> branches = [];
        json?.forEach((jsonBranch) {
          var branchFromJson = Branch.fromJson(jsonBranch);
          branches.add(branchFromJson);
        });
        
        return branches;
    }
}