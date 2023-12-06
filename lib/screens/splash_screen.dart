import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_keep/helpers/auth_helper.dart';
import 'package:note_keep/screens/home_screen.dart';
import 'package:note_keep/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;
  @override
  void initState() {
    getUserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void getUserStatus() async {
    isLoggedIn = await AuthHelper.instance.isLoggedIn();
    if (isLoggedIn) {
      Get.to(() => const HomeScreen());
    } else {
      Get.to(() => const LoginScreen());
    }
  }
}
