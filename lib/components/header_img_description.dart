import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

class HeaderImgDescription extends StatefulWidget {
  const HeaderImgDescription({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.img,
    this.iconOneRef,
    this.iconTwoRef,
    this.iconOneName = '',
    this.iconTwoName = '',
    this.iconOne = false,
    this.iconTwo = false,
    this.iconOneAction,
    this.iconTwoAction,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String img;
  final String iconOneName;
  final String iconTwoName;
  final bool iconOne;
  final bool iconTwo;
  final Function? iconOneAction;
  final Function? iconTwoAction;
  final IconData? iconOneRef;
  final IconData? iconTwoRef;

  @override
  State<HeaderImgDescription> createState() => _HeaderImgDescription();
}

class _HeaderImgDescription extends State<HeaderImgDescription> {
  @override
  Widget build(BuildContext context) {
    var selectedIconOne = true;
    var selectedIconTwo = false;

    handleIconOneClick() {
      selectedIconOne = !selectedIconOne;
      selectedIconTwo = !selectedIconTwo;
      // widget.iconOneAction!();
    }

    handleIconTwoClick() {
      selectedIconTwo = !selectedIconTwo;
      selectedIconOne = !selectedIconOne;
      // widget.iconTwoAction!();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          minRadius: 65,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: NetworkImage(widget.img),
        ),
        Expanded(
          child: Center(
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.title.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      widget.subtitle,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    widget.iconOne
                        ? Column(
                            children: <Widget>[
                              IconButton(
                                onPressed: () => handleIconOneClick(),
                                icon: Icon(
                                  widget.iconOneRef,
                                  color: selectedIconOne
                                      ? AppColors.primary
                                      : AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                widget.iconOneName,
                                style: TextStyle(
                                  color: selectedIconOne
                                      ? AppColors.primary
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    widget.iconTwo
                        ? Column(
                            children: <Widget>[
                              IconButton(
                                onPressed: () => handleIconTwoClick(),
                                icon: Icon(
                                  widget.iconTwoRef,
                                  color: selectedIconTwo
                                      ? AppColors.primary
                                      : AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                widget.iconTwoName,
                                style: TextStyle(
                                  color: selectedIconTwo
                                      ? AppColors.primary
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
