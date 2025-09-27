import 'package:flutter/material.dart';
import 'package:final_project/Controllers/form_controller.dart';
import 'package:final_project/Pages/sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Otlobne.png',
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
                buildNameField(),
                SizedBox(height: 15),
                buildEmailField(),
                SizedBox(height: 15),
                buildPasswordField(),
                SizedBox(height: 15),
                buildConfirmPasswordField(),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  child: const Text('Have Account ?'),
                ),

                SizedBox(height: 20),
                signUpButton(context, formKey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// Widget signIn() {

// }
