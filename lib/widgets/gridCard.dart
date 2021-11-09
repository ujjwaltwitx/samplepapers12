import 'package:flutter/material.dart';
import 'package:samplepapers12/services/dataFetcher.dart';

class GridCard extends StatelessWidget {
  final String image, text;
  final Widget nextScreen;
  final String path;
  GridCard(this.image, this.text, this.nextScreen, this.path);
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraints) => Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Material(
          shadowColor: Colors.grey[50],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          elevation: 6.0,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Material(
              type: MaterialType.transparency,
              elevation: 6.0,
              color: Colors.transparent,
              shadowColor: Colors.grey[50],
              child: InkWell(
                splashColor: Colors.white30,
                onTap: () {
                  DataFetcher().path += '/$path';
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => nextScreen,
                    ),
                  );
                },
                child: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: contraints.maxHeight * 0.45,
                      width: contraints.maxHeight * 0.45,
                      child: Image.asset(
                        image,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Text(text)
                  ],
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
