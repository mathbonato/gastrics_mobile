import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:glp_manager_mobile/models/User.dart';
import 'package:get_storage/get_storage.dart';

class loginController{
  
  
User user = new User();
Future login(String email,String pass) async {
  
  var url =
      Uri.http('localhost:3000','gastrics/api/login/');

  
  var body = {
    'email': email,
    'pass':pass
  };
  
  var response = await http.post(url,
    headers:{"Content-type": "application/json"},
  
    body:convert.jsonEncode(body) );
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    
    
    
    user.name = jsonResponse['employee']['name'];
    user.id = jsonResponse['employee']['id'];
    user.lastName = jsonResponse['employee']['lastName'];
    user.email = jsonResponse['employee']['email'];
    user.cpf =jsonResponse['employee']['cpf'];
    user.pass= pass;
    
    user.companyId = jsonResponse['employee']['company']['id'];
    user.type =jsonResponse['employee']['type'];
    GetStorage().write('employeeId',user.id);
    GetStorage().write('companyId',user.companyId);
    GetStorage().write('name',user.name);
    GetStorage().write('lastName',user.lastName);
    GetStorage().write('cpf',user.cpf);
    GetStorage().write('pass',user.pass);
    GetStorage().write('email',user.email);
    GetStorage().write('Logged','on');
  } else {
    print('Request failed with status: ${response.statusCode}.');
    print(response.body);
    user = new User();
  }
  
}
   Future createUser(String email,String pass, String name, String cnpj) async{
      var url =Uri.http('localhost:3000','gastrics/api/company');

  
  var body = {
    'name':name,
    'cnpj':cnpj
  };
  
  var response = await http.post(url,
   headers:{"Content-type": "application/json"},body:convert.jsonEncode(body));
  if (response.statusCode == 200) {
    var resp = convert.jsonDecode(response.body);
     print(resp['id']);
    GetStorage().write('companyId',resp['id']);
      
        var url2 =Uri.http('localhost:3000','/gastrics/api/company/${GetStorage().read('companyId')}/employee');
      
        var user = {
          'name': 'a',
          'lastName': '',
          'type':'owner',
          'birth':"2001-05-23",
          'cpf':'1',
          'company':GetStorage().read('companyId'),

          'email':email,
          'pass':pass,
          

          
          
        };
          var userR = await http.post(url2,
   headers:{"Content-type": "application/json"},body:convert.jsonEncode(user));
   
   if(userR.statusCode == 200){
    print(convert.jsonDecode(userR.body));
    var udecode = convert.jsonDecode(userR.body);
    GetStorage().write('email',email);
    GetStorage().write('pass',pass);
    GetStorage().write('employeeId',udecode['id']);
    GetStorage().write('lastName','');
    GetStorage().write('name','');
    GetStorage().write('Logged','on');
 return userR.statusCode;
   }else{
     print('Request failed with status: ${response.statusCode}.');
    print(userR.body);
    return userR.statusCode;
   }
    
    
   
    
  } else {
    print('Request failed with status: ${response.statusCode}.');
    print(response.body);
    return response.statusCode;
   
  }
return response.statusCode;
  }
}