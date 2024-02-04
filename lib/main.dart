import 'package:bmi/pages/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI',
      theme: const CupertinoThemeData(
        barBackgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.blueGrey,
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const MainPage(),
      },
    );
  }
}
