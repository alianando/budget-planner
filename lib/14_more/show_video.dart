import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShowVideo extends StatefulWidget {
  const ShowVideo({super.key});

  @override
  State<ShowVideo> createState() => _ShowVideoState();
}

class _ShowVideoState extends State<ShowVideo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'zYnoRqMFA3A',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  // void listener() {
  //   if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
  //     setState(() {
  //       _playerState = _controller.value.playerState;
  //       _videoMetaData = _controller.metadata;
  //     });
  //   }
  // }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    // _idController.dispose();
    // _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videos'),
        centerTitle: true,
      ),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: const ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
          onReady: () {
            //  _controller.addListener(listener);
          },
        ),
      ),
    );
  }
}
