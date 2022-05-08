import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/shared/themes/app_images.dart';
import 'package:glp_manager_mobile/shared/themes/app_text_styles.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  const SocialLoginButton({ Key? key, required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height:  50,
        decoration: BoxDecoration(
          color: AppColors.shape,
          borderRadius: BorderRadius.circular(5),
          border: const Border.fromBorderSide(BorderSide(color: Color.fromARGB(255, 167, 166, 166))),
      ),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.google),
                    SizedBox(width: 16,),
                    Container(height: 56, width: 1, color: Color.fromARGB(255, 167, 166, 166),)
                  ],
                )
            ),
            Expanded(
                flex: 4,
                child: Text("Entrar com Google", style: TextStyles.buttonGray,)
              )
          ],
        ),
      ),
    );
  }
}