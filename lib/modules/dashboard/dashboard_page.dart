import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/components/card.dart';
import 'package:glp_manager_mobile/components/notification_bell.dart';
import 'package:glp_manager_mobile/modules/dashboard/drawer.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String dropdownValue = 'Filial1';

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
            Expanded(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: const [
                  CustomCard(
                    title: "123 - teste",
                    maxWeight: 40,
                    currentWeight: 20,
                    percentage: 50,
                    date: '13/07/2022',
                  ),
                  CustomCard(
                    title: "546 - teste1",
                    maxWeight: 40,
                    currentWeight: 30,
                    percentage: 90,
                    date: '13/07/2022',
                  ),
                  CustomCard(
                    title: "466 - teste2",
                    maxWeight: 40,
                    currentWeight: 10,
                    percentage: 100,
                    date: '13/07/2022',
                  ),
                  CustomCard(
                    title: "807 - teste3",
                    maxWeight: 70,
                    currentWeight: 10,
                    percentage: 10,
                    date: '13/02/2022',
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
