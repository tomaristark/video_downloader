// import 'package:dio/dio.dart';

// class ApiService{
//   final dio =Dio();


//  Future<void> downloadVideo(String url,String savePath)async {
//     try {
//       await dio.download(url, savePath,);
//     } catch (e) {
//       print("Error downloading file: $e");
//       rethrow;
//     }
//   }
// }

import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService() : dio = Dio();

  Future<void> downloadFile(String url, String savePath, Function(double) onProgress) async {
    try {
      await dio.download(url, savePath, onReceiveProgress: (received, total) {
        if (total != -1) {
          onProgress(received / total);
        }
      });
    } catch (e) {
      print("Error downloading file: $e");
      rethrow;
    }
  }
}