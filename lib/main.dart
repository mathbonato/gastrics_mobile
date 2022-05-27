import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/modules/home/home_page.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

void main() {
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      home: HomePage()));
}
