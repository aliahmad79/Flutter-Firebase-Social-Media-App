import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:social_media_app/view/Dashboard/chat/chat_screen.dart';
import 'package:social_media_app/view_model/services/session_manager.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("Users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users List"),
      ),
      body: SafeArea(
        child: FirebaseAnimatedList(
            query: ref, 
            itemBuilder: (context, snapshot, animation, index) {
             if(SessionController().userId.toString() == snapshot.child("uid").value.toString()){
               return Container();
             }
             else {
               return InkWell(
                 onTap: (){
                   PersistentNavBarNavigator.pushNewScreen(
                       context,
                       screen: ChatScreen(
                           name: snapshot.child("userName").value.toString(),
                           email: snapshot.child("email").value.toString(),
                           image: snapshot.child("profile").value.toString(),
                           receiverId: snapshot.child("uid").value.toString(),
                       ),
                     withNavBar: false,
                   );
                 },
                 child: Card(
                   child: ListTile(
                     leading: Container(
                       height: 40,
                       width: 40,
                       decoration: BoxDecoration(
                         border: Border.all(width: 2),
                             shape: BoxShape.circle,
                       ),
                       child: snapshot.child("profile").value.toString() == ""
                       ? const Center(child: Icon(Icons.person,size: 30))
                       :ClipRRect(
                         borderRadius: BorderRadius.circular(100),
                         child: Image.network(snapshot.child("profile").value.toString(),
                         fit: BoxFit.cover,),
                       ),
                     ),
                     title: Text(snapshot.child("userName").value.toString()),
                     subtitle: Text(snapshot.child("email").value.toString()),
                   ),
                 ),
               );
             }
            }
        ),
      ),
    );
  }
}
