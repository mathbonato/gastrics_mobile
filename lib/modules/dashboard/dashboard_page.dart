import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/modules/dashboard/drawer.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String dropdownValue = 'Filial1';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          backgroundColor: AppColors.primary, title: const Text("GLP Manager")),
      drawer: const CustomDrawer(),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
            child: Container(
          child: Column(
            children: [
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
              SizedBox(height: size.height * 0.03),
              Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: AppColors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Container(
                      height: 200,
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                            child: Row(
                              children: const [
                                CircularProgressIndicator(
                                  backgroundColor: Colors.grey,
                                  color: Colors.green,
                                  strokeWidth: 10,
                                  value: 0.65,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))),
            ],
          ),
        )),
      ),
    );
  }
}
