// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/mock/BranchGenerator.dart';
import 'package:glp_manager_mobile/models/Branch.dart';
import 'package:glp_manager_mobile/shared/themes/app_images.dart';
import 'package:glp_manager_mobile/shared/themes/app_text_styles.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';
import 'package:glp_manager_mobile/shared/widgets/social_login/social_login_button.dart';

import '../../components/already_have_an_account_acheck.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';

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
                        children: <Widget>[Text(branches[index].name)],
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
