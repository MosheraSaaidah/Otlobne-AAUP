import 'package:flutter/material.dart';

import 'package:final_project/Pages/sign_in.dart';
import 'package:final_project/Pages/home.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmpasswordController = TextEditingController();

Widget buildNameField() {
  return TextFormField(
    controller: nameController,
    decoration: InputDecoration(
      labelText: 'Name',
      hintText: 'Enter your name',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 18, 18, 18),
          width: 1.0,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 18, 18, 18),
          width: 1.0,
        ),
      ),

      floatingLabelBehavior: FloatingLabelBehavior.auto,
      prefixIcon: const Icon(Icons.person),
    ),

    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your name';
      }
      return null;
    },
  );
}

Widget buildEmailField() {
  return TextFormField(
    controller: emailController,
    decoration: InputDecoration(
      labelText: 'Email',
      hintText: 'Enter your Email',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 18, 18, 18),
          width: 1.0,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 18, 18, 18),
          width: 1.0,
        ),
      ),

      floatingLabelBehavior: FloatingLabelBehavior.auto,
      prefixIcon: const Icon(
        Icons.email,
        color: Color.fromARGB(179, 16, 15, 15),
      ),
    ),

    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
      }
      return null;
    },
  );
}

Widget buildPasswordField() {
  return TextFormField(
    controller: passwordController,

    decoration: InputDecoration(
      labelText: 'Password',
      hintText: 'Enter your Password',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 18, 18, 18),
          width: 1.0,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 18, 18, 18),
          width: 1.0,
        ),
      ),

      floatingLabelBehavior: FloatingLabelBehavior.auto,
      prefixIcon: const Icon(
        Icons.password,
        color: Color.fromARGB(179, 16, 15, 15),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter Password';
      }
      return null;
    },
  );
}

Widget buildConfirmPasswordField() {
  return TextFormField(
    controller: confirmpasswordController,

    decoration: InputDecoration(
      labelText: 'Confirm Password',
      hintText: 'Confirm your Password',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 18, 18, 18),
          width: 1.0,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 18, 18, 18),
          width: 1.0,
        ),
      ),

      floatingLabelBehavior: FloatingLabelBehavior.auto,
      prefixIcon: const Icon(
        Icons.password,
        color: Color.fromARGB(179, 16, 15, 15),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please confirm your password1';
      }
      return null;
    },
  );
}

Widget signInButton(BuildContext context, GlobalKey<FormState> formKey) {
  return SizedBox(
    width: 300,
    height: 55,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: const Color.fromARGB(255, 22, 22, 22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),

        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),

      onPressed: () {
        if (formKey.currentState!.validate()) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        }
      },
      child: Text('Sign in '),
    ),
  );
}

Widget signUpButton(BuildContext context, GlobalKey<FormState> formKey) {
  return SizedBox(
    width: 300,
    height: 55,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: const Color.fromARGB(255, 22, 22, 22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),

        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          if (passwordController.text != confirmpasswordController.text) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Passwords do not match")),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignIn()),
            );
          }
        }
      },
      child: Text('Sign up '),
    ),
  );
}

void disposeControllers() {
  nameController.dispose();
  emailController.dispose();
  passwordController.dispose();
}
