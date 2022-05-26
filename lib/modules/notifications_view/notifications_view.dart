import 'dart:math';

import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/components/notification_card.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  Widget build(BuildContext context) {
    const alertTypes = [
      'critical',
      'warning',
      'info',
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: const Text("Notificações"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return NotificationCard(
                  title: 'Alerta - Troca de Gás',
                  subtitle: 'Filial / Botijão da cozinha',
                  indicatorVal: Random().nextInt(5),
                  indicatorDescription: 'Dias',
                  alertType: alertTypes[Random().nextInt(2)],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
            ),
          )
        ],
      ),
    );
  }
}
