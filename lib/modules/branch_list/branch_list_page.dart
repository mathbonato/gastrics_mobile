import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/components/card_img_description.dart';
import 'package:glp_manager_mobile/mock/BranchGenerator.dart';
import 'package:glp_manager_mobile/models/Branch.dart';
import 'package:glp_manager_mobile/modules/branch_create/branch_create_page.dart';
import 'package:glp_manager_mobile/modules/drawer/drawer.dart';
import 'package:glp_manager_mobile/modules/recipient/recipient_page.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

import '../../components/notification_bell.dart';

class BranchList extends StatefulWidget {
  const BranchList({Key? key}) : super(key: key);

  @override
  State<BranchList> createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {
  final List<Branch> branches = BranchGenerator().getBranches();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        drawer: const CustomDrawer(),
        appBar: AppBar(
            backgroundColor: AppColors.primary,
            title: const Center(child: Text("Gastrics")),
            actions: notificationBell()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(const BranchCreate());
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 80,
                child: const Center(
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
                  child: Container(
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
                      subtitle: branches[index].street,
                      img: branches[index].img,
                      editIcon: true,
                      editAction: () {},
                      onCardClick: () => {
                        Get.to(RecipientPage(branch: branches[index])),
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              ))
            ],
          ),
        ));
  }
}
