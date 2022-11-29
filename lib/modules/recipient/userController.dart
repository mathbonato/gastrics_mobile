import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:glp_manager_mobile/models/User.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class userController{


  Future<List<User>> getUsers() async{
      var url =Uri.http('localhost:3000','gastrics/api/company/${GetStorage().read("companyId")}/employee');

  
  List<User>users=[];
  
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) ;
    
    for(var ret in jsonResponse){
      print(ret);
        User user = new User();
        user.id = ret['id'];
          user.name = ret['name'];
    user.email = ret['email'];
    user.cpf =ret['cpf'];
    user.type =ret['type'];
         users.add(user);
        
    }
    //print(jsonResponse);
    return users;
    
  } else {
    print('Request failed with status: ${response.statusCode}.');
    print(response.body);
   
  }
return users;
  }

  Future<User> getById(String id) async{
      var url =Uri.http('localhost:3000','gastrics/api/company/${GetStorage().read("companyId")}/employee' ,{'id': GetStorage().read("employeeId")});

  User user = new User();
  
  
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var ret = convert.jsonDecode(response.body) ;
    
    
      print(ret);
        
        user.id = ret['id'];
        user.lastName = ret['lastName'];
        user.pass = ret['pass'];
        user.birth = ret['birth'];
          user.name = ret['name'];
    user.email = ret['email'];
    user.cpf =ret['cpf'];
    user.type =ret['type'];
         
        
    
    //print(jsonResponse);
    return user;
    
  } else {
    print('Request failed with status: ${response.statusCode}.');
    print(response.body);
   
  }
return user;
  }

   Future createUser(User user ) async{
      var url =Uri.http('localhost:3000','gastrics/api/company/${GetStorage().read("companyId")}/employee');

  
  var body = {
    'name':user.name,
    'lastName':'',
     'type':'employee',
     'birth':user.birth,
     'cpf':user.cpf,
     'email':user.email,
     'pass':user.pass
    

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
    Future updateUser(User user) async{
      var url =Uri.http('localhost:3000','gastrics/api/company/${GetStorage().read("companyId")}/employee' , {'companyId':GetStorage().read("companyId")});

  
  var body = {
    'id':GetStorage().read("employeeId"),
 'name':user.name,
    'lastName':user.lastName,
     'type':'employee',
     'birth':user.birth,
     'cpf':user.cpf,
     'email':user.email,
     'pass':user.pass

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
   Future deleteUser(User user) async{
      var url =Uri.http('localhost:3000','gastrics/api/company/${GetStorage().read("companyId")}/employee' , {'companyId':GetStorage().read("companyId"),'id':user.id});

 
  
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