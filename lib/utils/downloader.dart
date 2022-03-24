import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'dart:convert';
import 'package:share/share.dart';
import 'package:path/path.dart' as path;
import '../main.dart';


class FileDownloader{

  final Dio _dio = Dio();

  fileShare(String url) {
    Share.share(
      url,
      subject: 'Insurence Claim Attachments',
    );
  }

  Future<String> download(String fileName, String fileUrl) async {
    print('Download started');
    final dir = await _getDownloadDirectory();
    print(dir);
    final isPermissionStatusGranted = await _requestPermissions();

    print('Permition granted ${isPermissionStatusGranted}');

    if (isPermissionStatusGranted || Platform.isAndroid) {
      final savePath = path.join(dir.path, fileName);
      await _startDownload(savePath, fileUrl);
      return savePath;
    } else {
      // handle the scenario when user declines the permissions
    }
    return "";
  }

  Future<bool> _requestPermissions() async {
    print('Permition dialog');
    var permission = await Permission.storage.status;
    var permission2 = await Permission.manageExternalStorage.status;

    if (permission != PermissionStatus.granted) {
      await Permission.storage.request();
      permission = await Permission.storage.status;
    }

    if (permission2 != PermissionStatus.granted) {
      await Permission.manageExternalStorage.request();
      permission = await Permission.manageExternalStorage.status;
    }

    return permission == PermissionStatus.granted &&
        permission2 == PermissionStatus.granted;
  }

  Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await DownloadsPathProvider.downloadsDirectory;
    }

    // in this example we are using only Android and iOS so I can assume
    // that you are not trying it for other platforms and the if statement
    // for iOS is unnecessary

    // iOS directory visible to user
    return await getApplicationDocumentsDirectory();
  }

  Future<void> _startDownload(String savePath, String fileUrl) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };

    try {
      final response = await _dio.download(fileUrl, savePath,
          onReceiveProgress: _onReceiveProgress);
      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
      print('Result ' + result.toString());
    } catch (ex) {
      result['error'] = ex.toString();
      print('Result ' + result.toString());
    } finally {
      await _showNotification(result);
    }
  }

  Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
    final android = AndroidNotificationDetails(
      'channel id', 'channel name',
      priority: Priority.high, importance: Importance.max,channelDescription: 'channel description',);
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: iOS);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];

    await flutterNotification.show(
        0, // notification id
        isSuccess ? 'Success' : 'Failure',
        isSuccess
            ? 'File has been downloaded successfully!'
            : 'There was an error while downloading the file.',
        platform,
        payload: json);
  }

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      // setState(() {
      //   //progress = (received / total * 100).toStringAsFixed(0) + "%";
      // });
    }
  }

}