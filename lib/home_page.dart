import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              const Text(
                '🎶 WORLDJAM',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Crée, partage et connecte-toi à la musique du monde',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 60),
              _buildMainButton(
                context,
                label: '🎵 Explorer les trames',
                color: Colors.blueAccent,
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              _buildMainButton(
                context,
                label: '🎙️ Créer une trame',
                color: Colors.purpleAccent,
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              _buildMainButton(
                context,
                label: '💬 Communauté',
                color: Colors.tealAccent,
                onPressed: () {},
              ),
              const Spacer(),
              const Text(
                'Connexion requise pour sauvegarder vos créations',
                style: TextStyle(color: Colors.white54, fontSize: 13),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  // prochaine étape : page login Supabase
                },
                child: const Text(
                  'Se connecter / S’inscrire',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainButton(
    BuildContext context, {
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.9),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
