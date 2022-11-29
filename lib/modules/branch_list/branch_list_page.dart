import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/components/card_img_description.dart';
import 'package:glp_manager_mobile/mock/BranchGenerator.dart';
import 'package:glp_manager_mobile/models/Branch.dart';
import 'package:glp_manager_mobile/modules/branch_create/branch_create_page.dart';
import 'package:glp_manager_mobile/modules/drawer/drawer.dart';
import 'package:glp_manager_mobile/modules/recipient/recipient_page.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';
import 'package:glp_manager_mobile/modules/branch_list/branchController.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../components/notification_bell.dart';

class BranchList extends StatefulWidget {
  const BranchList({Key? key}) : super(key: key);

  @override
  State<BranchList> createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {
  
  final Future<List<Branch>> futureBranches =  new branchController().getBranches();
  List<Branch> branches=[] ;
    TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  
  

  @override
  void initState() {
    super.initState();
     futuretolist();
  }
 
  Future futuretolist() async {
    
     branches = await futureBranches;
    setState((){
   
    });
    
    
  }
 
  @override
  Widget build(BuildContext context){
    
   
    
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
                      editAction: () =>openBranchEditor(branches[index]),
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

  Future openBranchEditor(Branch branch) async{
 
    address.text = branch.street;
    
    name.text = branch.name;
    

    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Editar Filial",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                Material(
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: "Nome",
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.primary,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Material(
                  child: TextFormField(
                    controller: address,
                    decoration: InputDecoration(
                      labelText: "Endereço",
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.primary,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
               
                const Padding(padding: EdgeInsets.all(15)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primary,
                  ),
                  onPressed: () {
                    branch.name = name.text;
                    branch.street = address.text;
                    
                    new branchController().updateBranch(branch);

                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Salvar",
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  
  }
}
