import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../../utils/helpers/auth_helper.dart';

//todo:login button click
aninymous() async {
  Map<String, dynamic> res = await AuthHelper.authHelper.signInAninyymous();
  if (res['error'] != null) {
    log("login failed");
  } else {
    log("login success");
  }
}

//todo: buttonstyle
myButtonStyle({Color bg_color = Colors.orange}) {
  return ButtonStyle(
    elevation: const MaterialStatePropertyAll(10),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    textStyle: const MaterialStatePropertyAll<TextStyle>(
      TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    ),
    backgroundColor: MaterialStatePropertyAll(bg_color),
    minimumSize: const MaterialStatePropertyAll(
      Size(350, 50),
    ),
  );
}

//todo:outline border
OutlineInputBorder outlineInputBorder() => const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    );

//todo:labeltextstyle
TextStyle textStyle() => const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
