import 'package:flutter/material.dart';
import 'package:final_project/view/registration.dart';
import 'package:final_project/Shared/form_fields.dart';
import 'package:final_project/Controllers/form_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final FormController _controller = FormController();

  @override
  void dispose() {
    _controller.disposeControllers();
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
                FormFields.buildNameField(_controller.nameController),
                const SizedBox(height: 12),
                FormFields.buildEmailField(_controller.emailController),
                const SizedBox(height: 12),
                FormFields.buildPasswordField(_controller.passwordController),
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Registration(),
                          ),
                        );
                      },
                      child: const Text('Create Account ?'),
                    ),
                  ],
                ),

                SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _controller.handleLogin(context);
                    }
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// Widget Login() {

// }
