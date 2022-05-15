import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
            child: Text('Hello, Fulano!'),
          ),
          ListTile(
            title: const Text('Filiais'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Sair'),
            onTap: () => Get.back(),
          ),
        ],
      ),
    );
  }
}
