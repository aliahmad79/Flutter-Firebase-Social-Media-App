import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/utils/routes/route_name.dart';
import 'package:social_media_app/utils/utils.dart';
import 'package:social_media_app/view_model/SignUp%20Controller/sign_up_controller.dart';

import '../../res/color.dart';
import '../../res/components/input_form_text_field.dart';
import '../../res/components/round_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => SignUpController(),
          child: Consumer<SignUpController>(
            builder: (context, provider, child){
              return SingleChildScrollView(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
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
                        "Please provide the following details\n to register your account.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(height: height * .06),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              InputTextFormField(
                                controller: nameController,
                                focusNode: nameFocusNode,
                                onFieldSubmitValue: (val) {
                                  Utils.focusField(context, nameFocusNode, emailFocusNode);
                                },
                                validator: (val) {
                                  return val.isEmpty
                                      ? "Please enter your name "
                                      : null;
                                },
                                keyBoardType: TextInputType.emailAddress,
                                hintText: "User Name",
                              ),
                              SizedBox(height: height * .03),
                              InputTextFormField(
                                controller: emailController,
                                focusNode: emailFocusNode,
                                onFieldSubmitValue: (val) {
                                  Utils.focusField(context, emailFocusNode, passwordFocusNode);
                                },
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
                                obscureText: true,
                                onFieldSubmitValue: (val) {
                                },
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
                      const SizedBox(height: 50),
                      AppRoundButton(
                        isLoading: provider.loading,
                          title: "SignUp",
                          onPress: () {
                        if(_formKey.currentState!.validate()){
                          provider.signUp(
                              context,
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                          );
                        }
                      }),
                      SizedBox(height: height * .03),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, RouteName.loginScreen);
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "Don't have an account? ",
                            style: Theme.of(context).textTheme.subtitle1,
                            children: [
                              TextSpan(
                                text: " Login",
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
              );
            },
          ),
        ),
      ),
    );
  }
}
