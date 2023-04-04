import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/color.dart';
import '../../res/components/input_form_text_field.dart';
import '../../res/components/round_button.dart';
import '../../view_model/Forgot Password Controller/forgot_password_controller.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(elevation: 0),
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
                  "Forgot Password",
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: AppColors.blackColor),
                ),
                SizedBox(height: height * .01),
                Text(
                  "Please enter your email\n to recover your account.",
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
                      ],
                    )),
                const SizedBox(height: 50),
                ChangeNotifierProvider(
                    create: (_) => ForgotPasswordController(),
                  child: Consumer<ForgotPasswordController>(
                    builder: (context, provider,child){
                      return AppRoundButton(
                          title: "Recover",
                          isLoading: provider.loading,
                          onPress: () {
                            if(_formKey.currentState!.validate()){
                              provider.forgotPassword(context, emailController.text);
                            }
                          });
                    },
                  ),
                ),
                SizedBox(height: height * .03),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
