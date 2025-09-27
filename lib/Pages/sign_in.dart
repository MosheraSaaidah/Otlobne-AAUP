import 'package:flutter/material.dart';
import 'package:final_project/Controllers/form_controller.dart';
import 'package:final_project/Pages/sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('Forget password ?'),
                    ),
                    // SizedBox(width: 100),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: const Text('Create Account ?'),
                    ),
                  ],
                ),

                SizedBox(height: 60),
                signInButton(context, formKey),
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
