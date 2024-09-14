import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:helmsman/Frontend/Src/Auth/login_src.dart';
import 'package:helmsman/Frontend/Src/Dashboard/dashboard_src.dart';
import 'package:helmsman/Frontend/Utils/app_helper.dart';

class SplashScr extends StatefulWidget {
  const SplashScr({super.key});

  @override
  State<SplashScr> createState() => _SplashScrState();
}

class _SplashScrState extends State<SplashScr> {

  final box = GetStorage();

  @override
  void initState() {
    checkAuth();
    super.initState();
  }

  void checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    var token = box.read('accessToken');
    if (token == null || token.isEmpty) {
      Get.offAll(() => const LoginSrc());
    } else {
      Get.offAll(() => const DashboardSrc());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: ColorHelper.primaryColor),
              const SizedBox(height: 20),
              Text(
                'Checking Authentication...',
                style: TextStyle(
                  color: ColorHelper.primaryColor,
                  fontSize: 18, // Text size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
