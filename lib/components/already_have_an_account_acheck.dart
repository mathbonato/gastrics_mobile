import 'package:flutter/material.dart';
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
          onTap: () => {},
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
