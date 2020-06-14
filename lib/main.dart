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
    return ChangeNotifierProvider<AppStateProvider>(
      create: (context) => AppStateProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Dashboard(),
      ),
    );
  }
}

class StateChanger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RaisedButton(
            child: Text("Press me to change Dashboard Value"),
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
              "Here is your value, ${Provider.of<AppStateProvider>(context).value}"),
          RaisedButton(
            child: Text("Navigate to Page Two"),
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
