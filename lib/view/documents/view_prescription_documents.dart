import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/response/response.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import '../../utils/text_field/custom_text_field.dart';

class ViewPrescriptionDocuments extends StatefulWidget {
  final GetAllDocumentsResponsePrescription prescriprion;
  const ViewPrescriptionDocuments({Key key, this.prescriprion})
      : super(key: key);

  @override
  State<ViewPrescriptionDocuments> createState() =>
      _ViewPrescriptionDocumentsState();
}

class _ViewPrescriptionDocumentsState extends State<ViewPrescriptionDocuments> {
  TextEditingController _drName = TextEditingController();
  TextEditingController _hospital = TextEditingController();
  TextEditingController _cunsultationDate = TextEditingController();
  TextEditingController _userAilment = TextEditingController();
  TextEditingController _drAdvice = TextEditingController();

  List<String> files = [];

  String progress = "-";

  final Dio _dio = Dio();
  DateTime date = DateTime.now();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: _onSelectNotification);
    if (widget.prescriprion != null) {
      _drName.text = widget.prescriprion.doctorName.toString();
      _hospital.text = widget.prescriprion.clinicName.toString();
      _cunsultationDate.text =
          "${widget.prescriprion.consultationDate.day}-${widget.prescriprion.consultationDate.month}-${widget.prescriprion.consultationDate.year}";
      _userAilment.text = widget.prescriprion.userAilment.toString();

      _drAdvice.text = widget.prescriprion.doctorAdvice.toString();

      files = widget.prescriprion.prescriptionImage;
    }
  }

  Future<void> _onSelectNotification(String json) async {
    final obj = jsonDecode(json);

    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('${obj['error']}'),
        ),
      );
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
        title: TextBuilder(
          text: "View Prescription",
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
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
                "assets/images/medical_report.jpg",
                fit: BoxFit.cover,
                color: Colors.black45,
                colorBlendMode: BlendMode.hardLight,
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
                      controller: _drName,
                      enabled: false,
                      prefix: TextBuilder(text: 'Dr. '),
                      label: "Doctor Name",
                      textInputType: TextInputType.name,
                      onChanged: (val) {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      maxLines: 1,
                      enabled: false,
                      controller: _hospital,
                      label: "Hospital Name",
                      textInputType: TextInputType.number,
                      onChanged: (val) {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      enabled: false,
                      readOnly: true,
                      maxLines: 1,
                      controller: _cunsultationDate,
                      label: "Cunsultation Date",
                      textInputType: TextInputType.text,
                      onChanged: (val) {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      maxLines: 1,
                      enabled: false,
                      controller: _userAilment,
                      label: "User Ailment",
                      textInputType: TextInputType.name,
                      onChanged: (val) {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      maxLines: 3,
                      enabled: false,
                      controller: _drAdvice,
                      label: "Dr Advice",
                      textInputType: TextInputType.name,
                      onChanged: (val) {},
                      onTap: () {},
                    ),
                    SizedBox(height: 24),
                    if (files.isNotEmpty)
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Wrap(
                              runSpacing: 20,
                              spacing: 20,
                              alignment: WrapAlignment.start,
                              runAlignment: WrapAlignment.start,
                              children: List.generate(
                                files.length,
                                (index) => Container(
                                  height: 100,
                                  width: 100,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Image',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      GestureDetector(
                                                        child:
                                                            Icon(Icons.close),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: 16),
                                                  Container(
                                                    margin: EdgeInsets.all(1),
                                                    height: 325,
                                                    width: double.infinity,
                                                    child: CachedNetworkImage(
                                                      imageUrl: files[index],
                                                      fit: BoxFit.cover,
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  downloadProgress) =>
                                                              Center(
                                                        child: CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          barrierDismissible: false);
                                    },
                                    child: Container(
                                      height: 90,
                                      width: 90,
                                      child: CachedNetworkImage(
                                        imageUrl: files[index],
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
                    SizedBox(
                      height: 16,
                    ),
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
    print('Download started');
    final dir = await _getDownloadDirectory();
    print(dir);
    final isPermissionStatusGranted = await _requestPermissions();

    print('Permition granted ${isPermissionStatusGranted}');

    if (isPermissionStatusGranted || Platform.isAndroid) {
      final savePath = path.join(dir.path, fileName);
      await _startDownload(savePath, fileUrl);
    } else {
      // handle the scenario when user declines the permissions
    }
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
      'channel id',
      'channel name',
      priority: Priority.high,
      importance: Importance.max,
      channelDescription: 'channel description',
    );
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
        progress = (received / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }
}
