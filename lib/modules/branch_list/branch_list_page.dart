import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/components/card_img_description.dart';
import 'package:glp_manager_mobile/controllers/BranchController.dart';
import 'package:glp_manager_mobile/models/Branch.dart';
import 'package:glp_manager_mobile/modules/branch_create/branch_create_page.dart';
import 'package:glp_manager_mobile/modules/drawer/drawer.dart';
import 'package:glp_manager_mobile/modules/recipient/recipient_page.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';
import 'package:glp_manager_mobile/models/my-globals.dart' as globals;

import '../../components/notification_bell.dart';

class BranchList extends StatefulWidget {
  const BranchList({Key? key}) : super(key: key);

  @override
  State<BranchList> createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {
  final branchController = BranchController();
  final userInfo = globals.loginResponse;
  final isOwner = globals.isOwner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        drawer: const CustomDrawer(),
        appBar: AppBar(
            backgroundColor: AppColors.primary,
            title: const Center(child: Text("Gastrics")),
            actions: notificationBell()),
            floatingActionButton: isOwner
              ? FloatingActionButton(
                  onPressed: () {
                    Get.to(() => const BranchCreate());
                  },
                  backgroundColor: AppColors.primary,
                  child: const Icon(Icons.add),
                )
              : const SizedBox(),
        body: FutureBuilder(
          future: branchController.getBranches(userInfo!.employee!.company!.id),
          builder: (BuildContext context, AsyncSnapshot<List<Branch>> snapshot) {
            List<Branch> branches = [];

            if(snapshot.hasData) {
              branches = snapshot.data!;
            }

            return Column(
            children: <Widget>[
              const SizedBox(
                height: 80,
                child: Center(
                  child: Text(
                    "Filiais",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 85, 85, 85)),
                  ),
                ),
              ),
              Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    itemCount: branches.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CardImgDescription(
                        title: branches[index].name,
                        subtitle: branches[index].address,
                        img: branches[index].img,
                        editIcon: isOwner,
                        editAction: () {
                          Get.to(() => BranchCreate(branchToUpdate: branches[index]));
                        },
                        onCardClick: () => {
                          Get.to(() => RecipientPage(branch: branches[index])),
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                )
            ],
          );
          },
        ),
      );
  }
}
