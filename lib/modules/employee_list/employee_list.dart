import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/components/card_img_description.dart';
import 'package:glp_manager_mobile/controllers/EmployeeController.dart';
import 'package:glp_manager_mobile/models/Employee.dart';
import 'package:glp_manager_mobile/modules/employee_save/employee_save.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:glp_manager_mobile/models/my-globals.dart' as globals;

class EmployeeList extends StatefulWidget {
  const EmployeeList({
    Key? key,
    this.filter,
  }) : super(key: key);

  final String? filter;

  @override
  State<EmployeeList> createState() => _EmployeeList();
}

class _EmployeeList extends State<EmployeeList> {
  EmployeeController employeeController = EmployeeController();
  TextEditingController branchId = TextEditingController();

  actionOnUpdate() {
    setState(() {});
  }

  openEmployeeEditor(Employee? employee) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: EmployeeSave(employee: employee, actionOnFinish: actionOnUpdate)
      ),
    );
  }

  Future removeEmployee(Employee employee) async {
    await employeeController.deleteEmployee(
      globals.company!.id,
      employee,
    );
    
    actionOnUpdate();
  }

  @override
  Widget build(BuildContext context) {
    EmployeeController employeeController = EmployeeController();
    branchId.text = globals.currentBranchId;
    String? filter = widget.filter;
    
    
    return FutureBuilder(
      future: employeeController.getEmployees(globals.company!.id),
      builder: (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
        List<Employee> employees = [];

        if(snapshot.hasData) {
          employees = snapshot.data!;
        }

        if (filter != null && filter != "") {
          employees.retainWhere(
            (element) => element.name.toLowerCase().contains(filter.toLowerCase()) || element.lastName.toLowerCase().contains(filter.toLowerCase()) 
          );
        }

        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 40.0),
            child: ListView.separated(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ),

              itemCount: employees.length,
              itemBuilder: (context, index) {
                Employee employee = employees[index];

                return CardImgDescription(
                  title: employee.name + " " + employee.lastName,
                  subtitle: employee.type == "owner" ? "Líder" : "Empregado",
                  img: "",
                  editIcon: globals.isOwner,
                  removeIcon: globals.isOwner,
                  onCardClick: () => {},
                  editAction: () => openEmployeeEditor(employee),
                  removeAction: () => removeEmployee(employee),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          ),
        );
      }
    );
  }
}