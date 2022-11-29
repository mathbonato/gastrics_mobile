import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:glp_manager_mobile/models/Branch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class branchController{


  Future<List<Branch>> getBranches() async{
      var url =Uri.http('localhost:3000','gastrics/api/company/${GetStorage().read("companyId")}/branch');

  
  List<Branch>branches=[];
  
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) ;
    
    for(var ret in jsonResponse){
        Branch branch = new Branch();
        branch.name =ret['name'];
        branch.id =ret['id'];
        branch.street =ret['address'];
        branches.add(branch);
        
    }
    //print(jsonResponse);
    return branches;
    
  } else {
    print('Request failed with status: ${response.statusCode}.');
    print(response.body);
   
  }
return branches;
  }


   Future createBranch(Branch branch) async{
      var url =Uri.http('localhost:3000','gastrics/api/company/${GetStorage().read("companyId")}/branch');

  
  var body = {
    'name':branch.name,
    'address':branch.street,
    'cylinders':[],
    'company':GetStorage().read("companyId")

  };
  
  var response = await http.post(url,
   headers:{"Content-type": "application/json"},body:convert.jsonEncode(body));
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) ;
    
  
    //print(jsonResponse);
    return response.statusCode;
    
  } else {
    print('Request failed with status: ${response.statusCode}.');
    print(response.body);
   
  }
return response.statusCode;
  }
    Future updateBranch(Branch branch) async{
      var url =Uri.http('localhost:3000','gastrics/api/company/${GetStorage().read("companyId")}/branch' , {'companyId':'98e61aed-4584-42f0-a59d-f873fda64170'});

  
  var body = {
    'id':branch.id,
    'name':branch.name,
    'address':branch.street,
    'company':GetStorage().read("companyId")

  };
  
  var response = await http.put(url,
   headers:{"Content-type": "application/json"},body:convert.jsonEncode(body));
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) ;
    
  
    //print(jsonResponse);
    return response.statusCode;
    
  } else {
    print('Request failed with status: ${response.statusCode}.');
    print(response.body);
   
  }
return response.statusCode;
  }
}