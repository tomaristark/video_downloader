// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:video_downloader/pemission_manager.dart';
// import 'package:video_downloader/video_player.dart';
// import 'package:video_player/video_player.dart';

// void main() {
//   runApp(const MyApp());
  
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home:VideoPlayersScreen() ,
//     );
//   }
// }


// class VideoPlayersScreen extends StatefulWidget {
//   const VideoPlayersScreen({Key? key}) : super(key: key);

//   @override
//   State<VideoPlayersScreen> createState() => _VideoPlayersScreenState();
// }

// class _VideoPlayersScreenState extends State<VideoPlayersScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Video Players')),
//       body: ListView(
//         padding: const EdgeInsets.all(20),
//         children:  [
//           // Local Assets
        
//           SizedBox(height: 24),
//           // Network
//           // VideoPlayerView(
//           //   url:
//           //       'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
//           //   dataSourceType: DataSourceType.network,
//           // ),
//           ElevatedButton(onPressed: (){
//            PermissionManager.requestAndroidPermission();
//           }, 
//           child: Text("Press"))
//         ],
//       ),
//     );

    
//   }
  
//   }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_downloader/video_player.dart';
import 'package:video_player/video_player.dart';
import 'file_manager.dart';
import 'api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Folder Storage',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService _apiService = ApiService();
  bool loading = false;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinearProgressIndicator(
                minHeight: 10,
                value: progress,
              ),
            )
          : Center(
            child: IconButton(
                icon: Icon(
                  Icons.download_rounded,
                  color: Colors.red,
                ),
                color: Colors.blue,
                onPressed: _downloadFile,
                padding: const EdgeInsets.all(10),
                // label: Text(
                //   "Download Video",
                //   style: TextStyle(color: Colors.white, fontSize: 25),
                // )
                ),
          ),
    );
  }

  void _downloadFile() async {
    setState(() {
      loading = true;
      progress = 0;
    });
    bool downloaded = await _saveVideo(
        "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
        "video.mp4");
    if (downloaded) {
      print("File Downloaded");
    } else {
      print("Problem Downloading File");
    }
    setState(() {
      loading = false;
    });
  }

  Future<bool> _saveVideo(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        directory = await FileManager.getAndroidDirectory();
      } else {
        directory = await FileManager.getIOSDirectory();
      }

      File saveFile = File('${directory.path}/$fileName');
      bool saved = await FileManager.saveFile(saveFile.path, directory);
      if (saved) {
        await _apiService.downloadFile(url, saveFile.path, (value) {
          setState(() {
            progress = value;
          });
        });
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

