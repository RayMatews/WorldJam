import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioRecorderPlayer extends StatefulWidget {
  const AudioRecorderPlayer({super.key});

  @override
  State<AudioRecorderPlayer> createState() => _AudioRecorderPlayerState();
}

class _AudioRecorderPlayerState extends State<AudioRecorderPlayer> {
  final _recorder = AudioRecorder();
  final _player = AudioPlayer();
  String? _path;
  bool _isRecording = false;

  Future<void> _startRecording() async {
    if (await _recorder.hasPermission()) {
      final dir = await getTemporaryDirectory();
      final filePath =
          '${dir.path}/rec_${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _recorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc),
        path: filePath,
      );
      setState(() {
        _isRecording = true;
        _path = filePath;
      });
    }
  }

  Future<void> _stopRecording() async {
    await _recorder.stop();
    setState(() => _isRecording = false);
  }

  Future<void> _playRecording() async {
    if (_path != null && File(_path!).existsSync()) {
      await _player.play(DeviceFileSource(_path!));
    }
  }

  @override
  void dispose() {
    _player.dispose();
    _recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _isRecording ? _stopRecording : _startRecording,
          child: Text(_isRecording ? 'Arrêter' : 'Enregistrer'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: _playRecording, child: const Text('Écouter')),
      ],
    );
  }
}
