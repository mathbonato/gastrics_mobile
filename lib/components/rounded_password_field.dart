import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/components/text_field_container.dart';
import 'package:glp_manager_mobile/constants.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final bool obscureText;

  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    this.obscureText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: obscureText,
        onChanged: onChanged,
        cursorColor: AppColors.primary,
        decoration: const InputDecoration(
          hintText: "Senha",
          icon: Icon(
            Icons.lock,
            color: AppColors.primary,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: AppColors.primary,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
