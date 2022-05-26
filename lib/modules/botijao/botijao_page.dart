import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/components/card_img_description.dart';
import 'package:glp_manager_mobile/components/header_img_description.dart';
import 'package:glp_manager_mobile/components/searcher.dart';
import 'package:glp_manager_mobile/models/Branch.dart';
import 'package:glp_manager_mobile/models/GasCanister.dart';
import 'package:glp_manager_mobile/modules/dashboard/dashboard_page.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

import '../../components/already_have_an_account_acheck.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:glp_manager_mobile/components/card.dart';
import 'package:glp_manager_mobile/components/progress_line.dart';

class BotijaoPage extends StatefulWidget {
  const BotijaoPage({
    Key? key,
    required this.branch,
  }) : super(key: key);

  final Branch branch;

  @override
  State<BotijaoPage> createState() => _BotijaoPageState();
}

class _BotijaoPageState extends State<BotijaoPage> {
  @override
  Widget build(BuildContext context) {
    Branch branch = widget.branch;
    List<GasCanister> canisters = branch.canisters;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: const Text("GLP Manager"),
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
              iconOneName: 'Cilindros',
              iconTwoName: 'Usuários',
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: const Searcher(
              pleaceHolder: 'Procurar cilindro',
              title: 'cilindros',
            ),
          ),
          Expanded(
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
                    GasCanister canister = canisters[index];

                    return CardImgDescription(
                      title: canister.name,
                      subtitle: canister.description,
                      img: canister.img,
                      editIcon: true,
                      removeIcon: true,
                    );
                  },
                  // The separators
                  separatorBuilder: (context, index) {
                    return const Divider();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
