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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          backgroundColor: AppColors.primary, title: Text("GLP Manager")),
      drawer: CustomDrawer(),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(child: Container()),
      ),
    );
  }
}
