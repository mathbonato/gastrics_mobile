import 'dart:ffi';
import 'dart:math';

import 'package:glp_manager_mobile/models/Branch.dart';
import 'package:glp_manager_mobile/models/GasCanister.dart';

class BranchGenerator {
  final List<String> _branchFirstName = [
    'Costelão',
    'Bar',
    'Lanchonete',
    'Padaria'
  ];

  final List<String> _branchSecondName = [
    'do Ídio',
    'da Derosso',
    'da Tia Maria'
  ];

  final List<String> _firstStreetName = ['Marechal', 'Avenida', 'Rua'];

  final List<String> _secondStreetName = ['Deodoro', 'Pedreira', 'da Lua'];

  final List<String> _canisterLocation = ['Cozinha', 'Dispensa', 'Grade'];

  List<Branch> getBranches() {
    List<Branch> branches = [];

    int numOfBranches = 20;
    int qtdFirstNames = _branchFirstName.length;
    int qtdSecondNames = _branchSecondName.length;
    int qtdStreetFirstNames = _firstStreetName.length;
    int qtdStreetSecondNames = _secondStreetName.length;

    for (var i = 0; i < numOfBranches; i++) {
      Branch branch = Branch();

      int randomQttOfCanisters = Random().nextInt(9) + 1;

      int randomFirstNameNum = Random().nextInt(qtdFirstNames - 1);
      String randomFirstName = _branchFirstName[randomFirstNameNum];

      int randomSecondNameNum = Random().nextInt(qtdSecondNames - 1);
      String randomSecondName = _branchSecondName[randomSecondNameNum];

      int randomFirstStreetNameNum = Random().nextInt(qtdStreetFirstNames);
      String randomFirstStreetName = _firstStreetName[randomFirstStreetNameNum];

      int randomSecondStreetNameNum = Random().nextInt(qtdStreetSecondNames);
      String randomSecondStreetName =
          _secondStreetName[randomSecondStreetNameNum];

      branch.name = randomFirstName + ' ' + randomSecondName;
      branch.street = randomFirstStreetName + ' ' + randomSecondStreetName;
      branch.img =
          'https://xerpay.com.br/blog/wp-content/uploads/sites/2/2019/06/empresas-do-futuro.jpg';
      branch.canisters = _generateCanisters(randomQttOfCanisters);

      branches.add(branch);
    }

    return branches;
  }

  List<GasCanister> _generateCanisters(int qtdOfCanister) {
    List<GasCanister> canisters = [];

    int qtdOfLocations = _canisterLocation.length;

    for (int i = 0; i < qtdOfCanister; i++) {
      GasCanister canister = GasCanister();

      int randomCanisterLocationNum = Random().nextInt(qtdOfLocations);
      String randomCanisterName = _canisterLocation[randomCanisterLocationNum];

      double canisterHullWeight = (Random().nextDouble() * 20) + 20;
      double canisterTotalWeight =
          (Random().nextDouble() * 20) + canisterHullWeight;
      double canisterActualWeight =
          (Random().nextDouble() * (canisterTotalWeight - canisterHullWeight)) +
              canisterHullWeight;

      canister.name = randomCanisterName;
      canister.description = 'Random description';
      canister.actualWeight = canisterActualWeight;
      canister.gasHullWeight = canisterHullWeight;
      canister.totalWeight = canisterTotalWeight;
      canister.img =
          'https://a-static.mlcdn.com.br/1500x1500/botijao-de-gas-13kg-liquigas/doisirmaosdistribuidora/d1a9bcc2593111ec9a154201ac18503a/8e2690349b445e82c17437d629fa10a0.jpg';

      canisters.add(canister);
    }

    return canisters;
  }
}
