import 'package:flutter/material.dart';
import 'package:final_project/Controllers/form_controller.dart';
import 'package:final_project/View/login.dart';
import 'package:final_project/Shared/form_fields.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
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
                const SizedBox(height: 12),
                FormFields.buildConfirmPasswordField(
                  _controller.confirmPasswordController,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: const Text('Have Account ?'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _controller.handleRegister(context);
                    }
                  },
                  child: const Text("Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
