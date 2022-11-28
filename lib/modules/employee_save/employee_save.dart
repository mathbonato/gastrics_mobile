import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glp_manager_mobile/components/cuppertino_date_picker.dart';
import 'package:glp_manager_mobile/components/cuppertino_input.dart';
import 'package:glp_manager_mobile/components/cuppertino_list_input.dart';
import 'package:glp_manager_mobile/controllers/EmployeeController.dart';
import 'package:glp_manager_mobile/models/Employee.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';
import 'package:glp_manager_mobile/models/my-globals.dart' as globals;
import 'package:intl/intl.dart';

class EmployeeSave extends StatefulWidget {
  const EmployeeSave({
    Key? key,
    this.employee,
    this.actionOnFinish,
  }) : super(key: key);

  final Employee? employee;
  final Function? actionOnFinish;

  @override
  State<EmployeeSave> createState() => _EmployeeSave();
}

class _EmployeeSave extends State<EmployeeSave> {
  var employeeController = EmployeeController();

  TextEditingController name = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController birth = TextEditingController();
  TextEditingController cpf = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  TextEditingController alert = TextEditingController();

  onChangeName(String value) {
    name.text = value;
  }

  onChangeLastName(String value) {
    lastName.text = value;
  }

  onChangeType(String value) {
    type.text = value;
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

  initValue(Employee employee) {
    name.text = employee.name;
    lastName.text = employee.lastName;
    type.text = employee.type;
    birth.text = employee.birth!.toIso8601String();
    cpf.text = employee.cpf;
    email.text = employee.email;
  }

  Future handleEmployee(Employee? employeeToWork, Function? actionOnFinish) async {
    bool update = employeeToWork != null;

    if(name.text == "") {
      alert.text = "Nome é obrigatório !";
    }
    else if(lastName.text == "") {
      alert.text = "Sobrenome é obrigatório !";
    }
    else if(type.text == "") {
      alert.text = "Tipo é obrigatório !";
    }
    else if(birth.text == "" && !update) {
      alert.text = "Alerta é obrigatório !";
    }
    else if(cpf.text == "" && !update) {
      alert.text = "CPF é obrigatório !";
    }
    else if(email.text == "") {
      alert.text = "CPF é obrigatório !";
    }
    else {
      Employee? result;

      if (update) {
        result = await updateEmployee(employeeToWork);
      }
      else {
        String firstLetter = name.text[0].toLowerCase();
        String secondLetter = name.text[1].toLowerCase();
        String thirdLetter = name.text[2].toLowerCase();
        String nameLetters = firstLetter + secondLetter + thirdLetter;
        DateTime birthDateType = DateFormat('dd-MM-yyyy').parse(birth.text);
        String year = birthDateType.year.toString();
        pass.text = nameLetters + year;

        result = await createEmployee();
      }

      if(result != null) {
        alert.text = "";

        if (actionOnFinish != null) {
          actionOnFinish();
        }

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

  Future<Employee?> updateEmployee(Employee employeeToWork) async {
    Employee employee = Employee(
      employeeToWork.id,
      name.text,
      lastName.text,
      type.text,
      employeeToWork.birth,
      employeeToWork.cpf,
      email.text,
    );

    var result = await employeeController.updateEmployee(
      globals.company!.id,
      employee
    );

    return result;
  }

  Future<Employee?> createEmployee() async {
    DateTime formatedDate = DateFormat('dd-MM-yyyy').parse(birth.text);
    Employee employee = Employee(
      "",
      name.text,
      lastName.text,
      type.text,
      formatedDate,
      cpf.text,
      email.text,
    );
    employee.pass = pass.text;

    var result = await employeeController.postEmployee(
      globals.company!.id,
      employee
    );

    return result;
  }

  @override
  Widget build(BuildContext context) {
    Employee? employee = widget.employee;
    bool hasEmployeeInfo = employee != null;
    bool isEmpty = !(name.text != "" || lastName.text != "" || type.text != "" || birth.text != "" || cpf.text != "" || email.text != "");

    if (hasEmployeeInfo && isEmpty) {
      initValue(employee);
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          child: Column(
            children: <Widget>[
              Text(
                hasEmployeeInfo ? "Atualizar Usuário" : "Criar Usuário",
                style: const TextStyle(
                  fontSize: 24,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
              CuppertinoInput(
                label: "Nome",
                onChange: onChangeName,
                initialValue: name.text,
              ),
              const Padding(padding: EdgeInsets.all(15)),
              CuppertinoInput(
                label: "Sobrenome",
                onChange: onChangeLastName,
                initialValue: lastName.text,
              ),
              const Padding(padding: EdgeInsets.all(15)),
              !hasEmployeeInfo ? CuppertinoInput(
                label: "Cpf",
                onChange: onChangeCpf,
                initialValue: cpf.text,
              ) : const SizedBox(),
              !hasEmployeeInfo ? const Padding(padding: EdgeInsets.all(15)) : const SizedBox(),
              CuppertinoInput(
                label: "Email",
                onChange: onChangeEmail,
                initialValue: email.text,
              ),
              const Padding(padding: EdgeInsets.all(15)),
              !hasEmployeeInfo ? CuppertinoDatePicker(
                label: "Nascimento",
                controller: birth,
              ) : const SizedBox(),
              const Padding(padding: EdgeInsets.all(15)),
              CuppertinoListInput(
                initialValue: type.text,
                items: [
                  ListItem("Empregado", "employee"),
                  ListItem("Chefe/Lider", "owner"),
                ],
                onChange: onChangeType
              ),
              const Padding(padding: EdgeInsets.all(15)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                onPressed: () {
                  handleEmployee(employee, widget.actionOnFinish);
                },
                child: Text(
                  hasEmployeeInfo ? "Atualizar" : "Criar",
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