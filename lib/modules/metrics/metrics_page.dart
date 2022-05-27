import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:glp_manager_mobile/components/notification_bell.dart';
import 'package:glp_manager_mobile/modules/metrics/bar_chart.dart';
import 'package:glp_manager_mobile/modules/metrics/line_chart.dart';

import '../../shared/themes/appcollors.dart';
import '../dashboard/drawer.dart';

class MetricsPage extends StatefulWidget {
  const MetricsPage({Key? key}) : super(key: key);

  @override
  _MetricsPage createState() => _MetricsPage();
}

class _MetricsPage extends State<MetricsPage> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d3ea),
  ];

  String dropdownValue = 'Filial1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text("Gastrics"),
          actions: notificationBell()),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
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
            Text(
              'Consumo mensal (atual)'.toUpperCase(),
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          color: Colors.red,
                          width: 15,
                          height: 15,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            '+1 desvio padrão',
                            style: TextStyle(fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          color: Colors.blue,
                          width: 15,
                          height: 15,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'média',
                            style: TextStyle(fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          color: Colors.green,
                          width: 15,
                          height: 15,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            '-1 desvio padrão',
                            style: TextStyle(fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const LineChart1(),
            Text(
              'Comparação anual'.toUpperCase(),
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Text(
                'Selecione duas datas diferentes para comparar o consumo mensal de gás entre elas',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //new buttonText starts
                  TextButton(
                    onPressed: () {
                      DatePicker.showPicker(context,
                          theme: const DatePickerTheme(
                              headerColor: Colors.grey,
                              backgroundColor: AppColors.primary,
                              itemStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              doneStyle:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          pickerModel: CustomMonthPicker(
                              locale: LocaleType.pt,
                              minTime: DateTime(2020, 1, 1),
                              maxTime: DateTime.now(),
                              currentTime: DateTime.now()));
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: Container(
                      child: Row(
                        children: const [
                          Text(
                            'Data inicial',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      DatePicker.showPicker(context,
                          theme: const DatePickerTheme(
                              headerColor: Colors.grey,
                              backgroundColor: AppColors.primary,
                              itemStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              doneStyle:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          pickerModel: CustomMonthPicker(
                              locale: LocaleType.pt,
                              minTime: DateTime(2020, 1, 1),
                              maxTime: DateTime.now(),
                              currentTime: DateTime.now()));
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: Container(
                      child: Row(
                        children: const [
                          Text(
                            'Data final',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const BarChartSample4(),
          ],
        ),
      ),
    );
  }
}

class CustomMonthPicker extends DatePickerModel {
  CustomMonthPicker(
      {DateTime? currentTime,
      DateTime? minTime,
      DateTime? maxTime,
      DatePickerTheme? theme,
      LocaleType? locale})
      : super(
          locale: locale,
          minTime: minTime,
          maxTime: maxTime,
          currentTime: currentTime,
        );

  @override
  List<int> layoutProportions() {
    return [1, 1, 0];
  }
}
