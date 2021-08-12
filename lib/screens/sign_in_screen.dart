import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/contants/constants.dart';
import 'package:weight_app/providers/data_provider.dart';
import 'package:weight_app/resources/firebase_methods.dart';
import 'package:weight_app/screens/home_screen.dart';
import 'package:weight_app/utils/services.dart';
import 'package:weight_app/widgets/main_button.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FadeInLeft(
                  child: Text(
                    "Welcome",
                    style: kHeadingStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FadeInUp(
                    child: MainElevatedButton(
                        text: 'Signin',
                        onPressed: () => _signInCallBack(context)))
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signInCallBack(context) async {
    User? user = await FirebaseMethods.signIn();
    Provider.of<DataProvider>(context, listen: false).getAllItems();
    CustomServices.dismissLoading();
    if (user != null) {
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.leftToRight, child: HomeScreen()));
    }
  }
}
