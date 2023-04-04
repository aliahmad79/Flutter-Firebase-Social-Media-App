import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/res/color.dart';
import 'package:social_media_app/utils/utils.dart';
import 'package:social_media_app/view_model/services/session_manager.dart';

class ChatScreen extends StatefulWidget {
  final String name, email, image, receiverId;
  const ChatScreen(
      {Key? key,
      required this.name,
      required this.email,
      required this.image,
      required this.receiverId,
      })
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();

  DatabaseReference ref = FirebaseDatabase.instance.ref().child("Chat");
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 10.0, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        height: 50,
                          width: width * 0.5,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: ListTile(
                            title: Text(index.toString(), style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.whiteColor),),
                          ),
                      ),
                    );
                  } ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    keyboardType: TextInputType.text,
                    cursorColor: AppColors.primaryTextTextColor,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(height: 0, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "enter message",
                      contentPadding: const EdgeInsets.all(15.0),
                      hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(height: 0, color: AppColors.primaryTextTextColor.withOpacity(0.5)),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.textFieldDefaultFocus),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:  BorderSide(color: AppColors.secondaryColor),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.alertColor),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.textFieldDefaultBorderColor),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
                InkWell(
                  onTap: (){
                    sendMessage();
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    child: Center(child: Icon(Icons.send)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  sendMessage(){
    if(messageController.text.isEmpty){
      Utils.toastMessage("Please Enter Your Message");
    }
    else{
      final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      ref.child(timeStamp).set({
        "isSeen": false,
        "message": messageController.text.toString(),
        "sender": SessionController().userId.toString(),
        "receiver": widget.receiverId,
        "type": "text",
        "time": timeStamp,
      }).then((value) {
        messageController.clear();
      });
    }
  }
}