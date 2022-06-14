import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/components/card_img_description.dart';
import 'package:glp_manager_mobile/components/header_img_description.dart';
import 'package:glp_manager_mobile/components/notification_bell.dart';
import 'package:glp_manager_mobile/components/searcher.dart';
import 'package:glp_manager_mobile/models/Branch.dart';
import 'package:glp_manager_mobile/models/Receipt.dart';
import 'package:glp_manager_mobile/models/User.dart';
import 'package:glp_manager_mobile/mock/UserGenerator.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:glp_manager_mobile/components/progress_line.dart';

class RecipientPage extends StatefulWidget {
  const RecipientPage({
    Key? key,
    required this.branch,
  }) : super(key: key);

  final Branch branch;

  @override
  State<RecipientPage> createState() => _RecipientPageState();
}

class Controller extends GetxController {
  static Controller get to => Get.find();

  bool showReceipts = true;

  void setShowReceipts() {
    showReceipts = !showReceipts;
    update();
  }
}

class _RecipientPageState extends State<RecipientPage> {
  String selectedIcon = 'one';
  TextEditingController name = TextEditingController();
  TextEditingController peso = TextEditingController();
  TextEditingController casco = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController userCpf = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  List<User> allUsers = UserGenerator().userGenerate();
  List<User> userQuery = UserGenerator().getUsers();

