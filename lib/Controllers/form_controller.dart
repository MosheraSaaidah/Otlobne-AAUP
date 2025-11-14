import 'package:final_project/View/home.dart';
import 'package:final_project/view/login.dart';
import 'package:flutter/material.dart';

import 'package:final_project/view/student/student_home_page.dart';
import 'package:final_project/Models/user.dart';
import 'package:final_project/Models/user_manager.dart';

class FormController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Handle Registration
  void handleRegister(BuildContext context) {
    User newUser = User(
      userName: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (newUser.isValidEmail() && newUser.isValidPassword()) {
      bool success = UserManager().registerUser(newUser);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User registered successfully!")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Email already exists!")));
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid input!")));
    }
  }

  // Handle Login
  void handleLogin(BuildContext context) {
    String username = nameController.text.trim();
    String password = passwordController.text.trim();

    User? user = UserManager().login(username, password);
    if (user != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Welcome ${user.userName}!")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>student_home_page()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid username or password!")),
      );
    }
  }

  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
