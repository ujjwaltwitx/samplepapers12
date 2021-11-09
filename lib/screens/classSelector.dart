import 'package:flutter/material.dart';
import 'package:samplepapers12/services/dataFetcher.dart';
import 'package:samplepapers12/widgets/gridCard.dart';
import 'package:samplepapers12/screens/subjectSelector.dart';

class ClassSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DataFetcher().path = '';
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select Class'),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
          children: [
            GridCard("assets/images/book.png", "Class 11", SubjectSelector(),
                'class11'),
            GridCard("assets/images/book.png", "Class 12", SubjectSelector(),
                'class12'),
          ],
        ),
      ),
    );
  }
}
