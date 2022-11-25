import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/components/notification_bell.dart';
import 'package:glp_manager_mobile/components/rounded_button.dart';
import 'package:glp_manager_mobile/components/rounded_input_field.dart';
import 'package:glp_manager_mobile/controllers/BranchController.dart';
import 'package:glp_manager_mobile/models/Branch.dart';
import 'package:glp_manager_mobile/modules/branch_list/branch_list_page.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';
import 'package:glp_manager_mobile/models/my-globals.dart' as globals;


class BranchCreate extends StatefulWidget {
  const BranchCreate({Key? key}) : super(key: key);

  @override
  State<BranchCreate> createState() => _BranchCreateState();
}

class _BranchCreateState extends State<BranchCreate> {
  final branchController = BranchController();

  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController alert = TextEditingController();

  onChangeName(String value) {
    name.text = value;
  }

  onChangeAddress(String value) {
    address.text = value;
  }

  Future createBranch() async {
    if(name.text == "") {
      alert.text = "Nome é obrigatório !";
    }
    else if(address.text == "") {
      alert.text = "Endereço é obrigatório !";
    }
    else {
      Branch branch = Branch(
        "",
        name.text,
        address.text,
        []
      );

      var result = await branchController.postBranch(
        globals.company!.id,
        branch
      );

      if(result != null) {
        alert.text = "";
        Get.to(const BranchList());
      }
      else {
        alert.text = "Erro ao cadastrar";
      }
    }

    if (alert.text != "") {
      Fluttertoast.showToast(
        msg: alert.text,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

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
                  onChanged: onChangeName,
                ),
                RoundedInputField(
                  icon: Icons.description,
                  hintText: "Endereço",
                  onChanged: onChangeAddress,
                ),
                RoundedButton(
                  text: "CRIAR",
                  press: createBranch,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
