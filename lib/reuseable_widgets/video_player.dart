import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({Key? key,required this.id}) : super(key: key);
  final String id;
  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: widget.id,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 50,
      child: YoutubePlayer(
        width: 90,
        controller: _controller,
      ),
    );
  }
}
