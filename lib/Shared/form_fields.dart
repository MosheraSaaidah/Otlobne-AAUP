import 'package:flutter/material.dart';

class FormFields {
  static Widget buildNameField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
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

  static Widget buildEmailField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
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

  static Widget buildPasswordField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      obscureText: true,
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

  static Widget buildConfirmPasswordField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      obscureText: true,
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
}
