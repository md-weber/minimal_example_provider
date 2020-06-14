import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (context) => AppStateProvider(),
        child: Dashboard(),
      ),
    );
  }
}

class StateChanger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RaisedButton(
            child: Text("Press me to change Dashboard"),
            onPressed: () {
              // Change state on page 2
              Provider.of<AppStateProvider>(context, listen: false).changeValue(
                Random().nextInt(500),
              );
            },
          ),
          RaisedButton(
            child: Text("Navigate back"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
              "Here is your value, ${Provider.of<AppStateProvider>(context).value}"),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StateChanger(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class AppStateProvider extends ChangeNotifier {
  int _value = 0;

  void changeValue(int newValue) {
    _value = newValue;
    notifyListeners();
  }

  get value => _value;
}
