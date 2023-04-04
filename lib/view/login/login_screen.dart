import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/res/components/input_form_text_field.dart';
import 'package:social_media_app/res/components/round_button.dart';
import 'package:social_media_app/utils/routes/route_name.dart';
import 'package:social_media_app/view_model/Login%20Controller/login_controller.dart';

import '../../res/color.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * .03),
                Text(
                  "Welcome to App",
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: AppColors.blackColor),
                ),
                SizedBox(height: height * .01),
                Text(
                  "Please provide email and password\n to login to your account.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(height: height * .06),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputTextFormField(
                          controller: emailController,
                          focusNode: emailFocusNode,
                          onFieldSubmitValue: (val) {},
                          validator: (val) {
                            return val.isEmpty
                                ? "Please enter email address"
                                : null;
                          },
                          keyBoardType: TextInputType.emailAddress,
                          hintText: "Email Address",
                        ),
                        SizedBox(height: height * .03),
                        InputTextFormField(
                          controller: passwordController,
                          focusNode: passwordFocusNode,
                          onFieldSubmitValue: (val) {},
                          validator: (val) {
                            return val.isEmpty
                                ? "Please enter your password"
                                : null;
                          },
                          keyBoardType: TextInputType.text,
                          hintText: "Password",
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, RouteName.forgotPasswordScreen);
                      },
                      child: Text(
                        "Forgot Password?",
                        style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 15,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                ChangeNotifierProvider(
                  create: (_) => LoginController(),
                  child: Consumer<LoginController>(
                    builder: (context, provider, child){
                      return AppRoundButton(
                          title: "Login",
                          isLoading: provider.loading,
                          onPress: () {
                            if(_formKey.currentState!.validate()){
                              provider.login(
                                  context,
                                  emailController.text,
                                  passwordController.text,
                              );
                            }
                          });
                    },
                  ),
                ),
                SizedBox(height: height * .03),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, RouteName.signUpScreen);
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: Theme.of(context).textTheme.subtitle1,
                      children: [
                        TextSpan(
                          text: " SignUp",
                          style: Theme.of(context).textTheme.headline2!.copyWith(
                              fontSize: 15, decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
