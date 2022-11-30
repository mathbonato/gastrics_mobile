import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/components/card.dart';
import 'package:glp_manager_mobile/controllers/AnalyticController.dart';
import 'package:glp_manager_mobile/models/Branch.dart';
import 'package:glp_manager_mobile/models/DayDataAnalytic.dart';

class CardsList extends StatefulWidget {
  final Branch? selectedBranch;

  const CardsList({
    Key? key,
    required this.selectedBranch,
  }) : super(key: key);

  @override
  State<CardsList> createState() => _CardsList();
}

class _CardsList extends State<CardsList> {
  AnalyticController analyticsController = AnalyticController();

  double roundDouble(double value, int places){ 
    num mod = pow(10.0, places); 
    return ((value * mod).round().toDouble() / mod); 
  }

  loop() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () => loop());

    return  FutureBuilder(
      future: analyticsController.getAnalyticsByBranch(widget.selectedBranch!.id),
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
    );
  }
}
