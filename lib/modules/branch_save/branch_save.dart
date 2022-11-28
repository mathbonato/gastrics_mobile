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


class BranchSave extends StatefulWidget {
  const BranchSave({
    Key? key,
    this.branchToUpdate
  }) : super(key: key);

  final Branch? branchToUpdate;

  @override
  State<BranchSave> createState() => _BranchSaveState();
}

class _BranchSaveState extends State<BranchSave> {
  final branchController = BranchController();

  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController alert = TextEditingController();

  initValue(Branch branch) {
    name.text = branch.name;
    address.text = branch.address;
  }

  onChangeName(String value) {
    name.text = value;
  }

  onChangeAddress(String value) {
    address.text = value;
  }

  Future handleBranch(Branch? branchToWork) async {
    bool update = branchToWork != null;
    if(name.text == "") {
      alert.text = "Nome é obrigatório !";
    }
    else if(address.text == "") {
      alert.text = "Endereço é obrigatório !";
    }
    else {
      Branch? result = update
        ? await updateBranch(branchToWork)
        : await createBranch();

      if(result != null) {
        alert.text = "";
        Get.to(const BranchList());
      }
      else {
        alert.text = "Erro ao ${update? "atualizar" : "cadastrar"}";
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

  Future<Branch?> updateBranch(Branch branchToWork) async {
    Branch branch = Branch(
      branchToWork.id,
      name.text,
      address.text,
      [],
    );

    var result = await branchController.updateBranch(
      globals.company!.id,
      branch
    );

    return result;
  }

  Future<Branch?> createBranch() async {
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

    return result;
  }

  @override
  Widget build(BuildContext context) {
    var branchToUpdate = widget.branchToUpdate;
    var hasBranchInfo = branchToUpdate != null; 

    if (hasBranchInfo) {
      initValue(branchToUpdate);
    }

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
                  initialValue: hasBranchInfo ? branchToUpdate.name : "",
                ),
                RoundedInputField(
                  icon: Icons.description,
                  hintText: "Endereço",
                  onChanged: onChangeAddress,
                  initialValue: hasBranchInfo ? branchToUpdate.address : "",
                ),
                RoundedButton(
                  text: hasBranchInfo ? "Atualizar" : "Criar",
                  press: () {
                    handleBranch(branchToUpdate);
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
