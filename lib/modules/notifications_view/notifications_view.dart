import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/components/notification_card.dart';
import 'package:glp_manager_mobile/controllers/AlertController.dart';
import 'package:glp_manager_mobile/models/Alert.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';
import 'package:glp_manager_mobile/models/my-globals.dart' as globals;

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final AlertController alertController = AlertController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: const Text("Notificações"),
      ),
      body: FutureBuilder(
        future: alertController.getAlerts(globals.company!.id),
      builder: (BuildContext context, AsyncSnapshot<List<Alert>> snapshot) {
          List<Alert> alerts = [];

          if (snapshot.hasData) {
            alerts = snapshot.data!;
          }

          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemCount: alerts.length,
                  itemBuilder: (BuildContext context, int index) {
                    Alert alert = alerts[index];

                    return NotificationCard(
                      title: alert.type,
                      subtitle: alert.name,
                      alertType: alert.status,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10);
                  },
                ),
              )
            ],
          );
        },
      )
    );
  }
}
