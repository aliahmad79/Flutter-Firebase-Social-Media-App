
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";
import 'package:social_media_app/view/Dashboard/Users/users_list.dart';
import 'package:social_media_app/view/Dashboard/profile_screen.dart';

import '../../res/color.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
       const UsersList(),
      const Center(child: Text("Chat")),
      const Center(child: Text("Add")),
      const Center(child: Text("Message")),
    const ProfileScreen(),
  ];
 }

 List<PersistentBottomNavBarItem> _items(){
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.primaryTextTextColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.chat),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.primaryTextTextColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.add, color: AppColors.whiteColor,),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.whiteColor,
        inactiveIcon: const Icon(Icons.add, color: AppColors.whiteColor,)
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.chat),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.primaryTextTextColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.primaryTextTextColor,
      ),
    ];
 }
  @override
  Widget build(BuildContext context) {
    return  PersistentTabView(
        context,
        controller: controller,
        screens: _buildScreens(),
        items: _items(),
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(1),
        ),
        navBarStyle: NavBarStyle.style15,

    );
  }
}
