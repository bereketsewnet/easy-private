import 'package:flutter/material.dart';

import '../colors.dart';

class CustomTextFormFeild extends StatelessWidget {
  final TextEditingController? controller;
  final String lable;
   const CustomTextFormFeild({super.key, required this.lable, this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          cursorColor: primary,
          controller: controller,
          style: const TextStyle(color: primary),
          decoration:  InputDecoration(
            labelText: lable,
            labelStyle: const TextStyle(color: primary),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: primary, // Set the focused bottom border color
                width: 2.0,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: primary, // Set the focused bottom border color
                width: 2.0,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your first name';
            }
            return null;
          },
        ),
      ),
    );
  }
}
