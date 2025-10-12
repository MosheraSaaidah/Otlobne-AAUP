import 'package:flutter/material.dart';
import 'package:final_project/view/Login.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
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
            SizedBox(height: 30),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },

              icon: const Icon(
                Icons.arrow_right_alt_outlined,
                size: 80,
                color: Color.fromARGB(197, 22, 22, 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
