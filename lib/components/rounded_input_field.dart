import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/components/text_field_container.dart';
import 'package:glp_manager_mobile/constants.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: AppColors.primary,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
