import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_page.dart';
import 'login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ehznlzhhlpwhzukbotmw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVoem5semhobHB3aHp1a2JvdG13Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ5MTA1NDEsImV4cCI6MjA3MDQ4NjU0MX0.avTP0K98VwK9JCxPZp4KzPyDneqkE5XfcRn09Hfg2K0',
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
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _startSessionCheck();
  }

  Future<void> _startSessionCheck() async {
    await Future.delayed(const Duration(milliseconds: 400));
    final session = Supabase.instance.client.auth.currentSession;

    if (!mounted) return;

    final nextPage = session != null ? const HomePage() : const LoginPage();

    // on exécute la navigation au prochain frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => nextPage));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }
}
