import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const TahadyApp());
}

class TahadyApp extends StatelessWidget {
  const TahadyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "تحدي الأصحاب",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1A0A2A),
        fontFamily: 'monospace',
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFFD54A),
          secondary: Color(0xFFFF6B6B),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}