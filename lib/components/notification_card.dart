import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.alertType,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String alertType;

  @override
  State<NotificationCard> createState() => _NotificationCard();
}

class _NotificationCard extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidthSize = MediaQuery.of(context).size.width;

    const availableAlertColors = [
      Colors.red,
      Colors.orange,
      Colors.blue,
    ];

    const alertTypes = [
      'critical',
      'warning',
      'info',
    ];

    final Color colorToUse =
        availableAlertColors[alertTypes.indexOf(widget.alertType)];

    return Container(
      height: 80,
      width: screenWidthSize,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                widget.subtitle,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.warning_amber,
                color: colorToUse,
              )
            ],
          )
        ],
      ),
    );
  }
}
