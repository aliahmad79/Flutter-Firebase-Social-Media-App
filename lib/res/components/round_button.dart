import 'package:flutter/material.dart';
import 'package:social_media_app/res/color.dart';

class AppRoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final Color buttonColor;
  final Color textColor;
  final bool isLoading;

  const AppRoundButton({
    Key? key,
    required this.title,
    required this.onPress,
    this.buttonColor = AppColors.primaryColor,
    this.textColor = AppColors.whiteColor,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onPress,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator(color: AppColors.whiteColor,))
            : Center(
              child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: 22, color: textColor),
                ),
            ),
      ),
    );
  }
}