  userControl(String icon, Branch branch) {
    userQuery = allUsers;

    if (icon == "two") {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalState) {
        return Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(30),
              child: Material(
                //color:AppColors.primary,

                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Procurar Usuário",
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
                  // icon:Icons.search,
                  //color:AppColors.primary,
                  //padding:EdgeInsets.all(10),
                  //hintText:"Procurar Usuário",
                  onChanged: (value) {
                    modalState(() {
                      userQuery = [];
                    });
                    if (value != "") {
                      for (int i = 0; i < allUsers.length; i++) {
                        if (allUsers[i]
                                .name
                                .toUpperCase()
                                .contains(value.toUpperCase()) ||
                            allUsers[i].cpf.contains(value)) {
                          modalState(() {
                            userQuery.add(allUsers[i]);
                          });
                        }
                      }
                    } else {
                      modalState(() {
                        userQuery = allUsers;
                      });
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.43,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: userQuery.length,
                itemBuilder: (context, index) {
                  User user = userQuery[index];
                  return Card(
                    child: InkWell(
                      onTap: () {
                        branch.users.any((item) => item.cpf == user.cpf) == true
                            ? setState(() {
                                modalState(() {
                                  branch.users.removeAt(branch.users.indexWhere(
                                      (userValue) =>
                                          userValue.cpf == user.cpf));
                                });
                              })
                            : setState(() {
                                modalState(() {
                                  branch.users.add(user);
                                });
                              });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        //color:AppColors.primary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: [
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),

                            // Container(
                            // child:: Container()
                            // ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  branch.users.any(
                                              (item) => item.cpf == user.cpf) ==
                                          true
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: const <Widget>[
                                            Icon(
                                              Icons.check,
                                              color: Colors.green,
                                              size: 18,
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      modalState(() {
                                        userQuery.removeWhere(
                                            (item) => item.cpf == user.cpf);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
          ],
        );
      });
    } else {
      return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Material(
                //color:AppColors.primary,
                child: TextFormField(
                  controller: userName,
                  decoration: InputDecoration(
                    labelText: "Nome do Usuário",
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
              Material(
                //color:AppColors.primary,
                child: TextFormField(
                  controller: userCpf,
                  decoration: InputDecoration(
                    labelText: "Cpf do Usuário",
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
              Material(
                //color:AppColors.primary,
                child: TextFormField(
                  controller: userEmail,
                  decoration: InputDecoration(
                    labelText: "Email do Usuário",
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
              Material(
                //color:AppColors.primary,
                child: TextFormField(
                  controller: userPhone,
                  decoration: InputDecoration(
                    labelText: "Telefone do Usuário",
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
              const Padding(padding: EdgeInsets.only(top: 10)),
              Material(
                //color:AppColors.primary,
                child: ElevatedButton(
                  child: const Text(
                    "Criar",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      User user = User();
                      user.name = userName.text;
                      user.cpf = userCpf.text;
                      user.email = userEmail.text;
                      user.phone = userPhone.text;
                      allUsers.add(user);
                      branch.users.add(user);

                      userName.text = "";
                      userCpf.text = "";
                      userEmail.text = "";
                      userPhone.text = "";
                    });
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                      // padding:  EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppColors.primary)),
                ),
              ),
            ],
          ));
    }
  }

  selectedIconChange(String iconName, Branch branch, List<Receipt> canisters,
      List<User> users) {
    if (iconName == "one") {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.only(top: 40.0),
          child: ListView.separated(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),

            itemCount: canisters.length,
            // The list items
            itemBuilder: (context, index) {
              Receipt canister = canisters[index];

              return CardImgDescription(
                title: canister.name,
                subtitle: canister.description,
                img: canister.img,
                editIcon: true,
                removeIcon: true,
                onCardClick: () => openCanisterView(canister),
                editAction: () => openCanisterEditor(canister),
                removeAction: () {
                  setState(
                    () {
                      branch.canisters.removeAt(index);
                    },
                  );
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          ),
        ),
      );
    } else {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.only(top: 40.0),
          child: ListView.separated(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),

            itemCount: users.length,
            // The list items
            itemBuilder: (context, index) {
              User user = users[index];

              return CardImgDescription(
                title: user.name,
                subtitle: user.cpf,
                img:
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Breezeicons-actions-22-im-user.svg/1200px-Breezeicons-actions-22-im-user.svg.png',
                editIcon: false,
                removeIcon: true,
                //onCardClick: () => openCanisterView(canister),
                //editAction: () => openCanisterEditor(canister),
                removeAction: () {
                  setState(
                    () {
                      branch.users.removeAt(index);
                    },
                  );
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          ),
        ),
      );
    }
  }

  openCanisterView(Receipt canister) {
    double per = (canister.actualWeight / canister.totalWeight) * 100;
    int? peri = per.toInt();

    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: AppColors.primary,
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Card(
              color: AppColors.primary,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: ProgressLine(
                      color: Colors.green,
                      percentage: peri,
                    ),
                  ),
                  Text(
                    peri.toString() + "%",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Text(
              canister.name,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            Text(
              "Peso atual: " + canister.actualWeight.toStringAsFixed(2) + "Kg",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            Text(
              "Capacidade máxima: " +
                  canister.totalWeight.toStringAsFixed(2) +
                  "Kg",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            const Text(
              "Atualizado em 26/05/2022",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }

  openUserAttach(Branch branch) {
    String userIcon = 'one';
    userQuery = UserGenerator().getUsers();
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalState) {
            return Container(
              //color:AppColors.primary,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "Controle de Usuários",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  Material(
                    //color:AppColors.primary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          color: Colors.black,
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              modalState(() {
                                userIcon = "one";
                              });
                            });
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 26),
                        ),
                        IconButton(
                          color: Colors.black,
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              modalState(() {
                                userIcon = "two";
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  userControl(userIcon, branch),
                ],
              ),
            );
          },
        );
      },
    );
  }

  openCanisterEditor(Receipt canister) {
    casco.text = canister.gasHullWeight.toString();
    peso.text = canister.totalWeight.toString();
    name.text = canister.name;
    desc.text = canister.description;

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
                    "Editar Recipiente",
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
                    controller: peso,
                    decoration: InputDecoration(
                      labelText: "Capacidade máxima",
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
                Material(
                  child: TextFormField(
                    controller: casco,
                    decoration: InputDecoration(
                      labelText: "Peso do recipiente vazio",
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
                const Padding(padding: EdgeInsets.all(15)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primary,
                  ),
                  onPressed: () {
                    canister.name = name.text;
                    canister.description = desc.text;
                    canister.totalWeight = double.parse(peso.text);
                    canister.gasHullWeight = double.parse(casco.text);

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

  openCanisterCreator() {
    casco.text = '';
    peso.text = '';
    name.text = '';
    desc.text = '';

    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              child: Column(children: <Widget>[
                const Text(
                  "Criar Recipiente",
                  style: TextStyle(
                    fontSize: 24,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
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
                    controller: peso,
                    decoration: InputDecoration(
                      labelText: "Capacidade máxima",
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
                    controller: casco,
                    decoration: InputDecoration(
                      labelText: "Peso do recipiente vazio",
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
                const Padding(padding: EdgeInsets.all(15)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: AppColors.primary),
                  onPressed: () {
                    Receipt gas = Receipt();
                    gas.name = name.text;
                    gas.totalWeight = double.parse(peso.text);
                    gas.gasHullWeight = double.parse(casco.text);
                    gas.img =
                        "https://a-static.mlcdn.com.br/1500x1500/botijao-de-gas-13kg-liquigas/doisirmaosdistribuidora/d1a9bcc2593111ec9a154201ac18503a/8e2690349b445e82c17437d629fa10a0.jpg";
                    setState(() {
                      widget.branch.canisters.add(gas);
                      name.text = "";
                      peso.text = "";
                      casco.text = "";
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Criar",
                    style: TextStyle(
                        color: Colors.white, decoration: TextDecoration.none),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Branch branch = widget.branch;
    List<Receipt> canisters = branch.canisters;
    List<User> users = branch.users;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: const Text("Gastrics"),
        actions: notificationBell(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIcon == 'one') {
            openCanisterCreator();
          } else {
            openUserAttach(branch);
          }
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 40,
              bottom: 40,
            ),
            child: HeaderImgDescription(
              title: branch.name,
              subtitle: branch.street,
              img: branch.img,
              iconOneRef: Icons.article,
              iconTwoRef: Icons.people,
              iconOne: true,
              iconTwo: true,
              iconOneName: 'Recipientes',
              iconTwoName: 'Usuários',
              iconOneAction: () {
                setState(() {
                  selectedIcon = 'one';
                });
              },
              iconTwoAction: () {
                setState(() {
                  selectedIcon = 'two';
                });
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: const Searcher(
              pleaceHolder: 'Procurar recipientes',
              title: 'recipientes',
            ),
          ),
          selectedIconChange(selectedIcon, branch, canisters, users),
        ],
      ),
    );
  }
}
