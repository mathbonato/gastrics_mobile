import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/mock/BranchGenerator.dart';
import 'package:glp_manager_mobile/models/Branch.dart';
import 'package:glp_manager_mobile/modules/branch_create/branch_create_page.dart';
import 'package:glp_manager_mobile/modules/dashboard/drawer.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

class BranchList extends StatefulWidget {
  const BranchList({Key? key}) : super(key: key);

  @override
  State<BranchList> createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {
  final List<Branch> branches = BranchGenerator().getBranches();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColors.background,
        drawer: new CustomDrawer(),
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Center(child: Text("GLP Manager")),
          actions: <Widget>[
            Stack(children: [
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.notifications_none)),
              Container(
                width: 7,
                height: 7,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 221, 75, 209),
                    shape: BoxShape.circle),
                margin: EdgeInsets.only(left: 27, top: 10),
              )
            ])
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(BranchCreate());
          },
          backgroundColor: AppColors.primary,
          child: Icon(Icons.add),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 80,
                child: Center(
                    child: Text(
                  "Filiais",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 85, 85, 85)),
                )),
              ),
              Expanded(
                  child: Container(
                child: ListView.separated(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  itemCount: branches.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Container(
                              child: CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: NetworkImage(branches[index].img),
                          )),
                          SizedBox(width: 20),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  branches[index].name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'R: ' + branches[index].street + ', nº 123',
                                  style: TextStyle(color: Colors.grey[500]),
                                )
                              ])
                        ],
                      ),
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
