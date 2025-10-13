import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_page.dart';
import 'login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://<ton-projet>.supabase.co', // remplace par ton URL
    anonKey: '<ta-clé-anon>', // remplace par ta clé anon
  );

  runApp(const WorldJamApp());
}

class WorldJamApp extends StatelessWidget {
  const WorldJamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WorldJam',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Colors.deepPurpleAccent,
          secondary: Colors.blueAccent,
        ),
      ),
      home: const HomePage(),
      routes: {'/login': (_) => const LoginPage()},
    );
  }
}
