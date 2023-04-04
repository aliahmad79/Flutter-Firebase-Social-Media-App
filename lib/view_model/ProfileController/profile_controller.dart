import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/res/color.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_media_app/res/components/input_form_text_field.dart';
import 'package:social_media_app/utils/utils.dart';

import '../services/session_manager.dart';

class ProfileController with ChangeNotifier {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  final nameFocus = FocusNode();
  final phoneFocus = FocusNode();
  final emailFocus = FocusNode();

  DatabaseReference ref = FirebaseDatabase.instance.ref().child("Users");
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  final picker = ImagePicker();

  XFile? _image;
  XFile? get image => _image;

  Future pickImageFromCamera(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImageToFirebaseStorage(context);
      notifyListeners();
    }
  }

  Future pickImageFromGallery(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImageToFirebaseStorage(context);
      notifyListeners();
    }
  }

  void pickImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera,
                      color: AppColors.primaryIconColor),
                  title: Text("Camera",
                      style: Theme.of(context).textTheme.subtitle2),
                  onTap: () {
                    pickImageFromCamera(context);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image,
                      color: AppColors.primaryIconColor),
                  title: Text("Gallery",
                      style: Theme.of(context).textTheme.subtitle2),
                  onTap: () {
                    pickImageFromGallery(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  void uploadImageToFirebaseStorage(BuildContext context) async {
    setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref("/profileImage${SessionController().userId.toString()}");
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);
    await Future.value(uploadTask);
    final newURL = await storageRef.getDownloadURL();

    ref.child(SessionController().userId.toString()).update({
      "profile": newURL.toString(),
    }).then((value) {
      Utils.toastMessage("Image uploaded Successfully");
      setLoading(false);
      _image = null;
    }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
      setLoading(false);
    });
  }

  Future<void> updateNameDialog(BuildContext context, String name) {
    nameController.text = name;
   return  showDialog(
       context: context,
       builder: (context) {
         return AlertDialog(
           title: const Center(child: Text("Update User Name")),
           content: SingleChildScrollView(
             child: Column(
               children: [
                 InputTextFormField(
                   controller: nameController,
                   focusNode: nameFocus,
                   onFieldSubmitValue: (val) {},
                   validator: (val) {},
                   keyBoardType: TextInputType.text,
                   hintText: "User Name",
                 ),
               ],
             ),
           ),
           actions: [
             TextButton(
               onPressed: () {
                 Navigator.pop(context);
               },
               child: Text(
                 "Cancel",
                 style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppColors.alertColor),
               ),
             ),
             TextButton(
               onPressed: () {
                 ref.child(SessionController().userId.toString()).update({
                   "userName": nameController.text.toString(),
                 }).then((value){
                   nameController.clear();
                   Utils.toastMessage("Name updated successfully");
                   Navigator.pop(context);
                 });
               },
               child: Text(
                 "Ok",
                 style: Theme.of(context).textTheme.subtitle2,
               ),
             ),
           ],
         );
       });
  }

  Future<void> updatePhoneDialog(BuildContext context, String phone) {
    phoneController.text = phone;
    return  showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text("Update Phone Number")),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextFormField(
                    controller: phoneController,
                    focusNode: phoneFocus,
                    onFieldSubmitValue: (val) {},
                    validator: (val) {},
                    keyBoardType: TextInputType.text,
                    hintText: "Phone",
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppColors.alertColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.child(SessionController().userId.toString()).update({
                    "phone": phoneController.text.toString(),
                  }).then((value){
                    phoneController.clear();
                    Utils.toastMessage("Phone updated successfully");
                    Navigator.pop(context);
                  });
                },
                child: Text(
                  "Ok",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ],
          );
        });
  }

  Future<void> updateEmailDialog(BuildContext context, String email) {
    emailController.text = email;
    return  showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text("Update Email")),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextFormField(
                    controller: emailController,
                    focusNode: emailFocus,
                    onFieldSubmitValue: (val) {},
                    validator: (val) {},
                    keyBoardType: TextInputType.text,
                    hintText: "Email",
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppColors.alertColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.child(SessionController().userId.toString()).update({
                    "email": emailController.text.toString(),
                  }).then((value){
                    emailController.clear();
                    Utils.toastMessage("Email updated successfully");
                    Navigator.pop(context);
                  });
                },
                child: Text(
                  "Ok",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ],
          );
        });
  }
}
