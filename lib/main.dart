import 'package:flutter/material.dart';
import 'package:flutter_medicalapp_desing/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Medical',
      theme: ThemeData().copyWith(
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: CustomColors().green, error: Colors.red),
          appBarTheme: const AppBarTheme(
              centerTitle: true, backgroundColor: Colors.white, elevation: 0),
          textTheme: const TextTheme(
              bodyMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              bodyLarge: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  fontSize: 20))),
      home: const Login(),
    );
  }
}

class CustomColors {
  final Color green = const Color.fromARGB(255, 25, 154, 141);
  final Color greyLight = const Color.fromARGB(255, 229, 231, 235);
  final Color greyDark = const Color.fromARGB(255, 170, 170, 170);
}
