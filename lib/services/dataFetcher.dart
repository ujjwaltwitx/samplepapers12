import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:samplepapers12/widgets/downloadWidget.dart';
import 'package:samplepapers12/widgets/offlineWidget.dart';

final dataFetcherProvider =
    ChangeNotifierProvider<DataFetcher>((ref) => DataFetcher());

class DataFetcher extends ChangeNotifier {
  DataFetcher._instantiate();
  static final DataFetcher instance = DataFetcher._instantiate();
  factory DataFetcher() {
    return instance;
  }

  String path = '';
  double downPerct = 0.0;

  Future getFiles() async {
    List pathElements = path.split('/');
    final String newPath =
        '/' + pathElements[2] + '/' + pathElements[3] + '/' + pathElements[1];
    FirebaseStorage instance = FirebaseStorage.instance;
    ListResult data = await instance.ref(newPath).listAll();
    print(data.items);
    List<Widget> dataCards = await Future.wait(data.items.map((e) async {
      final String tempDir = await getDir();
      final Directory directory = Directory(tempDir);
      final String filePath = '${directory.path}/${e.name}';
      final String downloadLink =
          await instance.ref(e.fullPath).getDownloadURL();
      if (await fileExistsOrNot(filePath)) {
        return OfflineWidget(
          e.name,
          filePath,
          downloadLink,
        );
      } else {
        return DownloadWidget(downloadLink, e.name, filePath);
      }
    }).toList());
    return dataCards;
  }

  Future<String> getDir() async {
    String downloadPath = '';
    final Directory? directory = await getExternalStorageDirectory();
    final path = directory != null ? directory.path : "";
    final pathParts = path.split('/');
    for (int i = 1; i < pathParts.length; i++) {
      if (pathParts[i] != 'Android') {
        downloadPath += '/${pathParts[i]}';
      } else {
        break;
      }
    }
    return downloadPath += '/Download';
  }

  Future<void> downloadPdf(String link, String fileName) async {
    if (await Permission.storage.isGranted) {
    } else {
      await Permission.storage.request();
    }
    final String tempDir = await getDir();
    final Directory directory = Directory(tempDir);
    final String filePath = '${directory.path}/$fileName';

    if (await fileExistsOrNot(filePath)) {
      Fluttertoast.showToast(
        msg: "File exists in Download folder",
        gravity: ToastGravity.CENTER,
      );
      return;
    } else {}

    final Dio dio = Dio();
    await dio.download(link, filePath, onReceiveProgress: (rec, total) {
      downPerct = rec / total;
      print(downPerct);
      notifyListeners();
    });
    Fluttertoast.showToast(
      msg: "Downloaded",
      gravity: ToastGravity.CENTER,
    );
    downPerct = 0.0;
  }

  Future<bool> fileExistsOrNot(String path) async {
    return await File(path).exists();
  }

  void fakeUpdate() {
    notifyListeners();
  }
}
