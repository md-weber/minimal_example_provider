import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RowElement(),
    );
  }
}

const germanyImage =
    "https://images.unsplash.com/photo-1534313314376-a72289b6181e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80";
const spainImage =
    "https://images.unsplash.com/photo-1511527661048-7fe73d85e9a4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=701&q=80";
const ukraineImage =
    "https://images.unsplash.com/photo-1561629625-edea42c6da34?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80";
const japanImage =
    "https://images.unsplash.com/photo-1526481280693-3bfa7568e0f3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1351&q=80";
const iranImage =
    "https://images.unsplash.com/photo-1579932979622-fc012038564d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=633&q=80";
const usaImage =
    "https://images.unsplash.com/photo-1511055882449-bef7ffcedac0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=658&q=80";

class RowElement extends StatefulWidget {
  @override
  _RowElementState createState() => _RowElementState();
}

class _RowElementState extends State<RowElement> {
  final List<ImageColumn> columns = [
    ImageColumn(germanyImage, "Germany", "Neuschwanstein Castle", false),
    ImageColumn(spainImage, "Spain", "Tibidabo", false),
    ImageColumn(ukraineImage, "Ukraine", "Pecherskyi District", false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: getStackList(),
    ));
  }

  List<Widget> getStackList() {
    double elementWidth = MediaQuery.of(context).size.width /
        (columns.length - (columns.length * 0.2));

    List<Widget> images = [];
    columns.asMap().forEach((key, value) {
      images.add(Positioned(
        bottom: 0,
        top: 0,
        left: (elementWidth * 0.8) * key,
        child: ImageContainer(
          imageUrl: value.imageUrl,
          countryName: value.countryName,
          locationName: value.locationName,
          withPerElement: elementWidth,
          isLastElement: key == columns.length - 1,
          isFirstElement: key == 0,
        ),
      ));
    });
    return images;
  }
}

class OwnClipper extends CustomClipper<Path> {
  bool firstElement;
  bool lastElement;

  OwnClipper({this.firstElement, this.lastElement});

  @override
  getClip(Size size) {
    final double width = size.width;
    final double height = size.height;

    final double p1 = width * 0.2;

    var path = Path();

    if (firstElement) {
      path = path
        ..moveTo(0, 0)
        ..lineTo(width, 0)
        ..lineTo(width - p1, height)
        ..lineTo(0, height)
        ..close();
    } else if (lastElement) {
      path = path
        ..moveTo(p1, 0)
        ..lineTo(width, 0)
        ..lineTo(width, height)
        ..lineTo(0, height)
        ..close();
    } else {
      path = path
        ..moveTo(p1, 0)
        ..lineTo(width, 0)
        ..lineTo(width - p1, height)
        ..lineTo(0, height)
        ..close();
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}

class ImageContainer extends StatelessWidget {
  final String imageUrl;
  final String countryName;
  final String locationName;
  final int index;
  final bool isLastElement;
  final bool isFirstElement;
  final double withPerElement;

  const ImageContainer({
    Key key,
    this.imageUrl,
    this.countryName,
    this.locationName,
    this.index,
    this.isLastElement,
    this.isFirstElement,
    this.withPerElement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OwnClipper(
        lastElement: isLastElement,
        firstElement: isFirstElement,
      ),
      child: AnimatedContainer(
        duration: Duration(seconds: 3),
        width: withPerElement,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: withPerElement / 1.5,
            ),
            decoration: BoxDecoration(
              color: Color(0x440000000),
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    countryName,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Color(0xFFFFFFFF),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    locationName,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Color(0xFFFFFFFF),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageColumn {
  String imageUrl;
  String countryName;
  String locationName;
  bool selected;

  ImageColumn(
      this.imageUrl, this.countryName, this.locationName, this.selected);
}
