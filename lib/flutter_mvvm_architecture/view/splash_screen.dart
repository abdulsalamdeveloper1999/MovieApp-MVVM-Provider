import 'package:flutter/material.dart';

import '../resources/componnets/custom_sizebox.dart';
import '../resources/componnets/custom_text.dart';
import '../resources/utils/styles.dart';
import '../services/splash_services.dart';

class SplashScreenMvvm extends StatefulWidget {
  const SplashScreenMvvm({super.key});

  @override
  State<SplashScreenMvvm> createState() => _SplashScreenMvvmState();
}

class _SplashScreenMvvmState extends State<SplashScreenMvvm> {
  SplashServices services = SplashServices();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) {
      services.checkAuthentication(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kdarkBlueColor,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: 'Things Are Getting Ready',
                size: 22,
                weight: FontWeight.w500,
              ),
              Space(height: 16),
              CircularProgressIndicator(
                color: AppColors.kbuttonColor,
                backgroundColor: AppColors.kdarkBlueColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
