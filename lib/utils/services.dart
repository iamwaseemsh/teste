import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CustomServices {
  static showLoading() {
    EasyLoading.show(status: 'Loading...');
  }

  static dismissLoading() {
    EasyLoading.dismiss();
  }

  static showSnackBar(BuildContext context, String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: new Text(value),
      duration: Duration(milliseconds: 1500),
    ));
  }
}
