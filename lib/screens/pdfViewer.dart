import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PdfViewer extends StatelessWidget {
  final String downloadLink;
  var file;
  PdfViewer({this.downloadLink = "", this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Viewing PDF")),
      body: FutureBuilder(
        future: downloadLink == ""
            ? PDFDocument.fromFile(file)
            : PDFDocument.fromURL(downloadLink),
        builder: (context, snapshot) => snapshot.hasData
            ? PDFViewer(
                document: snapshot.data as PDFDocument,
              )
            : Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
