import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/contants/constants.dart';
import 'package:weight_app/providers/data_provider.dart';
import 'package:weight_app/screens/splash_screen.dart';

import 'contants/configs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configLoading();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        builder: EasyLoading.init(),
        theme: ThemeData.light().copyWith(primaryColor: kSecondaryColor),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
