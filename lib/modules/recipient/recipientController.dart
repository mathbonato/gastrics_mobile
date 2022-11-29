import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:glp_manager_mobile/models/Receipt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class recipientController{


  Future<List<Receipt>> getRecipient(String branchId) async{
      var url =Uri.http('localhost:3000','gastrics/api/company/${GetStorage().read("companyId")}/branch/${branchId}/cylinder');

  
  List<Receipt>receipts=[];
  
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) ;
    
    for(var ret in jsonResponse){
      print(ret['id']);
        Receipt receipt = new Receipt();
         receipt.name =ret['name'];
         receipt.gasType =ret['gasType'];
         receipt.type =ret['type'];
         receipt.id = ret['id'];
         receipt.actualWeight = double.parse(ret['weightActual']==null?'0':ret['weightActual']);
         receipt.gasHullWeight = double.parse(ret['weightShell'].toString());
         receipts.add(receipt);
        
    }
    //print(jsonResponse);
    return receipts;
    
  } else {
    print('Request failed with status: ${response.statusCode}.');
    print(response.body);
   
  }
return receipts;
  }


   Future createRecipient(Receipt receipt , String branchId) async{
      var url =Uri.http('localhost:3000','gastrics/api/company/${GetStorage().read("companyId")}/branch/${branchId}/cylinder');

  
  var body = {
    'name':receipt.name,
    'exId':new DateTime.now().microsecondsSinceEpoch,
    'gasType':receipt.gasType,
    'type':receipt.type
    

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
    Future updateRecipient(Receipt receipt,String branchId) async{
      var url =Uri.http('localhost:3000','gastrics/api/company/${GetStorage().read("companyId")}/branch/${branchId}/cylinder' , {'companyId':GetStorage().read("companyId"),'branchId':branchId});

  print(receipt.id);
  var body = {
    'id':receipt.id,
   'name':receipt.name,
    'gasType':receipt.gasType,
    'type':receipt.type

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
   Future deleteRecipient(Receipt receipt,String branchId) async{
      var url =Uri.http('localhost:3000','gastrics/api/company/${GetStorage().read("companyId")}/branch/${branchId}/cylinder' , {'companyId':GetStorage().read("companyId"),'branchId':branchId,'id':receipt.id});

 
  
  var response = await http.delete(url,
   headers:{"Content-type": "application/json"});
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