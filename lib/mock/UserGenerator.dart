import 'package:glp_manager_mobile/models/User.dart';
class UserGenerator{
    List<User> users = [];

List<User> userGenerate(){
            User user1 = User();
    user1.name="José";
    user1.cpf="1111111";
    users.add(user1);
    User user2 = User();
      user2.name="Pedro";
    user2.cpf="222222";
    users.add(user2);
    User user3 = User();
      user3.name="Ana";
    user3.cpf="3333333";
    users.add(user3);
    User user4 = User();
      user4.name="Maria";
    user4.cpf="444444";
    users.add(user4);
    return users;

}
  List<User> getUsers(){

     return users;
 }
 setUsers(User user){
   users.add(user);
 }
}