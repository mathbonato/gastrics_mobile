import 'dart:math';

import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/components/card.dart';
import 'package:glp_manager_mobile/components/notification_bell.dart';
import 'package:glp_manager_mobile/controllers/AnalyticController.dart';
import 'package:glp_manager_mobile/controllers/BranchController.dart';
import 'package:glp_manager_mobile/models/Branch.dart';
import 'package:glp_manager_mobile/models/DayDataAnalytic.dart';
import 'package:glp_manager_mobile/modules/drawer/drawer.dart';
import 'package:glp_manager_mobile/modules/metrics/cards_list/cards_list.dart';
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
  TextEditingController selectedBranchId = TextEditingController();
  Branch? _selectedBranch;
  List<Branch> _branches = [];
  
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
            FutureBuilder(
              future: branchController.getBranches(globals.company!.id),
              builder: (BuildContext context, AsyncSnapshot<List<Branch>> snapshot) {

                if(snapshot.hasData && _branches.isEmpty) {
                  _branches = snapshot.data!;
                }

                return Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: DropdownButton<Branch>(
                        value: _selectedBranch,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        isExpanded: true,
                        style: const TextStyle(color: AppColors.primary),
                        underline: Container(
                          height: 2,
                          color: AppColors.primary,
                        ),
                        onChanged: (Branch? newValue) {
                          if (newValue != null) {
                            setState(() {
                              var idx = _branches.indexOf(newValue);
                              _selectedBranch = _branches[idx];
                            });
                          }
                        },
                        items: _branches
                            .map((Branch value) {
                          return DropdownMenuItem<Branch>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                      ),
                    );
              }
            ),
            _selectedBranch != null
              ? CardsList(selectedBranch: _selectedBranch,)
              : const SizedBox(),
          ],
        ));
  }
}
