import 'dart:ffi';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glp_manager_mobile/components/card_img_description.dart';
import 'package:glp_manager_mobile/components/header_img_description.dart';
import 'package:glp_manager_mobile/components/notification_bell.dart';
import 'package:glp_manager_mobile/components/searcher.dart';
import 'package:glp_manager_mobile/models/Branch.dart';
import 'package:glp_manager_mobile/models/Receipt.dart';
import 'package:glp_manager_mobile/modules/recipient/recipientController.dart';
import 'package:glp_manager_mobile/modules/recipient/userController.dart';
import 'package:glp_manager_mobile/models/User.dart';
import 'package:glp_manager_mobile/mock/UserGenerator.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:glp_manager_mobile/components/progress_line.dart';

enum cylindertype{p13, p20v3, p20v5, p45}
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
  TextEditingController exId = TextEditingController();
  TextEditingController gasType = TextEditingController();
  TextEditingController casco = TextEditingController();
  String desc = 'p13';


  TextEditingController userName = TextEditingController();
  TextEditingController userCpf = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPass = TextEditingController();
  TextEditingController userBirth = TextEditingController();
  List<User> allUsers = [];
  List<User> userQuery = [];
   Future<List<User>> futureUser = new userController().getUsers();
  Branch br = new Branch();
  Future<List<Receipt>> futureReceipt = new Future((){
    return [];
  });
  List<Receipt> cylinders =[];
  cylindertype? _ctype = cylindertype.p13;

    @override
  void initState() {
    super.initState();
     futuretolist();
  }
 
  Future futuretolist() async {
    allUsers = await futureUser;
    userQuery = await futureUser;
    print(allUsers.length);
     cylinders = await futureReceipt;
     
    setState((){
   
    });
    
    
  }

  userControl(String icon, Branch branch) {
    userQuery = allUsers;

    
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
              const Padding(padding: EdgeInsets.only(top: 10)),
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
              const Padding(padding: EdgeInsets.only(top: 10)),
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
              const Padding(padding: EdgeInsets.only(top: 10)),
              Material(
                //color:AppColors.primary,
                child: TextFormField(
                  controller: userPass,
                  decoration: InputDecoration(
                    labelText: "Senha do Usuário",
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
                child: TextFormField(
                  controller: userBirth,
                  decoration: InputDecoration(
                    labelText: "Data de nascimento do Usuário",
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
                  onPressed: () async{

                    

                    
                      User user = User();
                      user.name = userName.text;
                      user.cpf = userCpf.text;
                      user.email = userEmail.text;
                      user.pass = userPass.text;
                      String data = userBirth.text;
                      var splitdata =data.split('/');
                      user.birth = splitdata[2]+'-'+splitdata[1]+'-'+splitdata[0];
                      
                      
                      await new userController().createUser(user);
                    futureUser =new userController().getUsers();
                      

                      userName.text = "";
                      userCpf.text = "";
                      userEmail.text = "";
                      userPass.text = "";
                      userBirth.text = "";
                    futuretolist();
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
                removeAction: () async{
                        await new recipientController().deleteRecipient(canister,br.id);
                        futureReceipt =  recipientController().getRecipient(br.id);
                        futuretolist();
                 
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
                removeIcon: user.type=='employee'?true:false,
                //onCardClick: () => openCanisterView(canister),
                //editAction: () => openCanisterEditor(canister),
                removeAction: () async{
                  await new userController().deleteUser(user);
                  futureUser = new userController().getUsers();
                  futuretolist();
                  
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
    print(canister.actualWeight);
    double per = 0;
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
                      "Adicionar Usuário",
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.primary,
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
                      
                        const Padding(
                          padding: EdgeInsets.only(right: 26),
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
    
    
    name.text = canister.name;
    gasType.text = canister.gasType;
    desc = canister.type;
    switch(desc){
      case 'p13':
        _ctype = cylindertype.p13;
        break;
      case 'p20v3':
        _ctype = cylindertype.p20v3;
        break;
      case 'p20v5':
        _ctype = cylindertype.p20v5;
        break;
      case 'p45':
        _ctype = cylindertype.p45;
        break;
    }

  showCupertinoModalBottomSheet(
      context: context,
      builder: (context)  {
         return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalState) {
        return SizedBox(
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
                    controller: gasType,
                    decoration: InputDecoration(
                      labelText: "Tipo de gás",
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
               
              
                  
                 Material(child: ListTile(
                  
          title: SizedBox(
                width: 40,
                child: Text( 'p13')),
          leading: Radio<cylindertype>(
            value: cylindertype.p13,
            groupValue: _ctype,
            onChanged: (cylindertype? value) {
                setState((){
              desc = 'p13';
              });
              modalState(() {
                
                _ctype = value;
                print(_ctype);
              });
            },
          ),
        ),
        
        ),
         Material(child: ListTile(
                  
          title: SizedBox(
                width: 40,
                child: Text( 'p20v3')),
          leading: Radio<cylindertype>(
            value: cylindertype.p20v3,
            groupValue: _ctype,
            onChanged: (cylindertype? value) {
              setState((){
desc = 'p20v3';
              });
              
              modalState(() {
                
                _ctype = value;
                print(value);
              });
            },
          ),
        ),
        
        ),
          Material(child: ListTile(
                  
          title: SizedBox(
                width: 40,
                child: Text( 'p20v5')),
          leading: Radio<cylindertype>(
            value: cylindertype.p20v5,
            groupValue: _ctype,
            onChanged: (cylindertype? value) {
                setState((){
               desc = 'p20v5';
               });
              modalState(() {
               
                _ctype = value;
                print(_ctype);
              });
            },
          ),
        ),
        
        ),
        
        Material(child:
        ListTile(
          
           title: SizedBox(
                width: 40,
                child: Text( 'p45')),
          leading: Radio<cylindertype>(
            value: cylindertype.p45,
            groupValue: _ctype,
            onChanged: (cylindertype? value) {
                setState((){
              desc = 'p45';
              });
              modalState(() {
                
                _ctype = value;
                print(_ctype);
              });
            },
          ),
        ),
        ),
                  
                const Padding(padding: EdgeInsets.all(15)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: AppColors.primary),
                  onPressed: () async{
                    
                    canister.name = name.text;
                    canister.gasType =gasType.text;
                    canister.type = desc;
                    
                    canister.img =
                        "https://a-static.mlcdn.com.br/1500x1500/botijao-de-gas-13kg-liquigas/doisirmaosdistribuidora/d1a9bcc2593111ec9a154201ac18503a/8e2690349b445e82c17437d629fa10a0.jpg";
                        await  new recipientController().updateRecipient(canister,br.id);
                        
                      futureReceipt = new recipientController().getRecipient(br.id);
                      futuretolist();
                      name.text = "";
                      desc = 'p13';
                      gasType.text = "";
                    
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
      );
      },
      );
      },
    );
  }

  openCanisterCreator() {
    gasType.text = '';
    //exId.text = '';
    name.text = '';
    desc = 'p13';
    _ctype = cylindertype.p13;
    

    showCupertinoModalBottomSheet(
      context: context,
      builder: (context)  {
         return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalState) {
        return SizedBox(
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
                    controller: gasType,
                    decoration: InputDecoration(
                      labelText: "Tipo de gás",
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
               
              
                  
                 Material(child: ListTile(
                  
          title: SizedBox(
                width: 40,
                child: Text( 'p13')),
          leading: Radio<cylindertype>(
            value: cylindertype.p13,
            groupValue: _ctype,
            onChanged: (cylindertype? value) {
                setState((){
              desc = 'p13';
              });
              modalState(() {
                
                _ctype = value;
                print(_ctype);
              });
            },
          ),
        ),
        
        ),
         Material(child: ListTile(
                  
          title: SizedBox(
                width: 40,
                child: Text( 'p20v3')),
          leading: Radio<cylindertype>(
            value: cylindertype.p20v3,
            groupValue: _ctype,
            onChanged: (cylindertype? value) {
              setState((){
desc = 'p20v3';
              });
              
              modalState(() {
                
                _ctype = value;
                print(value);
              });
            },
          ),
        ),
        
        ),
          Material(child: ListTile(
                  
          title: SizedBox(
                width: 40,
                child: Text( 'p20v5')),
          leading: Radio<cylindertype>(
            value: cylindertype.p20v5,
            groupValue: _ctype,
            onChanged: (cylindertype? value) {
                setState((){
               desc = 'p20v5';
               });
              modalState(() {
               
                _ctype = value;
                print(_ctype);
              });
            },
          ),
        ),
        
        ),
        
        Material(child:
        ListTile(
          
           title: SizedBox(
                width: 40,
                child: Text( 'p45')),
          leading: Radio<cylindertype>(
            value: cylindertype.p45,
            groupValue: _ctype,
            onChanged: (cylindertype? value) {
                setState((){
              desc = 'p45';
              });
              modalState(() {
                
                _ctype = value;
                print(_ctype);
              });
            },
          ),
        ),
        ),
                  
                const Padding(padding: EdgeInsets.all(15)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: AppColors.primary),
                  onPressed: () async{
                    Receipt gas = Receipt();
                    gas.name = name.text;
                    gas.gasType =gasType.text;
                    gas.type = desc;
                    
                    gas.img =
                        "https://a-static.mlcdn.com.br/1500x1500/botijao-de-gas-13kg-liquigas/doisirmaosdistribuidora/d1a9bcc2593111ec9a154201ac18503a/8e2690349b445e82c17437d629fa10a0.jpg";
                        await  new recipientController().createRecipient(gas,br.id);
                        
                      futureReceipt = new recipientController().getRecipient(br.id);
                      futuretolist();
                      name.text = "";
                      desc = 'p13';
                      gasType.text = "";
                    
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
      );
      },
      );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Branch branch = widget.branch;
    List<Receipt> canisters = cylinders;
    
    if(br.id==''){futureReceipt =  new recipientController().getRecipient(widget.branch.id);

    futuretolist();
    }
    List<User> users = allUsers;
    br = branch;
    

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
            child: Searcher(
              pleaceHolder: selectedIcon=="one"?'Procurar recipientes...':'Procurar usuários...',
              title: 'recipientes',
            ),
          ),
          selectedIconChange(selectedIcon, branch, canisters, users),
        ],
      ),
    );
  }
}
