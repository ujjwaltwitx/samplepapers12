import 'dart:io';
import 'package:flutter/material.dart';
import 'package:samplepapers12/screens/pdfViewer.dart';
import 'package:samplepapers12/widgets/downloadWidget.dart';

class OfflineWidget extends StatefulWidget {
  final String heading, filePath, downloadLink;
  OfflineWidget(this.heading, this.filePath, this.downloadLink);

  @override
  State<OfflineWidget> createState() => _OfflineWidgetState();
}

class _OfflineWidgetState extends State<OfflineWidget> {
  bool isDeleted = false;
  @override
  Widget build(BuildContext context) {
    return isDeleted
        ? DownloadWidget(widget.downloadLink, widget.heading, widget.filePath)
        : Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(5, 5),
                  spreadRadius: 1,
                  blurRadius: 15,
                ),
              ],
            ),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                      widget.heading.replaceRange(
                          widget.heading.length - 4, widget.heading.length, ""),
                      style: TextStyle(fontSize: 20)),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 5,
                  width: double.infinity,
                  color: Colors.green,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        File file = File(widget.filePath);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PdfViewer(
                              file: file,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "View Offline",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        File file = File(widget.filePath);
                        file.delete();
                        setState(() {
                          isDeleted = true;
                        });
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
  }
}
