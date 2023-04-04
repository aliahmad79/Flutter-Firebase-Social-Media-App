import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media_app/utils/routes/route_name.dart';
import 'package:social_media_app/utils/utils.dart';
import 'package:social_media_app/view_model/services/session_manager.dart';

class ForgotPasswordController with ChangeNotifier{
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool val){
    _loading = val;
    notifyListeners();
  }

  void forgotPassword(BuildContext context, String email){
    FirebaseAuth auth = FirebaseAuth.instance;

    setLoading(true);
    try{
      auth.sendPasswordResetEmail(
        email: email,
      ).then((value) {
        setLoading(false);
        Navigator.pushNamed(context, RouteName.loginScreen);
        Utils.toastMessage("Please check your email to recover your password");
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