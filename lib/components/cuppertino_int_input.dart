import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

class CuppertinoIntInput extends StatefulWidget {
  const CuppertinoIntInput(
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
  State<CuppertinoIntInput> createState() => _CuppertinoIntInput();
}

class _CuppertinoIntInput extends State<CuppertinoIntInput> {
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: TextEditingController()..text = widget.initialValue,
        obscureText: widget.obscureText,
        readOnly: widget.readOnly,
        onChanged: (value) => {
          widget.onChange(value.toString())
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