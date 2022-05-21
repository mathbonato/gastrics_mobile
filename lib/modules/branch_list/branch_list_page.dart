// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/mock/BranchGenerator.dart';
import 'package:glp_manager_mobile/models/Branch.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';
import 'package:skeletons/skeletons.dart';

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
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          title: Center(child: Text("GLP Manager")),
          actions: <Widget>[
            Stack(children: [
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.notifications_none)),
              Container(
                width: 7,
                height: 7,
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
                margin: EdgeInsets.only(left: 27, top: 10),
              )
            ])
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.purple,
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
                              child: false
                                  ? SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                          shape: BoxShape.circle,
                                          width: 40,
                                          height: 40),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.grey.shade200,
                                      backgroundImage:
                                          NetworkImage(branches[index].img),
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
                                //   SkeletonLine(
                                //     style: SkeletonLineStyle(
                                //         width: 150,
                                //         height: 15,
                                //         padding: EdgeInsets.only(bottom: 8),
                                //         borderRadius: BorderRadius.circular(20)),
                                //   ),
                                //   SkeletonLine(
                                //       style: SkeletonLineStyle(
                                //           width: 100,
                                //           height: 15,
                                //           borderRadius:
                                //               BorderRadius.circular(20)))
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
