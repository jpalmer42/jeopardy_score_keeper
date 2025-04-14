import 'package:flutter/material.dart';
import 'package:jeopardy_score_keeper/start_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
        useMaterial3: true,
        // textTheme: TextTheme(h),
      ),
      home: StartScreen(),
    );
  }
}
