import 'package:flutter/material.dart';
import 'package:samplepapers12/services/dataFetcher.dart';
import 'package:samplepapers12/widgets/gridCard.dart';
import 'package:samplepapers12/screens/papersList.dart';

class SubjectSelector extends StatelessWidget {
  @override
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
        print(DataFetcher.instance.path);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select Subject'),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
          children: [
            GridCard("assets/images/physics.png", "Physics", PapersList(),
                'physics'),
            GridCard("assets/images/chemistry.png", "Chemistry", PapersList(),
                'chemistry'),
            GridCard("assets/images/math.png", "Math", PapersList(), 'math')
          ],
        ),
      ),
    );
  }
}
