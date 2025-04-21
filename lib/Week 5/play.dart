import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
import 'package:volume_controller/volume_controller.dart';

class play extends StatefulWidget {
  final List<FileSystemEntity> audio;
  final String path;
  final String name;
  play({required this.name, required this.path, required this.audio});
  @override
  State<play> createState() => _playState();
}

class _playState extends State<play> {
  List<FileSystemEntity> audioFiles = [];
  bool _isButtonDisabled = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  int? file_index;
  String? _audiopath;
  double _currentVolume = 0.5;
  String? curpath;
  String? curname;
  bool _isPlaying = true;
  bool _isStopped = false;
  Timer? _seekDebounceTimer;
  double _currentPosition = 0.0;
  double _volume = 0.5;
  Duration _duration = Duration.zero;
  Duration _currentDuration = Duration.zero;
  Timer? _debounceTimer;
  bool _canForward = true;
  bool _canRewind = true;
  String _errorMessage = "";
  @override
  void initState() {
    super.initState();
    curpath = widget.path;
    curname = widget.name;
    print(curpath);
    print(curname);
    audioFiles = widget.audio;
    print(audioFiles);
    _audioPlayer.onDurationChanged.listen((Duration d) {
      if (mounted) {
        setState(() {
          _duration = d;
        });
      }
    });

    _audioPlayer.onPositionChanged.listen((Duration p) {
      if (mounted) {
        setState(() {
          _currentDuration = p;
          _currentPosition = p.inSeconds.toDouble();
          if (_currentDuration == _duration) {
            print(File(curpath.toString()));
            var index = audioFiles
                .indexWhere((file) => file.path == curpath.toString());
            print(index);
            setState(() {
              file_index = index;
              file_index = file_index! + 1;
              if (file_index! < audioFiles.length) {
                curpath = audioFiles[file_index!].path;
                print(curpath);
                curname =
                    audioFiles[file_index!].path.split('/').last.toString();
                print(curname);
                _audioPlayer.play(DeviceFileSource(curpath!));
              }
            });
          }
        });
      }
    });
    _audioPlayer.play(DeviceFileSource(curpath!));
    VolumeController.instance.getVolume().then((volume) {
      if (mounted) {
        setState(() {
          _volume = volume;
        });
      }
    });

    VolumeController.instance.showSystemUI = false;
    VolumeController.instance.addListener((volume) {
      if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

      _debounceTimer = Timer(Duration(milliseconds: 100), () {
        if (mounted) {
          setState(() {
            _volume = volume;
          });
        }
      });
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      print(File(curpath.toString()));
      var index =
          audioFiles.indexWhere((file) => file.path == curpath.toString());
      print(index);
      if (index == audioFiles.length - 1) {
        setState(() {
          file_index = 0;
          if (file_index! < audioFiles.length) {
            curpath = audioFiles[file_index!].path;
            print(curpath);
            curname = audioFiles[file_index!].path.split('/').last.toString();
            print(curname);
            _audioPlayer.play(DeviceFileSource(curpath!));
          }
        });
      } else {
        setState(() {
          file_index = index;
          file_index = file_index! + 1;
          if (file_index! < audioFiles.length) {
            curpath = audioFiles[file_index!].path;
            print(curpath);
            curname = audioFiles[file_index!].path.split('/').last.toString();
            print(curname);
            _audioPlayer.play(DeviceFileSource(curpath!));
          }
        });
      }
    });
  }

  @override
  void dispose() {
    if (mounted) {
      _audioPlayer.dispose();
      VolumeController.instance.removeListener();
      _debounceTimer?.cancel();
      _seekDebounceTimer?.cancel();
      _audioPlayer.onDurationChanged.drain();
      _audioPlayer.onPositionChanged.drain();
      _audioPlayer.onPlayerComplete.drain();
    }
    super.dispose();
  }

  Future<void> _togglePlayPause() async {
    if (curpath == null) return;

    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(DeviceFileSource(curpath!));
    }

