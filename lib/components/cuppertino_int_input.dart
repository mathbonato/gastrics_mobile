import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

class CuppertinoIntInput extends StatefulWidget {
  const CuppertinoIntInput(
      {Key? key,
      required this.label,
      required this.onChange,
      this.initialValue = "",
      })
      : super(key: key);

  final String label;
  final String initialValue;
  final Function onChange;

  @override
  State<CuppertinoIntInput> createState() => _CuppertinoIntInput();
}

class _CuppertinoIntInput extends State<CuppertinoIntInput> {
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextFormField(
        keyboardType: TextInputType.number,
        initialValue: widget.initialValue,
        onChanged: (value) => {
          widget.onChange(value.toString())
        },
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}