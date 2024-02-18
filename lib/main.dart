import 'package:flutter/material.dart';
import 'package:video_downloader/video_player.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:VideoPlayersScreen() ,
    );
  }
}


class VideoPlayersScreen extends StatelessWidget {
  const VideoPlayersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Players')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          // Local Assets
          
          SizedBox(height: 24),
          // Network
          VideoPlayerView(
            url:
                'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
            dataSourceType: DataSourceType.network,
          ),
        ],
      ),
    );
  }
}