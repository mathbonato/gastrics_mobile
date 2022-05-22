import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/components/rounded_button.dart';
import 'package:glp_manager_mobile/components/rounded_input_field.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

class BranchCreate extends StatefulWidget {
  const BranchCreate({Key? key}) : super(key: key);

  @override
  State<BranchCreate> createState() => _BranchCreateState();
}

class _BranchCreateState extends State<BranchCreate> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Center(child: Text("GLP Manager")),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 80,
                child: Center(
                    child: Text(
                  "Adicionar Filial",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 85, 85, 85)),
                )),
              ),
              SingleChildScrollView(
                child: Column(children: <Widget>[
                  RoundedInputField(
                    hintText: "Nome",
                    onChanged: (value) {},
                  ),
                  RoundedInputField(
                    icon: Icons.description,
                    hintText: "Descrição",
                    onChanged: (value) {},
                  ),
                  RoundedInputField(
                    icon: Icons.description,
                    hintText: "Endereço",
                    onChanged: (value) {},
                  ),
                  RoundedInputField(
                    icon: Icons.phone,
                    hintText: "Telefone",
                    onChanged: (value) {},
                  ),
                  RoundedButton(
                    text: "CRIAR",
                    press: () {},
                  ),
                ]),
              )
            ],
          ),
        ));
  }
}
