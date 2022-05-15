import 'package:flutter/material.dart';
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
      body: Container(
          width: size.width, height: size.height, child: Text("Dashboard")),
    );
  }
}
