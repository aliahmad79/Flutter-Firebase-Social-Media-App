
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/view_model/services/session_manager.dart';

import '../../utils/routes/route_name.dart';

class SplashServices{
  
  void isLogin(BuildContext context){
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user != null){
      SessionController().userId = user.uid.toString();
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, RouteName.homeScreen);
      });
    }
    else{
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, RouteName.loginScreen);
      });
    }

  }
}