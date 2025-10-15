import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:audioplayers/audioplayers.dart';

class ExploreTracksPage extends StatefulWidget {
  const ExploreTracksPage({super.key});

  @override
  State<ExploreTracksPage> createState() => _ExploreTracksPageState();
}

class _ExploreTracksPageState extends State<ExploreTracksPage> {
  final _supabase = Supabase.instance.client;
  final AudioPlayer _player = AudioPlayer();
  List<Map<String, dynamic>> _tracks = [];
  bool _loading = true;
  String? _playingUrl;

  @override
  void initState() {
    super.initState();
    _loadTracks();
  }

  Future<void> _loadTracks() async {
    try {
      final files = await _supabase.storage.from('tracks').list();
      final publicUrls = files
          .map(
            (f) => {
              'name': f.name,
              'url': _supabase.storage.from('tracks').getPublicUrl(f.name),
            },
          )
          .toList();

      setState(() {
        _tracks = publicUrls;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  Future<void> _playTrack(String url) async {
    if (_playingUrl == url) {
      await _player.stop();
      setState(() => _playingUrl = null);
      return;
    }

    await _player.play(UrlSource(url));
    setState(() => _playingUrl = url);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('Explorer les trames'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : _tracks.isEmpty
          ? const Center(
              child: Text(
                'Aucune trame disponible',
                style: TextStyle(color: Colors.white70),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _tracks.length,
              itemBuilder: (context, i) {
                final t = _tracks[i];
                final playing = t['url'] == _playingUrl;
                return Card(
                  color: Colors.grey[900],
                  child: ListTile(
                    leading: Icon(
                      playing ? Icons.stop_circle : Icons.play_circle,
                      color: Colors.blueAccent,
                      size: 36,
                    ),
                    title: Text(
                      t['name'],
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () => _playTrack(t['url']),
                  ),
                );
              },
            ),
    );
  }
}