    setState(() {
      _isPlaying = !_isPlaying;
      _isStopped = false;
    });
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
      _isStopped = true;
      _currentPosition = 0.00;
    });
  }

  void setVolume(double volume) {
    setState(() {
      _volume = volume;
    });
    VolumeController.instance.setVolume(volume); // Sync with system volume
  }

  void _seekTo(double value) {
    if (value < 0.0) {
      setState(() {
        _errorMessage = "Cannot go below 0 seconds.";
      });
      value = 0.0; // Ensure the position doesn't go below 0
    } else if (value > _duration.inSeconds.toDouble()) {
      setState(() {
        _errorMessage = "Cannot go beyond audio duration.";
      });
      value = _duration.inSeconds
          .toDouble(); // Ensure the position doesn't go beyond the audio duration
    }
    _audioPlayer.seek(Duration(seconds: value.toInt()));
  }

  void _setVolume(double value) {
    setState(() {
      _volume = value;
    });
  }

  void volume() {
    VolumeController.instance.setVolume(_volume);
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PLAY"),
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 10,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                      child: Text(
                    curname!.length <= 25
                        ? curname!
                        : "${curname!.substring(0, 25)}...mp3",
                    style: TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                      color: Colors.grey.shade300,
                      elevation: 10,
                      child: _isPlaying
                          ? Lottie.asset("assets/Music.json",
                              width: 300, height: 300, fit: BoxFit.fill)
                          : Image.asset(
                              "assets/img_9.png",
                              height: 300,
                              width: 300,
                            )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 6,
                          child: IconButton(
                            icon: Icon(
                              Icons.replay_10,
                              size: 30,
                              color: Colors.green,
                            ),
                            onPressed: () async {
                              final currentPosition =
                                  await _audioPlayer.getCurrentPosition();
                              final duration = 0;
                              if (currentPosition != null && duration != null) {
                                int newPosition =
                                    currentPosition.inMilliseconds - 10000;
                                if (newPosition < duration) {
                                  newPosition =
                                      0; // Prevent exceeding total duration
                                }
                                await _audioPlayer
                                    .seek(Duration(milliseconds: newPosition));
                              }
                            },
                          ),
                        ),
                        Card(
                          elevation: 6,
                          child: IconButton(
                            icon: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                              size: 30,
                              color: _isPlaying ? Colors.red : Colors.blue,
                            ),
                            onPressed: _togglePlayPause,
                          ),
                        ),
                        Card(
                          elevation: 6,
                          child: IconButton(
                            icon: Icon(
                              Icons.stop,
                              size: 30,
                              color: Colors.red,
                            ),
                            onPressed: _stopAudio,
                          ),
                        ),
                        Card(
                          elevation: 6,
                          child: IconButton(
                            icon: Icon(Icons.forward_10,
                                size: 30, color: Colors.green),
                            onPressed: () async {
                              if (_seekDebounceTimer?.isActive ?? false) return;

                              _seekDebounceTimer = Timer(
                                Duration(milliseconds: 200),
                                () async {
                                  final currentPosition =
                                      await _audioPlayer.getCurrentPosition();
                                  final duration =
                                      await _audioPlayer.getDuration();

                                  if (currentPosition != null &&
                                      duration != null) {
                                    int newPosition =
                                        currentPosition.inMilliseconds +
                                            10000; // Add 10 sec
                                    if (newPosition > duration.inMilliseconds) {
                                      newPosition = duration
                                          .inMilliseconds; // Prevent exceeding total duration
                                    }
                                    await _audioPlayer.seek(
                                        Duration(milliseconds: newPosition));
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Playback Slider (Position of the audio)
                Container(
                  child: Slider(
                    value: _currentPosition.clamp(
                        0.0, _duration.inSeconds.toDouble()),
                    min: 0.0,
                    max: _duration.inSeconds.toDouble() > 0
                        ? _duration.inSeconds.toDouble()
                        : 1.0,
                    onChanged: _isStopped ? null : (value) => _seekTo(value),
                  ),
                ),

                // Duration display
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_isStopped
                            ? "0.00"
                            : _formatDuration(_currentDuration)),
                      ),
                      Card(
                        elevation: 6,
                        child: IconButton(
                          icon: Icon(
                            Icons.skip_previous_rounded,
                            size: 30,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            if (_isButtonDisabled || audioFiles.isEmpty)
                              return; // Prevent multi-taps
                            setState(() => _isButtonDisabled = true);
                            print(File(curpath.toString()));
                            var index = audioFiles.indexWhere(
                                (file) => file.path == curpath.toString());
                            print(index);
                            if (index == 0) {
                              setState(
                                () {
                                  file_index = audioFiles.length - 1;
                                  if (file_index! >= 0) {
                                    curpath = audioFiles[file_index!].path;
                                    print(curpath);
                                    curname = audioFiles[file_index!]
                                        .path
                                        .split('/')
                                        .last
                                        .toString();
                                    print(curname);
                                    _isPlaying = true;
                                    _isStopped = false;
                                    Future.delayed(
                                      Duration(milliseconds: 500),
                                      () {
                                        setState(
                                            () => _isButtonDisabled = false);
                                      },
                                    );
                                    _audioPlayer
                                        .play(DeviceFileSource(curpath!));
                                  }
                                },
                              );
                            } else {
                              setState(
                                () {
                                  file_index = index;
                                  file_index = file_index! - 1;
                                  if (file_index! >= 0) {
                                    curpath = audioFiles[file_index!].path;
                                    print(curpath);
                                    curname = audioFiles[file_index!]
                                        .path
                                        .split('/')
                                        .last
                                        .toString();
                                    print(curname);
                                    _isPlaying = true;
                                    _isStopped = false;
                                    Future.delayed(
                                      Duration(milliseconds: 500),
                                      () {
                                        setState(
                                            () => _isButtonDisabled = false);
                                      },
                                    );
                                    _audioPlayer
                                        .play(DeviceFileSource(curpath!));
                                  }
                                },
                              );
                            }
                          },
                        ),
                      ),
                      Card(
                        elevation: 6,
                        child: IconButton(
                          icon: Icon(
                            Icons.skip_next_rounded,
                            size: 30,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            if (_isButtonDisabled || audioFiles.isEmpty)
                              return; // Prevent multi-taps
                            setState(() => _isButtonDisabled = true);
                            print(File(curpath.toString()));
                            var index = audioFiles.indexWhere(
                                (file) => file.path == curpath.toString());
                            print(index);
                            if (index == audioFiles.length - 1) {
                              setState(
                                () {
                                  file_index = 0;
                                  if (file_index! < audioFiles.length) {
                                    curpath = audioFiles[file_index!].path;
                                    print(curpath);
                                    curname = audioFiles[file_index!]
                                        .path
                                        .split('/')
                                        .last
                                        .toString();
                                    print(curname);
                                    _isPlaying = true;
                                    _isStopped = false;
                                    Future.delayed(
                                      Duration(milliseconds: 500),
                                      () {
                                        setState(
                                            () => _isButtonDisabled = false);
                                      },
                                    );
                                    _audioPlayer
                                        .play(DeviceFileSource(curpath!));
                                  }
                                },
                              );
                            } else {
                              setState(
                                () {
                                  file_index = index;
                                  file_index = file_index! + 1;
                                  if (file_index! < audioFiles.length) {
                                    curpath = audioFiles[file_index!].path;
                                    print(curpath);
                                    curname = audioFiles[file_index!]
                                        .path
                                        .split('/')
                                        .last
                                        .toString();
                                    print(curname);
                                    _isPlaying = true;
                                    _isStopped = false;
                                    Future.delayed(Duration(milliseconds: 500),
                                        () {
                                      setState(() => _isButtonDisabled = false);
                                    });
                                    _audioPlayer
                                        .play(DeviceFileSource(curpath!));
                                  }
                                },
                              );
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_formatDuration(_duration)),
                      ),
                    ],
                  ),
                ),

                // Volume control
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 45.0, vertical: 10),
                  child: Card(
                    elevation: 6,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_volume == 0.0
                              ? Icons.volume_off_rounded
                              : _volume < 0.5
                                  ? Icons.volume_down
                                  : Icons.volume_up),
                          Slider(
                            activeColor: Colors.blue,
                            inactiveColor: Colors.white,
                            value: _volume,
                            min: 0.0,
                            max: 1.0,
                            onChanged: (value) {
                              setState(
                                () {
                                  _volume = value;
                                },
                              );

                              _debounceTimer?.cancel();

                              _debounceTimer = Timer(
                                Duration(milliseconds: 10),
                                () {
                                  VolumeController.instance.setVolume(_volume);
                                },
                              );
                            },
                            // onChangeEnd: (_volume){
                            //   VolumeController.instance.setVolume(_volume);
                            // },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
