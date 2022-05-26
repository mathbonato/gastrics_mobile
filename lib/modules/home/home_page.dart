import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/components/rounded_button.dart';
import 'package:glp_manager_mobile/modules/login/login_page.dart';
import 'package:glp_manager_mobile/modules/singup/singup_page.dart';
import 'package:glp_manager_mobile/shared/themes/app_images.dart';
import 'package:glp_manager_mobile/shared/themes/app_text_styles.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.3,
              color: AppColors.primary,
            ),
            Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Image.asset(
                  AppImages.person,
                  width: 500,
                  height: 373,
                )),
            Positioned(
              bottom: size.height * 0.20,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //   Image.asset(AppImages.logomini),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 60, right: 60, bottom: 20),
                    child: Text(
                      "Gerêncie o consumo de gás da sua empresa em um só lugar.",
                      style: TextStyles.titleHome,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  RoundedButton(
                    text: "Entrar",
                    press: () => Get.to(LoginPage()),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      primary: AppColors.primary,
                    ),
                    onPressed: () => Get.to(SingUpPage()),
                    child: const Text('Cadastrar empresa'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
