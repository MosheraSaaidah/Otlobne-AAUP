import 'package:flutter/material.dart';
import 'package:final_project/Pages/splash.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otlobne AAUP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cairo',
        primaryColor: Colors.amber,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.amber,
        ).copyWith(secondary: Colors.black),
        useMaterial3: true,
      ),
      home: Splash(),
    );
  }
}
