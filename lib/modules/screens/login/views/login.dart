// ignore_for_file: non_constant_identifier_names, duplicate_ignore

import 'dart:developer';
import 'package:chat_app_11/modules/screens/login/controllers/login_controller.dart';
import 'package:chat_app_11/modules/screens/login/model/login_model.dart';
import 'package:chat_app_11/modules/utils/constants/colors.dart';
import 'package:chat_app_11/modules/utils/helpers/auth_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/components.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  Login({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController s_emailController = TextEditingController();
  TextEditingController s_passwordController = TextEditingController();
  String? email;
  String? password;
  LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          "Login",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                  "https://i.pinimg.com/originals/4e/79/b7/4e79b7a983c01df927b8d0f42e799b35.gif"),
              emailTextField(textEditingController: emailController),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<LoginController>(
                builder: (_) => passwordTextField(
                    textEditingController: passwordController),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: myButtonStyle(),
                onPressed: login,
                child: Text(
                  "Login",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: myButtonStyle(bg_color: Colors.black),
                onPressed: aninymous,
                child: Text(
                  "Sign in Anonymously",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: myButtonStyle(bg_color: grey),
                onPressed: signup,
                child: Text(
                  "Sign Up",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //todo:login with email and password
  login() async {
    emailController.clear();
    passwordController.clear();

    // ignore: unused_local_variable
    LoginCredentials loginCredentials =
        LoginCredentials(email: email!, password: password!);

    Map<String, dynamic> res =
        await AuthHelper.authHelper.signIn(loginCredentials: loginCredentials);
    if (res['error'] != null) {
      log("login failed");
      Fluttertoast.showToast(msg: "Login Failed");
    } else {
      Fluttertoast.showToast(msg: "Login Success");
      Get.offAndToNamed('/home');
    }
  }

  TextStyle poppinsTextStyle({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      );
  //todo:Sign up User
  signup() async {
    Get.defaultDialog(
      backgroundColor: white,
      title: "Flutter Chat App",
      titleStyle: poppinsTextStyle(),
      content: Column(
        children: [
          emailTextField(textEditingController: s_emailController),
          const SizedBox(
            height: 20,
          ),
          passwordTextField(textEditingController: s_passwordController),
        ],
      ),
      confirm: ElevatedButton(
        style: myButtonStyle(),
        onPressed: register_btn,
        child: Text(
          "Register",
          style: poppinsTextStyle(color: white),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  register_btn() async {
    LoginCredentials loginCredentials =
        LoginCredentials(email: email!, password: password!);
    Map<String, dynamic> res =
        await AuthHelper.authHelper.signUp(loginCredential: loginCredentials);
    if (res['error'] != null) {
      log("signup failed");
    } else {
      s_emailController.clear();
      s_passwordController.clear();
      Get.back();
      log("signup sucess");
    }
  }

  //todo:email field
  emailTextField({required TextEditingController textEditingController}) =>
      TextFormField(
        controller: textEditingController,
        onChanged: (val) {
          email = val;
        },
        decoration: InputDecoration(
          border: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
          hintText: "enter email...",
          labelText: 'Email',
          labelStyle: textStyle(),
        ),
      );

//todo: password field
  passwordTextField({required TextEditingController textEditingController}) =>
      TextFormField(
        obscureText: controller.password.isVisible,
        controller: textEditingController,
        onChanged: (val) {
          password = val;
        },
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              controller.changeVisiblity();
            },
            icon: Icon(
              (controller.password.isVisible)
                  ? CupertinoIcons.eye
                  : CupertinoIcons.eye_slash,
            ),
          ),
          border: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
          hintText: "enter password...",
          labelText: 'Password',
          labelStyle: textStyle(),
        ),
      );
}
