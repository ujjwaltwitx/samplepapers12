import 'package:flutter/material.dart';
import 'package:samplepapers12/screens/classSelector.dart';
import 'package:samplepapers12/widgets/gridCard.dart';

class HomeScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.3,
      children: [
        GridCard("assets/images/book.png", "CBSE 11/12 Books", ClassSelector(),
            'book'),
        GridCard("assets/images/previous.png", "Previous Year Papers",
            ClassSelector(), 'previouspapers'),
        GridCard("assets/images/sample.png", "Sample Papers", ClassSelector(),
            'samplepapers'),
        GridCard("assets/images/solution.png", "Book Solutions",
            ClassSelector(), 'solution'),
        GridCard("assets/images/syllabus.png", "Syllabus", ClassSelector(),
            'syllabus'),
      ],
    );
  }
}
