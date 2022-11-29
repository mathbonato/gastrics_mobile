import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/components/header_img_description.dart';
import 'package:glp_manager_mobile/components/notification_bell.dart';
import 'package:glp_manager_mobile/components/searcher.dart';
import 'package:glp_manager_mobile/models/Branch.dart';
import 'package:glp_manager_mobile/models/Cylinder.dart';
import 'package:glp_manager_mobile/models/Employee.dart';
import 'package:glp_manager_mobile/modules/cylinder_list/cylinder_list.dart';
import 'package:glp_manager_mobile/modules/cylinder_save/cylinder_save.dart';
import 'package:glp_manager_mobile/modules/employee_list/employee_list.dart';
import 'package:glp_manager_mobile/modules/employee_save/employee_save.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:glp_manager_mobile/models/my-globals.dart' as globals;

class BranchView extends StatefulWidget {
  const BranchView({
    Key? key,
    required this.branch,
  }) : super(key: key);

  final Branch branch;

  @override
  State<BranchView> createState() => _BranchViewState();
}

class Controller extends GetxController {
  static Controller get to => Get.find();

  bool showReceipts = true;

  void setShowReceipts() {
    showReceipts = !showReceipts;
    update();
  }
}

class _BranchViewState extends State<BranchView> {
  String selectedIcon = 'cylinder';
  TextEditingController serchText = TextEditingController();

  openCylinderCreator(Cylinder? cylinder) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: CylinderSave(
          cylinder: cylinder,
          actionOnFinish: () {
            setState(() {});
          },
        ),
      ),
    );
  }

  openEmployeeCreator(Employee? employee) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: EmployeeSave(
          employee: employee,
          actionOnFinish: () {
            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Branch branch = widget.branch;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: const Text("Gastrics"),
        actions: notificationBell(),
      ),
      floatingActionButton: globals.isOwner
        ? FloatingActionButton(
          onPressed: () {
            if (selectedIcon == 'cylinder') {
              openCylinderCreator(null);
            } else {
            openEmployeeCreator(null);
            }
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add),
        )
        : const SizedBox(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 40,
              bottom: 40,
            ),
            child: HeaderImgDescription(
              title: branch.name,
              subtitle: branch.address,
              img: branch.img,
              iconOneRef: Icons.article,
              iconTwoRef: Icons.people,
              iconOne: true,
              iconTwo: true,
              iconOneName: 'Recipientes',
              iconTwoName: 'Usuários',
              iconOneAction: () {
                setState(() {
                  selectedIcon = 'cylinder';
                });
              },
              iconTwoAction: () {
                setState(() {
                  selectedIcon = 'employee';
                });
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Searcher(
              pleaceHolder: selectedIcon == 'cylinder'
                ? "Procurar recipientes"
                : "Procurar empregado",
              title: selectedIcon == 'cylinder'
                ? "Recipientes"
                : "Empregados",
              onChange: (value) {
                serchText.text = value;
                setState(() {});
              },
            ),
          ),
          selectedIcon == 'cylinder'
            ? CylinderList( filter: serchText.text,)
            : EmployeeList(filter:  serchText.text,),
        ],
      ),
    );
  }
}
