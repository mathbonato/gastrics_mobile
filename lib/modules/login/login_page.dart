import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/modules/dashboard/dashboard_page.dart';
import 'package:glp_manager_mobile/modules/user_page/user_page.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';
import 'loginController.dart';

import '../../components/already_have_an_account_acheck.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget  {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>  {
    String email="";
    String pass = "";
    loginController controller = new loginController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          backgroundColor: AppColors.primary, title: const Text("Gastrics")),
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
                  const Text(
                    "LOGIN",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    hintText: "Email",
                    onChanged: (value) {
                      email=value;
                    },
                  ),
                  RoundedPasswordField(
                    onChanged: (value) {
                      pass=value;
                    },
                  ),
                  RoundedButton(
                    text: "LOGIN",
                    press: () async{
                      
                     await controller.login(email,pass);
                      if(controller.user.cpf!=''){
                       if( controller.user.lastName==''){
                        Get.to(DashboardPage());
                        Get.to(UserPage());
                       }else{
                        Get.to(DashboardPage());}
                        }
                      else{
                        print("errado");
                      }
                      
                      
                      },
                  ),
                  //   SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
