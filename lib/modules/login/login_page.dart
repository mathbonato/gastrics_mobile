import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/controllers/LoginController.dart';
import 'package:glp_manager_mobile/models/LoginResponse.dart';
import 'package:glp_manager_mobile/modules/dashboard/dashboard_page.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';
import 'package:glp_manager_mobile/models/my-globals.dart' as globals;

import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = LoginController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController alert = TextEditingController();

  onChangeEmail(String emailChanged) {
    email.text = emailChanged;
  }

  onChangePass(String passChanged) {
    pass.text = passChanged;
  }

  Future login() async {
    if(email.text == "") {
      alert.text = "Email é obrigatório !";
    }
    else if(pass.text == "") {
      alert.text = "Senha é obrigatória !";
    }
    else {
      var result = await loginController.login(email.text, pass.text);

      if(result != null) {
        setGlobals(result);
        Get.to(const DashboardPage());
        alert.text = "";
      }
      else {
        alert.text = "Email ou senha incorretos !";
      }
    }

    if (alert.text != "") {
      Fluttertoast.showToast(
        msg: alert.text,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  setGlobals(LoginResponse loginResponse) {
    globals.loginResponse = loginResponse;
    globals.employee = loginResponse.employee;
    globals.company = loginResponse.employee!.company;
    globals.token = loginResponse.token;
    globals.isOwner = loginResponse.employee!.type == "owner";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          backgroundColor: AppColors.primary, title: const Text("Gastrics")),
      body: SizedBox(
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
                    onChanged: onChangeEmail,
                  ),
                  RoundedPasswordField(
                    onChanged: onChangePass,
                  ),
                  RoundedButton(
                    text: "Login",
                    press: login,
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
