import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  // static void requestStoragePermission() async {
  //   if (  await Permission.videos.isGranted ) {
  //     return true;
  //   } else {
  //     final result = await Permission.videos.request();
  //     return result == PermissionStatus.granted;
  //   }
  // }
  
  // static void requestStoragePermission() async {
  //   // if (await Permission.storage.isGranted) {
  //   //   return true;
  //   // } else {
  //   //   final result = await Permission.storage.request();
  //   //   return result == PermissionStatus.granted;
  //   // }
  //   // var result = await Permission.storage.status;
  //   // if(result.isGranted){
  //   //   print("permission granted");
  //   // }else if(result.isDenied){
  //   //   if(await Permission.storage.request().isGranted){
  //   //     print("permission  was granted");
  //   //   }
  //   // }
    
  //   final deviceInfoPlugin = DeviceInfoPlugin();
  //   final androidInfo = await deviceInfoPlugin.androidInfo;
  //   final int androidSdk = androidInfo.version.sdkInt;
  //   print(androidSdk);
  //   if( androidSdk >=  33){
  //     await Permission.videos.request();
  //     print("video req");
  //     if(await Permission.videos.status.isGranted ){
  //       print("is granted");
  //     }else{
  //       print("plz give permsiion");
  //     }
  //   }else{
  //     await Permission.storage.request();
  //      print("video req");
  //     if(await Permission.storage.status.isGranted ){
  //       print("storage is granted");
  //     }else{
  //       print("plz give storage permsiion");
  //     }
  //   }
  // }

  static Future<bool> requestAndroidPermission() async{
  
    final deviceInfoPlugin = DeviceInfoPlugin();
    final androidInfo = await deviceInfoPlugin.androidInfo;
    final int androidSdk = androidInfo.version.sdkInt;
    print(androidSdk);
    if( androidSdk >=  33){
      await Permission.manageExternalStorage.request();
      print("video req");
      if(await Permission.manageExternalStorage.isGranted ){
        
        
      
        print("is granted");

        return true;
      }else{
        print("plz give permsiion");
      }
    }else{
      await Permission.manageExternalStorage.request();
       print("video req");
      if(await Permission.manageExternalStorage.status.isGranted ){
        
        print("storage is granted");
        return true;
      }else{
        print("plz give storage permsiion");
      }
    }

    return false;

  }

  static Future<bool> requestVideoPermission() async {
    if (await Permission.photos.isGranted) {
      return true;
    } else {
      final result = await Permission.photos.request();
      return result == PermissionStatus.granted;
    }
  }
}