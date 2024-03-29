import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glp_manager_mobile/components/cuppertino_input.dart';
import 'package:glp_manager_mobile/components/cuppertino_int_input.dart';
import 'package:glp_manager_mobile/components/cuppertino_list_input.dart';
import 'package:glp_manager_mobile/controllers/CylinderController.dart';
import 'package:glp_manager_mobile/models/Cylinder.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';
import 'package:glp_manager_mobile/models/my-globals.dart' as globals;

class CylinderSave extends StatefulWidget {
  const CylinderSave({
    Key? key,
    this.cylinder,
    this.actionOnFinish,
  }) : super(key: key);

  final Cylinder? cylinder;
  final Function? actionOnFinish;

  @override
  State<CylinderSave> createState() => _CylinderSave();
}

class _CylinderSave extends State<CylinderSave> {
  var cylinderController = CylinderController();

  TextEditingController exId = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController gasType = TextEditingController();
  TextEditingController alertWhen = TextEditingController();

  TextEditingController alert = TextEditingController();

  onChangeExId(String value) {
    exId.text = value;
  }

  onChangeName(String value) {
    name.text = value;
  }

  onChangeType(String value) {
    type.text = value;
  }

  onChangeGasType(String value) {
    gasType.text = value;
  }

  onChangeAlertWhen(String value) {
    alertWhen.text = value;
  }

  initValue(Cylinder cylinder) {
    exId.text = cylinder.exId;
    name.text = cylinder.name;
    type.text = cylinder.type;
    gasType.text = cylinder.gasType;
    alertWhen.text = cylinder.alertWhen.toString();
  }

  Future handleCylinder(Cylinder? cylinderToWork, Function? actionOnFinish) async {
    bool update = cylinderToWork != null;
    if(name.text == "") {
      alert.text = "Nome é obrigatório !";
    }
    else if(exId.text == "") {
      alert.text = "Id externo é obrigatório !";
    }
    else if(type.text == "") {
      alert.text = "Tipo é obrigatório !";
    }
    else {
      Cylinder? result = update
        ? await updateCylinder(cylinderToWork)
        : await createCylinder();

      if(result != null) {
        alert.text = "";

        if (actionOnFinish != null) {
          actionOnFinish();
        }

        Fluttertoast.showToast(
          msg: update ? "Atualizado com sucesso !" : "Criado com sucesso !",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        Navigator.pop(context);
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

  Future<Cylinder?> updateCylinder(Cylinder cylinderToWork) async {
    Cylinder cylinder = Cylinder(
      cylinderToWork.id,
      cylinderToWork.exId,
      name.text,
      gasType.text,
      type.text,
      0.0,
      0.0,
      int.parse(alertWhen.text),
    );

    var result = await cylinderController.updateCylinder(
      globals.company!.id,
      globals.currentBranchId,
      cylinder
    );

    return result;
  }

  Future<Cylinder?> createCylinder() async {
    Cylinder cylinder = Cylinder(
      "",
      exId.text,
      name.text,
      gasType.text,
      type.text,
      0.0,
      0.0,
      int.parse(alertWhen.text),
    );

    var result = await cylinderController.postCylinder(
      globals.company!.id,
      globals.currentBranchId,
      cylinder
    );

    return result;
  }

  @override
  Widget build(BuildContext context) {
    Cylinder? cylinder = widget.cylinder;
    bool hasCylinderInfo = cylinder != null;
    bool isEmpty = !(exId.text != "" || name.text != "" || type.text != "" || gasType.text != "" || alertWhen.text != "");

    if (hasCylinderInfo && isEmpty) {
      initValue(cylinder);
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          child: Column(
            children: <Widget>[
              Text(
                hasCylinderInfo ? "Atualizar Recipiente" : "Criar Recipiente",
                style: const TextStyle(
                  fontSize: 24,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
              !hasCylinderInfo 
                ? CuppertinoInput(
                  label: "Id externo",
                  onChange: onChangeExId,
                  initialValue: exId.text,
                )
                : const SizedBox(),
              !hasCylinderInfo 
                ? const Padding(padding: EdgeInsets.all(10))
                : const SizedBox(),
              CuppertinoInput(
                label: "Nome",
                onChange: onChangeName,
                initialValue: name.text,
              ),
              const Padding(padding: EdgeInsets.all(15)),
              CuppertinoInput(
                label: "Tipo do gás",
                onChange: onChangeGasType,
                initialValue: gasType.text,
              ),
              const Padding(padding: EdgeInsets.all(15)),
              CuppertinoIntInput(
                label: "Alertar quando (%)",
                onChange: onChangeAlertWhen,
                initialValue: alertWhen.text,
              ),
              const Padding(padding: EdgeInsets.all(15)),
              CuppertinoListInput(
                initialValue: type.text,
                items: [
                  ListItem("P13", "p13"),
                  ListItem("P20 - 3 valvulas", "p20v3"),
                  ListItem("P20 - 5 valvulas", "p20v5"),
                  ListItem("P45", "p45"),
                  ListItem("TCC", "tcc"),
                ],
                onChange: onChangeType
              ),
              const Padding(padding: EdgeInsets.all(15)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                onPressed: () {
                  handleCylinder(cylinder, widget.actionOnFinish);
                },
                child: Text(
                  hasCylinderInfo ? "Atualizar" : "Criar",
                  style: const TextStyle(
                    color: Colors.white, decoration: TextDecoration.none
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}