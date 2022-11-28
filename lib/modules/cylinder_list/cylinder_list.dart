import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/components/card_img_description.dart';
import 'package:glp_manager_mobile/controllers/CylinderController.dart';
import 'package:glp_manager_mobile/models/Cylinder.dart';
import 'package:glp_manager_mobile/modules/cylinder_save/cylinder_save.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:glp_manager_mobile/models/my-globals.dart' as globals;

class CylinderList extends StatefulWidget {
  const CylinderList({
    Key? key,
    this.filter,
  }) : super(key: key);

  final String? filter;

  @override
  State<CylinderList> createState() => _CylinderList();
}

class _CylinderList extends State<CylinderList> {
  CylinderController cylinderController = CylinderController();
  TextEditingController branchId = TextEditingController();

  actionOnUpdate() {
    setState(() {});
  }

  openCylinderEditor(Cylinder? cylinder) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: CylinderSave(cylinder: cylinder, actionOnFinish: actionOnUpdate)
      ),
    );
  }

  Future removeCylinder(Cylinder cylinder) async {
    await cylinderController.deleteCylinder(
      globals.company!.id,
      globals.currentBranchId,
      cylinder,
    );

    actionOnUpdate();
  }

  @override
  Widget build(BuildContext context) {
    CylinderController cylinderController = CylinderController();
    branchId.text = globals.currentBranchId;
    String? filter = widget.filter;
    
    
    return FutureBuilder(
      future: cylinderController.getCylinders(globals.company!.id, globals.currentBranchId),
      builder: (BuildContext context, AsyncSnapshot<List<Cylinder>> snapshot) {
        List<Cylinder> cylinders = [];

        if(snapshot.hasData) {
          cylinders = snapshot.data!;
        }

        if (filter != null && filter != "") {
          cylinders.retainWhere(
            (element) => element.name.toLowerCase().contains(filter.toLowerCase()) 
                      || element.type.toLowerCase().contains(filter.toLowerCase())
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

              itemCount: cylinders.length,
              itemBuilder: (context, index) {
                Cylinder cylinder = cylinders[index];

                return CardImgDescription(
                  title: cylinder.name,
                  subtitle: cylinder.type,
                  img: "",
                  editIcon: true,
                  removeIcon: true,
                  onCardClick: () => {},
                  editAction: () => openCylinderEditor(cylinder),
                  removeAction: () => removeCylinder(cylinder),
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