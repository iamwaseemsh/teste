import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/contants/constants.dart';
import 'package:weight_app/providers/data_provider.dart';
import 'package:weight_app/resources/firebase_methods.dart';
import 'package:weight_app/screens/home_screen.dart';
import 'package:weight_app/screens/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  setApp() {}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1), () async {
      if (FirebaseMethods.getCurrentUser() != null) {
        await Provider.of<DataProvider>(context, listen: false).getAllItems();
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.leftToRight, child: HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.leftToRight, child: SignInScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        child: JelloIn(
          child: Center(
            child: Image.asset(
              'assets/images/splash.png',
              width: 150,
            ),
          ),
        ),
      ),
    );
  }
}
