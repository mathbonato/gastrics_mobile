import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/constants.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = Colors.red,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton(
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
          onPressed: () => press(),
          style: ButtonStyle(
              // padding:  EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              minimumSize: MaterialStateProperty.all(const Size(400, 50)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.primary)),
        ),
      ),
    );
  }
}
