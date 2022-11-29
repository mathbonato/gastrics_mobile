import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ffi';

import 'package:glp_manager_mobile/modules/branch_list/branch_list_page.dart';
import 'package:glp_manager_mobile/models/User.dart';
import 'package:glp_manager_mobile/modules/dashboard/dashboard_page.dart';
import 'package:glp_manager_mobile/modules/recipient/userController.dart';
import 'package:glp_manager_mobile/modules/login/loginController.dart';
import 'package:glp_manager_mobile/modules/metrics/metrics_page.dart';
import 'package:glp_manager_mobile/components/rounded_button.dart';
import 'package:glp_manager_mobile/components/rounded_input_field.dart';
import 'package:glp_manager_mobile/shared/themes/app_images.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glp_manager_mobile/components/notification_bell.dart';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
     
     Future<User> futureUser = new userController().getById(GetStorage().read("employeeId"));
     User user = new User();
       TextEditingController userName = TextEditingController();
       TextEditingController lastName = TextEditingController();
  TextEditingController userCpf = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPass = TextEditingController();
  TextEditingController userBirth = TextEditingController();
  

    @override
     void initState() {
    super.initState();
    
     futuretolist();
  }
    Future futuretolist() async {
   user = await futureUser;
     
    setState((){
   if(user.lastName==''){

    userName.text='';
    userCpf.text='';
    userEmail.text=GetStorage().read("email");
    userPass.text=GetStorage().read("pass");
    userBirth.text='';
    lastName.text='';

   }else{
    userName.text=user.name;
    lastName.text=user.lastName;
    userEmail.text=user.email;
    userPass.text=user.pass;
    userCpf.text=user.cpf;
    userBirth.text = user.birth;

   }
    });
    
    
  }
 
  Widget build(BuildContext context) {
    
     return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: const Text("Gastrics"),
        actions: notificationBell(),
      ),
    
      body: SingleChildScrollView(
        child:Padding(
            padding:EdgeInsets.all(20),
            
            child: Column(
              children: <Widget>[
                 const Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                    "Perfil do Usuário"
                ),

 const Padding(padding: EdgeInsets.only(top: 100)),
               Material(
                //color:AppColors.primary,
                child: TextFormField(
                  controller: userName,
                  decoration: InputDecoration(
                    labelText: "Nome do Usuário",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
                Material(
                //color:AppColors.primary,
                child: TextFormField(
                  controller: lastName,
                  decoration: InputDecoration(
                    labelText: "Sobrenome do Usuário",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
             
             
              const Padding(padding: EdgeInsets.only(top: 10)),
              Material(
                //color:AppColors.primary,
                child: TextFormField(
                  controller: userEmail,
                  decoration: InputDecoration(
                    labelText: "Email do Usuário",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Material(
                //color:AppColors.primary,
                child: TextFormField(
                  controller: userPass,
                  decoration: InputDecoration(
                    labelText: "Senha do Usuário",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
                   Material(
                //color:AppColors.primary,
                child: TextFormField(
                  controller: userBirth,
                  decoration: InputDecoration(
                    labelText: "Data de nascimento do Usuário",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Material(
                //color:AppColors.primary,
                child: ElevatedButton(
                  child: const Text(
                    "Salvar",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{

                    

                    
                      User user = User();
                      user.name = userName.text;
                      user.lastName = lastName.text;
                      user.cpf = userCpf.text;
                      user.email = userEmail.text;
                      user.pass = userPass.text;
                      String data = userBirth.text;
                      var splitdata =data.split('/');
                      user.birth = splitdata[2]+'-'+splitdata[1]+'-'+splitdata[0];
                       
                      
                      await new userController().updateUser(user);
                    futureUser =new userController().getById(GetStorage().read("employeeId"));
                      

                      userName.text = "";
                      userCpf.text = "";
                      userEmail.text = "";
                      userPass.text = "";
                      userBirth.text = "";
                    futuretolist();
                    
                  },
                  style: ButtonStyle(
                      // padding:  EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppColors.primary)),
                ),
              ),
              ],
            ),),
          )
    );
  }
}
