import 'package:flutter/material.dart';
import 'package:instagram_clone/views/widgets/custom_text.dart';
import 'package:ionicons/ionicons.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final String userName;
  final String userImage;
  final String videoLink;

  const VideoPage({
    super.key,
    required this.userName,
    required this.userImage,
    required this.videoLink,
  });

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController videoController;

  @override
  void initState() {
    super.initState();
    videoController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoLink))
          ..initialize().then((_) {
            setState(() {
              videoController.play();
            });
          });
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }

  void toggleVideo() {
    setState(() {
      if (videoController.value.isPlaying) {
        videoController.pause();
      } else {
        videoController.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: videoController.value.isInitialized
          ? GestureDetector(
              onTap: toggleVideo,
              child: Expanded(
                child: Stack(
                  children: [
                    VideoPlayer(videoController),
                    Positioned(
                      top: 80,
                      left: 20,
                      right: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Icon(Icons.arrow_back_ios),
                            onTap: () => Navigator.pop(context),
                          ),
                          CustomText(text: 'Your Reels', fontSize: 19),
                          Icon(Icons.camera_alt_outlined),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 190,
                      right: 10,
                      child: Column(
                        children: [
                          Icon(Icons.favorite_border, size: 32),
                          SizedBox(height: 3),
                          Text("345", style: TextStyle(color: Colors.white)),
                          SizedBox(height: 30),
                          Icon(Ionicons.chatbubble_ellipses_outline, size: 32),
                          SizedBox(height: 3),
                          Text("14", style: TextStyle(color: Colors.white)),
                          SizedBox(height: 30),
                          Icon(Icons.send, size: 32),
                          SizedBox(height: 3),
                          Text("1K", style: TextStyle(color: Colors.white)),
                          SizedBox(height: 30),
                          Icon(Icons.more_horiz, size: 32),
                          SizedBox(height: 3),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 0,
                      right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 20),
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(widget.userImage),
                              ),
                              SizedBox(width: 15),
                              Text(
                                widget.userName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Text("...  How to clean your car 🚗😳"),
                            ],
                          ),
                          SizedBox(height: 16),
                          Divider(
                            color: Colors.white,
                            endIndent: 20,
                            indent: 20,
                            height: 1,
                          ),
                          SizedBox(height: 18),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.remove_red_eye_outlined),
                                    SizedBox(width: 10),
                                    Text("310K . View insights"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.trending_up_outlined),
                                    SizedBox(width: 10),
                                    Text("Boost reel"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
