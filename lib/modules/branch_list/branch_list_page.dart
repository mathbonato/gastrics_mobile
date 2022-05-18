// ignore_for_file: prefer_const_constructors

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
            backgroundColor: AppColors.primary, title: Text("GLP Manager")),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                child: Center(
                    child: Text(
                  "Filiais",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
              Expanded(
                  child: Container(
                child: ListView.separated(
                  padding: EdgeInsets.all(20),
                  itemCount: branches.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Container(
                              child: true
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
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SkeletonLine(
                                  style: SkeletonLineStyle(
                                      width: 150,
                                      height: 15,
                                      padding: EdgeInsets.only(bottom: 8),
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                SkeletonLine(
                                    style: SkeletonLineStyle(
                                        width: 100,
                                        height: 15,
                                        borderRadius:
                                            BorderRadius.circular(20)))
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
