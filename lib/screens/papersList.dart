import 'package:flutter/material.dart';
import 'package:samplepapers12/services/dataFetcher.dart';

class PapersList extends StatelessWidget {
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final List splits = DataFetcher().path.split('/');
        splits.removeLast();
        DataFetcher().path = '';
        for (String i in splits) {
          if (i == '') {
          } else {
            DataFetcher().path += '/$i';
          }
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("All Papers"),
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: (snapshot.data as List<Widget>),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                  color: Colors.white,
                ),
              );
            }
          },
          future: DataFetcher().getFiles(),
        ),
      ),
    );
  }
}
