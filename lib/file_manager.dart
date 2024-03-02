import 'dart:io';

import 'package:video_downloader/pemission_manager.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  static Future<Directory> getAndroidDirectory() async {
    // if (await PermissionManager.requestAndroidPermission()) {
    Directory?  directory =  await getApplicationDocumentsDirectory();
    String newPath = "";
     print(directory);
     List<String> paths = directory!.path.split("/");
      for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/video_downloader";
          directory = Directory(newPath);
          return directory;
    // } else {
    
    //   throw Exception("Storage permission not granted");
      
    // }
    
  }

  static Future<Directory> getIOSDirectory() async {
    if (await PermissionManager.requestVideoPermission()) {
      return await getTemporaryDirectory();
    } else {
      throw Exception("Videos permission not granted");
    }
  }

  static Future<bool> saveFile(String filePath, Directory directory) async {
    try {
      File file = File('$directory/$filePath');
      if (!await directory.exists()) {
        await directory.create(recursive:  true);
      }
      return true;
    } catch (e) {
      print("Error saving file: $e");
      return false;
    }
  }
}