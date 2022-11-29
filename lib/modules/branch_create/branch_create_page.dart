import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/components/notification_bell.dart';
import 'package:glp_manager_mobile/components/rounded_button.dart';
import 'package:glp_manager_mobile/components/rounded_input_field.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';
import 'package:glp_manager_mobile/modules/branch_list/branchController.dart';
import 'package:glp_manager_mobile/modules/branch_list/branch_list_page.dart';
import 'package:glp_manager_mobile/models/Branch.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchCreate extends StatefulWidget {
  const BranchCreate({Key? key}) : super(key: key);

  @override
  State<BranchCreate> createState() => _BranchCreateState();
}

class _BranchCreateState extends State<BranchCreate> {
  String name='';
  String address='';
  branchController controller = new branchController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primary,
          title: const Text("Gastrics"),
          actions: notificationBell()),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 80,
            child: Center(
              child: Text(
                "Adicionar Filial",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromARGB(255, 85, 85, 85)),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                RoundedInputField(
                  hintText: "Nome",
                  onChanged: (value) {
                    name = value;
                  },
                ),
                RoundedInputField(
                  icon: Icons.description,
                  hintText: "Descrição",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  icon: Icons.description,
                  hintText: "Endereço",
                  onChanged: (value) {
                    address = value;
                  },
                ),
                RoundedInputField(
                  icon: Icons.phone,
                  hintText: "Telefone",
                  onChanged: (value) {},
                ),
                RoundedButton(
                  text: "CRIAR",
                  press: () async {
                    if(name != '' || address !=''){
                    Branch branch = new Branch();
                    branch.name = name;
                    branch.street = address;
                    controller.createBranch(branch);
                    }else{
                      print("campos vazios");
                    }
                    setState((){});
                    Get.to(BranchList());
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
