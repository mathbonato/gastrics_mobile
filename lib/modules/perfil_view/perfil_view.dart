import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/components/cuppertino_date_picker.dart';
import 'package:glp_manager_mobile/components/cuppertino_input.dart';
import 'package:glp_manager_mobile/components/cuppertino_list_input.dart';
import 'package:glp_manager_mobile/components/header_img_description.dart';
import 'package:glp_manager_mobile/components/notification_bell.dart';
import 'package:glp_manager_mobile/components/rounded_button.dart';
import 'package:glp_manager_mobile/components/searcher.dart';
import 'package:glp_manager_mobile/controllers/EmployeeController.dart';
import 'package:glp_manager_mobile/models/Branch.dart';
import 'package:glp_manager_mobile/models/Cylinder.dart';
import 'package:glp_manager_mobile/models/Employee.dart';
import 'package:glp_manager_mobile/modules/cylinder_list/cylinder_list.dart';
import 'package:glp_manager_mobile/modules/cylinder_save/cylinder_save.dart';
import 'package:glp_manager_mobile/modules/employee_list/employee_list.dart';
import 'package:glp_manager_mobile/modules/employee_save/employee_save.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:glp_manager_mobile/models/my-globals.dart' as globals;

class PerfilView extends StatefulWidget {
  const PerfilView({
    Key? key,
  }) : super(key: key);

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  EmployeeController employeeController = EmployeeController();

  TextEditingController alert = TextEditingController();

  TextEditingController showPass = TextEditingController();
  TextEditingController edit = TextEditingController();

  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController birth = TextEditingController();
  TextEditingController cpf = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  initValues() {
    Employee? employee = globals.employee;

    id.text = employee!.id;
    name.text = employee.name;
    lastName.text = employee.lastName;
    birth.text = DateFormat('dd-MM-yyyy').format(employee.birth!);
    cpf.text = employee.cpf;
    email.text = employee.email;
    pass.text = employee.pass!;
  }

  onChangeName(String value) {
    name.text = value;
  }

  onChangeLastName(String value) {
    lastName.text = value;
  }

  onChangeBirth(String value) {
    birth.text = value;
  }

  onChangeCpf(String value) {
    cpf.text = value;
  }

  onChangeEmail(String value) {
    email.text = value;
  }

  onChangePass(String value) {
    pass.text = value;
  }

  Future update() async {
    DateTime formatedDate = DateFormat('dd-MM-yyyy').parse(birth.text);
    Employee employee = Employee(
      id.text,
      name.text,
      lastName.text,
      "",
      formatedDate,
      cpf.text,
      email.text,
    );
    employee.pass = pass.text;

    Employee? result = await employeeController.updateEmployeeInfo(
      globals.company!.id,
      employee
    );

    if(result == null) {
      alert.text = "Erro ao atualizar";
      Fluttertoast.showToast(
        msg: alert.text,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    else {
      edit.text = "";
      showPass.text = "";
      Fluttertoast.showToast(
        msg: "Atualizado com sucesso !",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var enableEdit = edit.text != "";
    var enablePass = showPass.text != "";

    bool isEmpty = !(id.text != "" || name.text != "" || lastName.text != "" || birth.text != "" || cpf.text != "" || email.text != "" || pass.text != "");

    if(isEmpty) {
      initValues();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: const Text("Gastrics"),
        actions: notificationBell(),
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              const Center(
                child: Text(
                  "Perfil",
                  style: TextStyle(
                    fontSize: 24,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.all(15)),
              CuppertinoInput(
                label: "Nome",
                onChange: onChangeName,
                initialValue: name.text,
                readOnly: !enableEdit,
              ),
              const Padding(padding: EdgeInsets.all(15)),
              CuppertinoInput(
                label: "Sobrenome",
                onChange: onChangeLastName,
                initialValue: lastName.text,
                readOnly: !enableEdit,
              ),
              const Padding(padding: EdgeInsets.all(15)),
              CuppertinoInput(
                label: "CPF",
                onChange: onChangeCpf,
                initialValue: cpf.text,
                readOnly: !enableEdit,
              ),
              const Padding(padding: EdgeInsets.all(15)),
              CuppertinoInput(
                label: "Email",
                onChange: onChangeEmail,
                initialValue: email.text,
                readOnly: !enableEdit,
              ),
              const Padding(padding: EdgeInsets.all(15)),
              CuppertinoDatePicker(
                label: "Nascimento",
                controller: birth,
                readOnly: !enableEdit,
              ),
              const Padding(padding: EdgeInsets.all(15)),
              enableEdit ? CuppertinoInput(
                label: "Senha",
                onChange: onChangePass,
                initialValue: pass.text,
                readOnly: !enableEdit,
                obscureText: !enablePass,
              ) : const SizedBox(),
              const Padding(padding: EdgeInsets.all(15)),
              RoundedButton(
                text: !enableEdit ? "Editar" : "Atualizar",
                press: () {
                  if(!enableEdit) {
                    edit.text = "edit";
                    showPass.text = "show";
                    setState(() {});
                  }
                  else {
                    update();
                  }
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
