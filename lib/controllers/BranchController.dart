import 'dart:convert';

import 'package:glp_manager_mobile/config/GastricsAPiConfig.dart';
import 'package:glp_manager_mobile/models/Branch.dart';
import 'package:http/http.dart' as http;

class BranchController {
    Future<List<Branch>> getBranches(String companyId) async {
        Uri route = prepareUrl("/company/$companyId/branch");
        var response = await http.get(route);

        if (response.statusCode != 200) {
          return [];
        }

        var json = jsonDecode(response.body);

        List<Branch> branches = [];
        json?.forEach((jsonBranch) {
          var branchFromJson = Branch.fromJson(jsonBranch);
          branches.add(branchFromJson);
        });
        
        return branches;
    }

    Future<Branch?> getBranch(String companyId, String branchId) async {
      Uri route = prepareUrl("/company/$companyId/branch?id=$branchId");
      var response = await http.get(route);

      if (response.statusCode != 200) {
        return null;
      }

      var json = jsonDecode(response.body); 

      Branch newBranch = Branch.fromJson(json);

      return newBranch;
    }

    Future<Branch?> postBranch(String companyId, Branch branch) async {
      Uri route = prepareUrl("/company/$companyId/branch");
      var response = await http.post(route, body: branch);

      if (response.statusCode != 201) {
        return null;
      }

      var json = jsonDecode(response.body); 

      Branch newBranch = Branch.fromJson(json);

      return newBranch;
    }

    Future<Branch?> updateBranch(String companyId, Branch branch) async {
      Uri route = prepareUrl("/company/$companyId/branch");
      var response = await http.put(route, body: branch);

      if (response.statusCode != 200) {
        return null;
      }

      var json = jsonDecode(response.body); 

      Branch updatedBranch = Branch.fromJson(json);

      return updatedBranch;
    }

    Future<bool> deleteBranch(String companyId, Branch branch) async {
      var branchId = branch.id;

      Uri route = prepareUrl("/company/$companyId/branch?id=$branchId");
      var response = await http.delete(route);

      if (response.statusCode != 200) {
        return false;
      }

      return true;
    }
}