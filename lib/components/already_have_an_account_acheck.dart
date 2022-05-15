import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/modules/singup/singup_page.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Ainda não tem uma conta? ",
          style: TextStyle(color: AppColors.primary),
        ),
        GestureDetector(
          onTap: () => Get.to(SingUpPage()),
          child: const Text(
            "Cadastre-se.",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
