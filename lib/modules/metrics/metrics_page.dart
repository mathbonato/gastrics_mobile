import 'dart:math';

import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/components/card.dart';
import 'package:glp_manager_mobile/components/notification_bell.dart';
import 'package:glp_manager_mobile/controllers/AnalyticController.dart';
import 'package:glp_manager_mobile/controllers/BranchController.dart';
import 'package:glp_manager_mobile/models/DayDataAnalytic.dart';
import 'package:glp_manager_mobile/modules/drawer/drawer.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';
import 'package:glp_manager_mobile/models/my-globals.dart' as globals;

class MetricsPage extends StatefulWidget {
  const MetricsPage({Key? key}) : super(key: key);

  @override
  State<MetricsPage> createState() => _MetricsPage();
}

class _MetricsPage extends State<MetricsPage> {
  AnalyticController analyticsController = AnalyticController();
  BranchController branchController = BranchController();
  
  String dropdownValue = 'Filial1';

  double roundDouble(double value, int places){ 
   num mod = pow(10.0, places); 
   return ((value * mod).round().toDouble() / mod); 
}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
            backgroundColor: AppColors.primary,
            title: const Text("Gastrics"),
            actions: notificationBell()),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                isExpanded: true,
                style: const TextStyle(color: AppColors.primary),
                underline: Container(
                  height: 2,
                  color: AppColors.primary,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Filial1', 'Filial2', 'Filial3']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            FutureBuilder(
              future: analyticsController.getAnalyticsByBranch('7aa4c0a5-988d-4959-8166-9571bf20291f'),
              builder: (BuildContext context, AsyncSnapshot<List<DayDataAnalytic>> snapshot) {
                List<DayDataAnalytic> analytics= [];

                if(snapshot.hasData) {
                  analytics = snapshot.data!;
                }

                return Expanded(
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: analytics.map((DayDataAnalytic analytic) {
                      return CustomCard(
                        title: analytic.name ?? "",
                        currentWeight: roundDouble(analytic.weight, 2),
                        percentage: analytic.percentWeight.round(),
                        date: analytic.date,
                      );
                    }).toList()
                  ),
                );
              }
            ),
          ],
        ));
  }
}
