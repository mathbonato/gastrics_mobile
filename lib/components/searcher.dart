import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

class Searcher extends StatefulWidget {
  const Searcher({
    Key? key,
    required this.title,
    required this.pleaceHolder,
    this.onChange,
  }) : super(key: key);

  final String title;
  final String pleaceHolder;
  final Function? onChange;

  @override
  State<Searcher> createState() => _Searcher();
}

class _Searcher extends State<Searcher> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColors.textSecondary, width: 2),
          borderRadius: BorderRadius.circular(100),
        ),
        labelText: widget.pleaceHolder + '...',
      ),
    );
  }
}
