import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _batteryPercentage = "-%";

  static const batteryChannel = const MethodChannel("battery");

  void _incrementCounter() async {
    String batteryPercentage;
    try {
      var result = await batteryChannel.invokeMethod("getBatteryLevel");
      batteryPercentage = '$result%';
    } on PlatformException catch (e) {
      print(e.toString());
      batteryPercentage = "Failed to load";
    }

    setState(() {
      _batteryPercentage = batteryPercentage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Batterypercentage:',
            ),
            Text(
              '$_batteryPercentage',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Check',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
