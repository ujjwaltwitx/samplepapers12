import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samplepapers12/services/dataFetcher.dart';
import 'package:samplepapers12/screens/pdfViewer.dart';
import 'package:samplepapers12/widgets/offlineWidget.dart';

class DownloadWidget extends ConsumerWidget {
  final String downloadLink, heading, filePath;
  bool isWatching = false, isDeleted = false;
  DownloadWidget(this.downloadLink, this.heading, this.filePath);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final datafetcher = watch(dataFetcherProvider);
    return isDeleted
        ? OfflineWidget(heading, filePath, downloadLink)
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
                      heading.replaceRange(
                          heading.length - 4, heading.length, ""),
                      style: TextStyle(fontSize: 20)),
                ),
                isWatching
                    ? Container(
                        alignment: Alignment.centerLeft,
                        height: 5,
                        width: double.infinity,
                        color: Colors.black12,
                        child: FractionallySizedBox(
                          child: Container(
                            color: Colors.green,
                            height: 5,
                          ),
                          widthFactor: datafetcher.downPerct,
                        ),
                      )
                    : Container(
                        alignment: Alignment.centerLeft,
                        height: 5,
                        width: double.infinity,
                        color: Colors.black12,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        isWatching = true;
                        DataFetcher().fakeUpdate();

                        DataFetcher.instance.downPerct = 0.0;
                        await DataFetcher().downloadPdf(downloadLink, heading);
                        isDeleted = true;
                        DataFetcher().fakeUpdate();
                      },
                      child: Text(
                        isWatching ? "Downloading" : "Download",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PdfViewer(
                              downloadLink: downloadLink,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "View Online",
                        style: TextStyle(
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
  }
}
