import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:volume_controller/volume_controller.dart';

class v1 extends StatefulWidget {
  final List<FileSystemEntity> videol;
  final String path;
  final String name;
  const v1({required this.path, required this.videol, required this.name});

  @override
  State<v1> createState() => _v1State();
}

class _v1State extends State<v1> {
  late int file_index;
  double? sv;
  bool loop = false, vi = false;
  List<FileSystemEntity> videoFiles = [];
  late VideoPlayerController _videoPlayerController;
  double opac = 1.0;
  String? curpath;
  String? curname;
  bool play = true, check = true;
  late Future<void> initialize;
  Duration? time;
  double w = 360, h = 785, p = 577;
  double _volume = 0.0, aspect = 0.45;
  bool isFullscreen = false;
  Timer? _debounceTimer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.path);
    curname = widget.name;
    curpath = widget.path;
    videoFiles = widget.videol;
    print(videoFiles);
    _videoPlayerController = VideoPlayerController.file(File(curpath!));
    initialize = _videoPlayerController.initialize().then((_) {
      _videoPlayerController.play();
      setState(() {});
    });
    VolumeController.instance.getVolume().then((volume) {
      setState(() {
        _volume = volume;
      });
    });
    VolumeController.instance.showSystemUI = false;
    VolumeController.instance.addListener((volume) {
      if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

      _debounceTimer = Timer(Duration(milliseconds: 50), () {
        setState(() {
          _volume = volume;
        });
      });
    });
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.position >=
              _videoPlayerController.value.duration &&
          loop == false) {
        _playNextVideo();
      }
    });
  }

  void _checkVideoEnd() {
    if (_videoPlayerController.value.position >=
            _videoPlayerController.value.duration &&
        loop == false) {
      _playNextVideo();
    }
  }

  void _playNextVideo() async {
    int index = videoFiles.indexWhere((file) => file.path == curpath);
    if (index < videoFiles.length - 1) {
      file_index = index + 1;
      curpath = videoFiles[file_index].path;
      curname = videoFiles[file_index!].path.split('/').last.toString();
      await _videoPlayerController.pause();
      await _videoPlayerController.dispose();

      _videoPlayerController = VideoPlayerController.file(File(curpath!));

      initialize = _videoPlayerController.initialize().then((_) {
        _videoPlayerController.play();
        _videoPlayerController.setLooping(loop);

        // Reattach the listener on video change
        _videoPlayerController.addListener(_checkVideoEnd);

        setState(() {
          play = true;
        });
      });
    } else {
      file_index = 0;
      curpath = videoFiles[file_index].path;
      curname = videoFiles[file_index!].path.split('/').last.toString();
      await _videoPlayerController.pause();
      await _videoPlayerController.dispose();

      _videoPlayerController = VideoPlayerController.file(File(curpath!));

      initialize = _videoPlayerController.initialize().then((_) {
        _videoPlayerController.play();
        _videoPlayerController.setLooping(loop);

        // Reattach the listener on video change
        _videoPlayerController.addListener(_checkVideoEnd);

        setState(() {
          play = true;
        });
      });
    }
  }

  void deactivate() {
    _videoPlayerController.pause();
    super.deactivate();
  }

  void _toggleOrientation() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      setState(() {
        aspect = 16 / 9;
        w = 160;
        h = 360;
        p = 0;
      });
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      setState(() {
        aspect = 0.45;
        w = 360;
        h = 785;
        p = 577;
      });
    }
  }

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController.dispose();
    VolumeController.instance.removeListener();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _setVolume(double value) {
    setState(() {
      _volume = value;
    });
  }

  void opacity() {
    if (check == true) {
      setState(() {
        check = false;
      });
    } else {
      setState(() {
        check = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          await SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(
              curname!,
              style: TextStyle(shadows: [
                Shadow(
                  color: Colors.white.withOpacity(0.5), // Shadow color
                  offset: Offset(2.0, 2.0), // Horizontal and vertical offset
                ),
              ]),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [],
          ),
          body: GestureDetector(
            onTap: opacity,
            child: FutureBuilder(
                future: initialize,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: false,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Center(
                      child: Stack(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                isFullscreen
                                    ? SizedBox()
                                    : SizedBox(height: 230),
                                SizedBox(
                                  height: 100,
                                ),
                                curpath!.endsWith("mp4")
                                    ? Transform.scale(
                                        scale: isFullscreen ? 0.4 : 1.75,
                                        child: AspectRatio(
                                          aspectRatio: _videoPlayerController
                                              .value
                                              .aspectRatio, // Dynamic aspect ratio
                                          child: VideoPlayer(
                                              _videoPlayerController),
                                        ),
                                      )
                                    : Transform.rotate(
                                        angle: (curpath!.endsWith("mkv"))
                                            ? 4.7
                                            : -4.7, // Only one rotation check
                                        child: Transform.scale(
                                          scale: 1.0,
                                          child: AspectRatio(
                                            aspectRatio: _videoPlayerController
                                                .value
                                                .aspectRatio, // Dynamic aspect ratio
                                            child: VideoPlayer(
                                                _videoPlayerController),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: isPortrait ? 587 : 200,
                                ),
                                Container(
                                  color: Colors.black12,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Opacity(
                                              opacity: opac,
                                              child: Card(
                                                color: Colors.black12,
                                                shape: CircleBorder(),
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.skip_previous_rounded,
                                                    size: 30,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    print(File(
                                                        curpath.toString()));
                                                    var index = videoFiles
                                                        .indexWhere((file) =>
                                                            file.path ==
                                                            curpath.toString());
                                                    print(index);
                                                    if (index == 0) {
                                                      setState(() async {
                                                        file_index =
                                                            videoFiles.length -
                                                                1;
                                                        if (file_index! >= 0) {
                                                          await _videoPlayerController
                                                              .pause();
                                                          await _videoPlayerController
                                                              .dispose();
                                                          curpath = videoFiles[
                                                                  file_index!]
                                                              .path;
                                                          curname = videoFiles[
                                                                  file_index!]
                                                              .path
                                                              .split('/')
                                                              .last
                                                              .toString();
                                                          print(curpath);
                                                          _videoPlayerController =
                                                              VideoPlayerController
                                                                  .file(File(
                                                                      curpath!));
                                                          initialize =
                                                              _videoPlayerController
                                                                  .initialize()
                                                                  .then((_) {
                                                            _videoPlayerController
                                                                .play();
                                                            setState(() {
                                                              play = true;
                                                            });
                                                          });
                                                          _videoPlayerController
                                                              .addListener(() {
                                                            if (_videoPlayerController
                                                                        .value
                                                                        .position >=
                                                                    _videoPlayerController
                                                                        .value
                                                                        .duration &&
                                                                loop == false) {
                                                              _playNextVideo();
                                                            }
                                                          },);
                                                        }
                                                      });
                                                    } else {
                                                      setState(() async {
                                                        file_index = index;
                                                        file_index =
                                                            file_index! - 1;
                                                        if (file_index! >= 0) {
                                                          await _videoPlayerController
                                                              .pause();
                                                          await _videoPlayerController
                                                              .dispose();
                                                          curpath = videoFiles[
                                                                  file_index!]
                                                              .path;
                                                          curname = videoFiles[
                                                                  file_index!]
                                                              .path
                                                              .split('/')
                                                              .last
                                                              .toString();
                                                          print(curpath);
                                                          _videoPlayerController =
                                                              VideoPlayerController
                                                                  .file(File(
                                                                      curpath!));
                                                          initialize =
                                                              _videoPlayerController
                                                                  .initialize()
                                                                  .then((_) {
                                                            _videoPlayerController
                                                                .play();
                                                            setState(() {
                                                              play = true;
                                                            });
                                                          });
                                                          _videoPlayerController
                                                              .addListener(() {
                                                            if (_videoPlayerController
                                                                        .value
                                                                        .position >=
                                                                    _videoPlayerController
                                                                        .value
                                                                        .duration &&
                                                                loop == false) {
                                                              _playNextVideo();
                                                            }
                                                          });
                                                        }
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                            isPortrait
                                                ? SizedBox()
                                                : SizedBox(
                                                    width: 105,
                                                  ),
                                            SizedBox(
                                              width: 240,
                                            ),
                                            Opacity(
                                              opacity: opac,
                                              child: Card(
                                                color: Colors.black12,
                                                shape: CircleBorder(),
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.skip_next_rounded,
                                                    size: 30,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    print(File(
                                                        curpath.toString()));
                                                    var index = videoFiles
                                                        .indexWhere((file) =>
                                                            file.path ==
                                                            curpath.toString());
                                                    print(index);
                                                    if (index ==
                                                        videoFiles.length - 1) {
                                                      setState(() async {
                                                        file_index = 0;
                                                        if (file_index! >= 0) {
                                                          await _videoPlayerController
                                                              .pause();
                                                          await _videoPlayerController
                                                              .dispose();
                                                          curpath = videoFiles[
                                                                  file_index!]
                                                              .path;
                                                          curname = videoFiles[
                                                                  file_index!]
                                                              .path
                                                              .split('/')
                                                              .last
                                                              .toString();
                                                          print(curpath);
                                                          _videoPlayerController =
                                                              VideoPlayerController
                                                                  .file(File(
                                                                      curpath!));
                                                          initialize =
                                                              _videoPlayerController
                                                                  .initialize()
                                                                  .then((_) {
                                                            _videoPlayerController
                                                                .play();
                                                            setState(() {
                                                              play = true;
                                                              loop = false;
                                                            });
                                                          });
                                                          _videoPlayerController
                                                              .addListener(() {
                                                            if (_videoPlayerController
                                                                        .value
                                                                        .position >=
                                                                    _videoPlayerController
                                                                        .value
                                                                        .duration &&
                                                                loop == false) {
                                                              _playNextVideo();
                                                            }
                                                          });
                                                        }
                                                      });
                                                    } else {
                                                      setState(() async {
                                                        file_index = index;
                                                        file_index =
                                                            file_index! + 1;
                                                        if (file_index! >= 0) {
                                                          await _videoPlayerController
                                                              .pause();
                                                          await _videoPlayerController
                                                              .dispose();
                                                          curpath = videoFiles[
                                                                  file_index!]
                                                              .path;
                                                          curname = videoFiles[
                                                                  file_index!]
                                                              .path
                                                              .split('/')
                                                              .last
                                                              .toString();
                                                          print(curpath);
                                                          _videoPlayerController =
                                                              VideoPlayerController
                                                                  .file(File(
                                                                      curpath!));
                                                          initialize =
                                                              _videoPlayerController
                                                                  .initialize()
                                                                  .then((_) {
                                                            _videoPlayerController
                                                                .play();
                                                            setState(() {
                                                              play = true;
                                                              loop = false;
                                                            });
                                                          });
                                                          _videoPlayerController
                                                              .addListener(() {
                                                            if (_videoPlayerController
                                                                        .value
                                                                        .position >=
                                                                    _videoPlayerController
                                                                        .value
                                                                        .duration &&
                                                                loop == false) {
                                                              _playNextVideo();
                                                            }
                                                          });
                                                        }
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      VideoProgressIndicator(
                                        _videoPlayerController,
                                        allowScrubbing: true,
                                        padding: EdgeInsets.all(10),
                                        colors: VideoProgressColors(
                                            playedColor: Colors.blue,
                                            backgroundColor: Colors.white,
                                            bufferedColor: Colors.white),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ValueListenableBuilder(
                                                valueListenable:
                                                    _videoPlayerController,
                                                builder: (context,
                                                    VideoPlayerValue value,
                                                    child) {
                                                  return Text(
                                                    _videoDuration(
                                                        value.position),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  );
                                                }),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Card(
                                              elevation: 6,
                                              color: Colors.black38,
                                              shape: CircleBorder(),
                                              child: IconButton(
                                                onPressed: () async {
                                                  final currentPosition =
                                                      await _videoPlayerController
                                                          .value.position;
                                                  final duration = 0;
                                                  if (currentPosition != null &&
                                                      duration != null) {
                                                    int newPosition =
                                                        currentPosition
                                                                .inMilliseconds -
                                                            10000;
                                                    if (newPosition <
                                                        duration) {
                                                      newPosition =
                                                          0; // Prevent exceeding total duration
                                                    }
                                                    await _videoPlayerController
                                                        .seekTo(Duration(
                                                            milliseconds:
                                                                newPosition));
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.replay_10,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Card(
                                              elevation: 6,
                                              color: Colors.black38,
                                              shape: CircleBorder(),
                                              child: IconButton(
                                                onPressed: () {
                                                  if (play == true) {
                                                    setState(() {
                                                      _videoPlayerController
                                                          .pause();
                                                      play = false;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      _videoPlayerController
                                                          .play();
                                                      play = true;
                                                    });
                                                  }
                                                },
                                                icon: Icon(
                                                  play
                                                      ? Icons.pause
                                                      : Icons.play_arrow,
                                                  size: 30,
                                                  color: play
                                                      ? Colors.white
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                            Card(
                                              elevation: 6,
                                              color: Colors.black38,
                                              shape: CircleBorder(),
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _videoPlayerController
                                                        .seekTo(Duration(
                                                            seconds: 0));
                                                    _videoPlayerController
                                                        .pause();
                                                    play = false;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.stop,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Card(
                                              elevation: 6,
                                              color: Colors.black38,
                                              shape: CircleBorder(),
                                              child: IconButton(
                                                  onPressed: () async {
                                                    final currentPosition =
                                                        await _videoPlayerController
                                                            .value.position;
                                                    final duration =
                                                        await _videoPlayerController
                                                            .value.duration;
                                                    if (currentPosition !=
                                                            null &&
                                                        duration != null) {
                                                      int newPosition =
                                                          currentPosition
                                                                  .inMilliseconds +
                                                              10000;
                                                      if (_videoPlayerController
                                                              .value.position >
                                                          _videoPlayerController
                                                              .value.duration) {
                                                        newPosition =
                                                            _videoPlayerController
                                                                .value
                                                                .duration
                                                                .inMilliseconds; // Prevent exceeding total duration
                                                      }
                                                      await _videoPlayerController
                                                          .seekTo(Duration(
                                                              milliseconds:
                                                                  newPosition));
                                                    }
                                                  },
                                                  icon: Icon(Icons.forward_10,
                                                      size: 30,
                                                      color: Colors.white)),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                                _videoDuration(
                                                    _videoPlayerController
                                                        .value.duration),
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                      isPortrait
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                        icon: _volume == 0.0
                                                            ? Icon(
                                                                Icons
                                                                    .volume_off,
                                                                color: Colors
                                                                    .white,
                                                              )
                                                            : _volume < 0.5
                                                                ? Icon(
                                                                    Icons
                                                                        .volume_down,
                                                                    color: Colors
                                                                        .white,
                                                                  )
                                                                : Icon(
                                                                    Icons
                                                                        .volume_up,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                        onPressed: () {}),
                                                    Slider(
                                                      activeColor: Colors.blue,
                                                      inactiveColor:
                                                          Colors.white,
                                                      value: _volume,
                                                      min: 0.0,
                                                      max: 1.0,
                                                      onChanged: (value) {
                                                        _setVolume(value);
                                                      },
                                                      onChangeEnd: (_volume) {
                                                        VolumeController
                                                            .instance
                                                            .setVolume(_volume);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ));
  }
}
