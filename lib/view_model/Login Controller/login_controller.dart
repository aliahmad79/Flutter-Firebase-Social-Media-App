import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media_app/utils/routes/route_name.dart';
import 'package:social_media_app/utils/utils.dart';
import 'package:social_media_app/view_model/services/session_manager.dart';

class LoginController with ChangeNotifier{
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool val){
    _loading = val;
    notifyListeners();
  }

  void login(BuildContext context, String email, password){
    FirebaseAuth auth = FirebaseAuth.instance;

    setLoading(true);
    try{
      auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) {
        SessionController().userId = value.user!.uid.toString();
        setLoading(false);
        Utils.toastMessage("Login Successfully");
        Navigator.pushNamed(context, RouteName.homeScreen);
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