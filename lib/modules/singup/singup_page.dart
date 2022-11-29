// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/modules/dashboard/dashboard_page.dart';
import 'package:glp_manager_mobile/modules/user_page/user_page.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';
import 'package:glp_manager_mobile/modules/login/loginController.dart';
import 'package:http/http.dart' as http;

import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({Key? key}) : super(key: key);

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  String name ='';
  String cnpj='';
  String email ='';
  String pass ='';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar:
          AppBar(backgroundColor: AppColors.primary, title: Text("Gastrics")),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Criar conta",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    hintText: "Nome da empresa",
                    icon: Icons.business,
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  RoundedInputField(
                    hintText: "E-mail",
                    icon: Icons.mail,
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  RoundedInputField(
                    hintText: "CNPJ",
                    icon: Icons.person,
                    onChanged: (value) {
                      cnpj = value;
                    },
                  ),
                  RoundedPasswordField(
                    onChanged: (value) {
                      pass= value;
                    },
                  ),
                  RoundedButton(
                    text: "Cadastrar",
                    press: () async{
                    if(await  new loginController().createUser(email,pass,name,cnpj ) ==200){
                      print("tudo certo");
                      Get.to(DashboardPage());
                      Get.to(UserPage());
                    }else{
                      print("algo errado");
                    }
                      
                      
                      
                      
                       },
                  ),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
