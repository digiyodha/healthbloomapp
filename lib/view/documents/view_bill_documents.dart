import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:health_bloom/components/custom_contained_button.dart';
import 'package:health_bloom/model/response/response.dart';
import 'package:health_bloom/utils/colors.dart';
import '../../utils/text_field/custom_text_field.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'dart:convert';

import 'package:universal_html/html.dart' as html;
import 'package:http/http.dart' as http;

class ViewBillDocuments extends StatefulWidget {
  final GetAllDocumentsResponseBill bill;
  const ViewBillDocuments({Key key, this.bill}) : super(key: key);

  @override
  State<ViewBillDocuments> createState() => _ViewBillDocumentsState();
}

class _ViewBillDocumentsState extends State<ViewBillDocuments> {
  TextEditingController _billName = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _description = TextEditingController();

  List<String> files = [];

  UploadTask task;
  String _progress = "-";

  final Dio _dio = Dio();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();

    if (widget.bill != null) {
      _billName.text = widget.bill.name.toString();
      _amount.text = widget.bill.amount.toString();
      _date.text =
          "${widget.bill.date.day}/${widget.bill.date.month}/${widget.bill.date.year}";
      _description.text = widget.bill.description;

      files = widget.bill.billImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("View Bill"),
        centerTitle: true,
      ),
      backgroundColor: kWhite,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              width: double.infinity,
              child: Image.asset(
                "assets/images/medical_bill.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            top: 180,
            child: Container(
              padding: EdgeInsets.only(top: 40, left: 24, right: 24),
              decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    CustomTextField(
                      maxLines: 1,
                      controller: _billName,
                      enabled: false,
                      label: "Name of Bill",
                      textInputType: TextInputType.name,
                      onChanged: () {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      maxLines: 1,
                      enabled: false,
                      controller: _amount,
                      label: "Amount",
                      textInputType: TextInputType.number,
                      onChanged: () {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      enabled: false,
                      readOnly: true,
                      maxLines: 1,
                      controller: _date,
                      label: "Date of Bill",
                      textInputType: TextInputType.text,
                      onChanged: () {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      maxLines: 3,
                      enabled: false,
                      controller: _description,
                      label: "Description",
                      textInputType: TextInputType.name,
                      onChanged: () {},
                      onTap: () {},
                    ),
                    SizedBox(height: 24),
                    if (files.isNotEmpty)
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Wrap(
                              children: List.generate(
                                  files.length,
                                  (index) => Container(
                                        height: 100,
                                        width: 100,
                                        child: Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  'Image',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                GestureDetector(
                                                                  child: Icon(
                                                                      Icons
                                                                          .close),
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height: 16),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(1),
                                                              height: 325,
                                                              width: double
                                                                  .infinity,
                                                              child:
                                                                  Image.network(
                                                                files[index],
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 16,
                                                            ),
                                                            CustomContainedButton(
                                                              text: "Download",
                                                              textSize: 20,
                                                              weight: FontWeight
                                                                  .w600,
                                                              height: 48,
                                                              width: 328,
                                                              onPressed:
                                                                  () async {
                                                                // final taskId =
                                                                //     await FlutterDownloader
                                                                //         .enqueue(
                                                                //   url:
                                                                //       'your download link',
                                                                //   savedDir:
                                                                //       'the path of directory where you want to save downloaded files',
                                                                //   showNotification:
                                                                //       true, // show download progress in status bar (for Android)
                                                                //   openFileFromNotification:
                                                                //       true, // click on notification to open downloaded file (for Android)
                                                                // );
                                                                _download(
                                                                    'image',
                                                                    files[
                                                                        index]);

                                                                downloadImage(
                                                                    files[
                                                                        index],
                                                                    'images');
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    barrierDismissible: false);
                                              },
                                              child: Container(
                                                height: 100,
                                                width: 100,
                                                child: Image.asset(
                                                    "assets/icons/prescription.png"),
                                              ),
                                            ),
                                            // Positioned(
                                            //   top: 10,
                                            //   right: 18,
                                            //   child: InkWell(
                                            //     onTap: () {
                                            //       files.removeAt(index);
                                            //       setState(() {});
                                            //     },
                                            //     child: CircleAvatar(
                                            //       backgroundColor:
                                            //           Color(0xffFF9B91),
                                            //       radius: 12,
                                            //       child: Icon(
                                            //         Icons.close,
                                            //         color: kWhite,
                                            //         size: 16,
                                            //       ),
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      )),
                            ),
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _download(String fileName, String fileUrl) async {
    final dir = await _getDownloadDirectory();
    print(dir);
    final isPermissionStatusGranted = await _requestPermissions();

    print(isPermissionStatusGranted);

    if (isPermissionStatusGranted || Platform.isIOS) {
      final savePath = path.join(dir.path, fileName);
      await _startDownload(savePath, fileUrl);
    } else {
      // handle the scenario when user declines the permissions
    }
  }

  Future<bool> _requestPermissions() async {
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
      print(result);
    } catch (ex) {
      result['error'] = ex.toString();
      print(result);
    } finally {
      await _showNotification(result);
    }
  }

  Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
    print("SHOW NOTIFICATION");
    final android = AndroidNotificationDetails('channel id', 'channel name',
        priority: Priority.high, importance: Importance.max);

    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: iOS);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];

    await flutterLocalNotificationsPlugin.show(
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
      setState(() {
        _progress = (received / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }

  Future<void> downloadImage(String imageUrl, String name) async {
    try {
      // first we make a request to the url like you did
      // in the android and ios version
      final http.Response r = await http.get(
        Uri.parse(imageUrl),
      );

      // we get the bytes from the body
      final data = r.bodyBytes;
      // and encode them to base64
      final base64data = base64Encode(data);

      // then we create and AnchorElement with the html package
      final a = html.AnchorElement(href: 'data:image/jpeg;base64,$base64data');

      // set the name of the file we want the image to get
      // downloaded to
      a.download = name;

      // and we click the AnchorElement which downloads the image
      a.click();
      // finally we remove the AnchorElement
      a.remove();
    } catch (e) {
      print(e);
    }
  }
}
