import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AudioPlayerApp(),
    );
  }
}

class AudioPlayerApp extends StatefulWidget {
  @override
  _AudioPlayerAppState createState() => _AudioPlayerAppState();
}

class _AudioPlayerAppState extends State<AudioPlayerApp> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _audioPath;
  bool _isPlaying = false;
  bool _isStopped = true;
  double _currentPosition = 0.0;
  double _volume = 1.0;
  Duration _duration = Duration.zero;
  Duration _currentDuration = Duration.zero;

  String _errorMessage = ""; // Error message for out of range validation

  @override
  void initState() {
    super.initState();

    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    });

    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        _currentDuration = p;
        _currentPosition = p.inSeconds.toDouble();
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  // Pick an audio file
  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    if (result != null) {
      setState(() {
        _audioPath = result.files.single.path;
      });
    }
  }

  // Play/Pause the audio
  Future<void> _togglePlayPause() async {
    if (_audioPath == null) return;

    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(DeviceFileSource(_audioPath!));
    }

    setState(() {
      _isPlaying = !_isPlaying;
      _isStopped = false;
    });
  }

  // Stop the audio
  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
      _isStopped = true;
      _currentPosition = 0.0;
    });
  }

  // Seek the audio to a specific position
  void _seekTo(double value) {
    if (value < 0.0) {
      setState(() {
        _errorMessage = "Cannot go below 0 seconds.";
      });
      value = 0.0;  // Ensure the position doesn't go below 0
    } else if (value > _duration.inSeconds.toDouble()) {
      setState(() {
        _errorMessage = "Cannot go beyond audio duration.";
      });
      value = _duration.inSeconds.toDouble();  // Ensure the position doesn't go beyond the audio duration
    } else {
      setState(() {
        _errorMessage = "";  // Clear error message if within range
      });
    }
    _audioPlayer.seek(Duration(seconds: value.toInt()));
  }

  // Change volume of audio playback
  void _setVolume(double value) {
    _audioPlayer.setVolume(value);
    if(value>0.0 && value<1.00){
      setState(() {
        _volume = value;
      });
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid")));
    }
  }

  // Format Duration
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Audio Player')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Button to pick file
            ElevatedButton(
              onPressed: _pickFile,
              child: Text("Pick an Audio File"),
            ),
            if (_audioPath != null)
              Text(
                "Selected file: ${_audioPath!.split('/').last}",
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 20),

            // Error message for invalid seek positions
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            SizedBox(height: 20),

            // Playback controls (Play/Pause, Stop, Seekbar)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.replay_10),
                  onPressed: () {
                    _seekTo(_currentPosition - 10);
                  },
                ),
                IconButton(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: _togglePlayPause,
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: _stopAudio,
                ),
                IconButton(
                  icon: Icon(Icons.forward_10),
                  onPressed: () {
                    _seekTo(_currentPosition + 10);
                  },
                ),
              ],
            ),

            // Playback Slider (Position of the audio)
            Slider(
              value: _currentPosition,
              min: 0.0,
              max: _duration.inSeconds.toDouble(),
              onChanged: (value) {
                _seekTo(value);
              },
            ),

            // Duration display
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDuration(_currentDuration)),
                Text(_formatDuration(_duration)),
              ],
            ),

            // Volume control
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.volume_down),
                  onPressed: () => _setVolume(_volume - 0.1),
                ),
                Slider(
                  value: _volume,
                  min: 0.0,
                  max: 1.0,
                  onChanged: _setVolume,
                ),
                IconButton(
                  icon: Icon(Icons.volume_up),
                  onPressed: () => _setVolume(_volume + 0.1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
