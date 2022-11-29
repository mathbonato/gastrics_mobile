import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

class CuppertinoInput extends StatefulWidget {
  const CuppertinoInput(
      {Key? key,
      required this.label,
      required this.onChange,
      this.initialValue = "",
      this.readOnly = false,
      this.obscureText = false,
      })
      : super(key: key);

  final String label;
  final String initialValue;
  final Function onChange;
  final bool readOnly;
  final bool obscureText;

  @override
  State<CuppertinoInput> createState() => _CuppertinoInput();
}

class _CuppertinoInput extends State<CuppertinoInput> {
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextFormField(
        controller: TextEditingController()..text = widget.initialValue,
        obscureText: widget.obscureText,
        readOnly: widget.readOnly,
        onChanged: (value) => {
          widget.onChange(value)
        },
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
          focusedBorder: !widget.readOnly ? OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(25.0),
          ): null,
        ),
      ),
    );
  }
}