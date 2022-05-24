import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  const BotijaoPage({Key? key}) : super(key: key);

  @override
  State<BotijaoPage> createState() => _BotijaoPageState();

  
}
 final List<String> _myList = List.generate(15, (index) => 'Botijão $index');
class _BotijaoPageState extends State<BotijaoPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          backgroundColor: AppColors.primary, title: const Text("GLP Manager")),
      body: Container(
        child: Column(
          children:<Widget>[
          
          Container(
            margin: EdgeInsets.only(top:20.0),
            child: Center(child:Text("Filial 1",style:TextStyle(fontWeight:FontWeight.bold,fontSize:24)),),),
            
            Expanded(
              
            child:Container(
              margin: EdgeInsets.only(top:100.0),
          child:ListView.separated(
              itemCount: _myList.length,
            // The list items
            itemBuilder: (context, index) {
              return Container(
                child:Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children:<Widget>[
                    Container(
                      margin:EdgeInsets.only(left:5),
                      child:Text(
                      _myList[index],
                style: const TextStyle(fontSize: 16),
                    ),
                    ),
                    Container(
                      child:Row(
                        children:<Widget>[
                          IconButton(
                            iconSize:20,
                            icon: Icon(
                          Icons.add,
                          color:Colors.green,
                          
                    ),
                          onPressed:(){
                            showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              height:MediaQuery.of(context).size.height*0.7,
                                padding:EdgeInsets.all(8),
                                   child: Column(
                                children:<Widget>[
                                    Text(
                                      "Dados do Botijão",style:TextStyle(fontSize:14,color:Colors.black,decoration:TextDecoration.none),
                                    ),
                                       Text(
                                      "20KG",style:TextStyle(fontSize:14,color:Colors.black,decoration:TextDecoration.none),
                                    ),
                                    Card(
                                      
                                       child:Column(
                                         
                                         children:<Widget>[
                                           
                                           Text(
                                             "Peso atual : 15KG",style:TextStyle(fontSize:14,color:Colors.black,decoration:TextDecoration.none),
                                           ),
                                           Container(
                                             padding:EdgeInsets.all(8),
                                              child: ProgressLine(
                                               
                                               color: Colors.green,
                                               percentage: 75),
                                           ),
                                          
                                         ],
                                       ),
                                       
                                       
                                       
                                       
                                       
                                    ),

                                ],
                              ),
                              
                              ),
);
                          }
                          ),
                        
                      IconButton(
                            iconSize:20,
                            icon: Icon(
                          Icons.delete,
                          color:Colors.red,
                          
                    ),
                          onPressed:(){
        showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              padding:EdgeInsets.all(8),
                              height:MediaQuery.of(context).size.height*0.2,
                              child: Column(
                                children:<Widget>[
                                    Text(
                                      "Deseja excluir este botijão?",style:TextStyle(fontSize:14,color:Colors.black,decoration:TextDecoration.none),
                                    ),
                                    RoundedButton(
                                      text:"Confirmar",
                                      color:Colors.red,
                                      press:(){
                                        setState((){
                                        _myList.removeAt(index);
                                        
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                ],
                              ),
                              ),
);

                          }
                          ),
                        ],
                      ),
                    ),
                  
                  ],
                ),
                
              );
            },
            // The separators
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.black,
              );  
            }),
          ),
          ),
            
          ],
        ),
        
       
      ),

    );
  }
}
