import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media_app/utils/routes/route_name.dart';
import 'package:social_media_app/utils/utils.dart';
import 'package:social_media_app/view_model/services/session_manager.dart';

class SignUpController with ChangeNotifier{
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool val){
    _loading = val;
    notifyListeners();
  }

  void signUp(BuildContext context, String userName, email, password){
    FirebaseAuth auth = FirebaseAuth.instance;
    DatabaseReference ref = FirebaseDatabase.instance.ref().child("Users");

    setLoading(true);
    try{
      auth.createUserWithEmailAndPassword(email: email,
          password: password,
      ).then((value) {
        SessionController().userId = value.user!.uid.toString();
        ref.child(value.user!.uid.toString()).set({
          "uid": value.user!.uid.toString(),
          "email": value.user!.email.toString(),
          "onlineStatus": "no",
          "phone": "",
          "userName": userName,
          "profile": "",
        }).then((value) {
          setLoading(false);
          Utils.toastMessage("User Created Successfully");
          Navigator.pushNamed(context, RouteName.homeScreen);
        }).onError((error, stackTrace) {
          setLoading(false);
          Utils.toastMessage(error.toString());
        });

      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
      });
    }catch(e){
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}