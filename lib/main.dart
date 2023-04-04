import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/res/color.dart';
import 'package:social_media_app/res/fonts.dart';
import 'package:social_media_app/utils/routes/route_name.dart';
import 'package:social_media_app/utils/routes/routes.dart';
import 'package:social_media_app/view/splash/splash_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.primaryMaterialColor,
        scaffoldBackgroundColor: AppColors.whiteColor,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: AppColors.whiteColor,
          iconTheme: IconThemeData(color: AppColors.blackColor),
          titleTextStyle: TextStyle(fontSize: 22, fontFamily: AppFonts.sfProDisplayMedium, color: AppColors.primaryTextTextColor),
        ),

        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 40, fontFamily: AppFonts.sfProDisplayMedium, fontWeight: FontWeight.w500),
          headline2: TextStyle(fontSize: 32, fontFamily: AppFonts.sfProDisplayBold, fontWeight: FontWeight.w500, color: AppColors.blackColor),
          headline3: TextStyle(fontSize: 28, fontFamily: AppFonts.sfProDisplayBold, fontWeight: FontWeight.w500),
          headline4: TextStyle(fontSize: 24, fontFamily: AppFonts.sfProDisplayMedium, fontWeight: FontWeight.w500),
          headline5: TextStyle(fontSize: 20, fontFamily: AppFonts.sfProDisplayMedium, fontWeight: FontWeight.w500),
          headline6: TextStyle(fontSize: 16, fontFamily: AppFonts.sfProDisplayBold, fontWeight: FontWeight.w700),

          bodyText1: TextStyle(fontSize: 16, fontFamily: AppFonts.sfProDisplayBold, fontWeight: FontWeight.w700),
          bodyText2: TextStyle(fontSize: 14, fontFamily: AppFonts.sfProDisplayRegular, fontWeight: FontWeight.w700),

          caption: TextStyle(fontSize: 12, fontFamily: AppFonts.sfProDisplayBold, fontWeight: FontWeight.w700, height: 2.26),
        )
      ),
      home: const SplashScreen(),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

