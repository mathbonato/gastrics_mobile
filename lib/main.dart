import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/modules/home/home_page.dart';
import 'package:glp_manager_mobile/modules/home/home_page.dart';
import 'package:glp_manager_mobile/modules/splash/splash_page.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

void main() {
  runApp(GetMaterialApp(
    theme: ThemeData(primaryColor: AppColors.primary),
    home: const HomePage(),
  ));
}
