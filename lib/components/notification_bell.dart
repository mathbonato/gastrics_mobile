import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/notifications_view/notifications_view.dart';

notificationBell() {
  return <Widget>[
    Stack(children: [
      IconButton(
        onPressed: () {
          Get.to(const NotificationsView());
        },
        icon: const Icon(Icons.notifications_none),
      ),
      Container(
        width: 7,
        height: 7,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 221, 75, 209), shape: BoxShape.circle),
        margin: const EdgeInsets.only(
          left: 27,
          top: 10,
        ),
      )
    ])
  ];
}
