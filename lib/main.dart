import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const WorldJamApp());
}

class WorldJamApp extends StatelessWidget {
  const WorldJamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WorldJam',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
