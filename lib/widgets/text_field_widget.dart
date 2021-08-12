import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  TextFieldWidget(this.controller);
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.grey,
      keyboardType: TextInputType.number,
      controller: controller,
      decoration: InputDecoration(
          labelText: 'Weight in Kg',
          labelStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 5)

          // prefix: widget.phoneType ? Text("+92") : null,
          ),
      style: TextStyle(color: Colors.black),
    );
  }
}
