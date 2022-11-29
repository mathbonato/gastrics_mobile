import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/modules/home/home_page.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';
import 'package:get_storage/get_storage.dart';

void main()  async {
  await GetStorage.init();
  GetStorage().write("name","");
  GetStorage().write("email","");
  GetStorage().write("pass","");
  GetStorage().write("lastName","");
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      home: HomePage()));
}
