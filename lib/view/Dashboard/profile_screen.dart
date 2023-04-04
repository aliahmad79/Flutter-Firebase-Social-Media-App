import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/res/color.dart';
import 'package:social_media_app/view_model/ProfileController/profile_controller.dart';
import 'package:social_media_app/view_model/services/session_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref("Users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: ChangeNotifierProvider(
      create: (_) => ProfileController(),
      child: Consumer<ProfileController>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder(
              stream: ref.child(SessionController().userId.toString()).onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Center(
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.primaryIconColor,
                                    width: 5,
                                  )),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: provider.image == null
                                    ? map["profile"].toString() == ""
                                        ? const Icon(Icons.person)
                                        : Image(
                                            image: NetworkImage(
                                                map["profile"].toString()),
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            },
                                            errorBuilder:
                                                (context, object, stack) {
                                              return const Icon(
                                                Icons.error_outline,
                                                color: AppColors.alertColor,
                                              );
                                            },
                                          )
                                    : Stack(
                                      children: [
                                        Image.file(
                                            File(provider.image!.path).absolute,
                                            fit: BoxFit.cover,
                                          ),
                                        const Center(child: CircularProgressIndicator()),
                                      ],
                                    ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              provider.pickImage(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(left: 80.0),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: AppColors.primaryColor,
                                child: Icon(
                                  Icons.add,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      ReUseAbleRow(
                          title: "Name",
                          value: map["userName"],
                          icon: Icons.person,
                        onTap: (){
                            provider.updateNameDialog(context, map["userName"]);
                        },
                      ),
                      ReUseAbleRow(
                          title: "Phone",
                          value: map["phone"] == ""
                              ? "xxxx-xxxxxxx"
                              : map["phone"],
                          icon: Icons.phone,
                      onTap: (){
                            provider.updatePhoneDialog(context, map["phone"]);
                      },
                      ),
                      ReUseAbleRow(
                          title: "Email",
                          value: map["email"],
                          icon: Icons.email,
                      onTap: (){
                            provider.updateEmailDialog(context, map["email"]);
                      },
                      ),
                    ],
                  );
                } else {
                  return Center(
                      child: Text(
                    "Something went wrong",
                    style: Theme.of(context).textTheme.subtitle1,
                  ));
                }
              },
            ),
          );
        },
      ),
    ));
  }
}

class ReUseAbleRow extends StatelessWidget {
  final String title, value;
  final IconData icon;
  final VoidCallback onTap;
  const ReUseAbleRow(
      {Key? key, required this.title, required this.value, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          title: Text(title, style: Theme.of(context).textTheme.subtitle2),
          leading: Icon(
            icon,
            color: AppColors.primaryIconColor,
          ),
          trailing: Text(value, style: Theme.of(context).textTheme.subtitle2),
        ),
        const Divider(),
      ],
    );
  }
}
