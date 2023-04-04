import 'package:flutter/material.dart';
import 'package:social_media_app/res/color.dart';

class InputTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FormFieldSetter onFieldSubmitValue;
  final FormFieldValidator validator;
  final TextInputType keyBoardType;
  final String hintText;
  final bool enable;
  final bool autoFocus;
  final bool obscureText;
  const InputTextFormField(
      {Key? key,
      required this.controller,
      required this.focusNode,
      required this.onFieldSubmitValue,
      required this.validator,
      required this.keyBoardType,
      required this.hintText,
        this.enable = true,
       this.autoFocus = false,
      this.obscureText = false,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyBoardType,
      onFieldSubmitted: onFieldSubmitValue,
      cursorColor: AppColors.primaryTextTextColor,
      style: Theme.of(context).textTheme.bodyText2!.copyWith(height: 0, fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.all(15.0),
        hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(height: 0, color: AppColors.primaryTextTextColor.withOpacity(0.5)),
        enabled: enable,
        border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.textFieldDefaultFocus),
        borderRadius: BorderRadius.circular(8.0),
      ),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(color: AppColors.secondaryColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.alertColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.textFieldDefaultBorderColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
