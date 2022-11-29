import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CuppertinoDatePicker extends StatefulWidget {
  const CuppertinoDatePicker(
      {
        Key? key,
        required this.label,
        required this.controller,
        this.readOnly = false,
      })
      : super(key: key);

      final TextEditingController controller;
      final String label;
      final bool readOnly;

  @override
  State<CuppertinoDatePicker> createState() => _CuppertinoDatePicker();
}

class _CuppertinoDatePicker extends State<CuppertinoDatePicker> {
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: TextField(
          controller: widget.controller,
          readOnly: widget.readOnly,
          decoration: InputDecoration(
            icon: const Icon(Icons.calendar_today),
            labelText: widget.label,
          ),
          onTap: () async {
            if(!widget.readOnly) {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime(2100)
              );

              if (pickedDate != null) {
                setState(() {
                  String formatedDate =  DateFormat('dd-MM-yyyy').format(pickedDate);
                  widget.controller.text = formatedDate;
                });
              } else {}
            }
          },
        )
      )
    );
  }
}