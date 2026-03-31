import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoWidget extends StatefulWidget {
  final String link;
  const CustomVideoWidget({super.key, required this.link});

  @override
  State<CustomVideoWidget> createState() => _CustomVideoWidgetState();
}

class _CustomVideoWidgetState extends State<CustomVideoWidget> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  // * 2 hours ->

  @override
  void initState() {
    super.initState();
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.link))
          ..initialize().then((v) {
            Future.delayed(Duration(seconds: 3), () {
              setState(() {});
            });
          });
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController, autoPlay: true);
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Chewie(controller: chewieController),
    );
  }
}
