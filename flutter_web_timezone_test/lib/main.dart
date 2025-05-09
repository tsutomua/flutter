import 'package:flutter/material.dart';
import 'package:timezone/browser.dart' as tz;
import 'package:timezone/data/latest.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _now = DateTime.now();

  void _getTime() {
    setState(() {
      var newYork = tz.getLocation('America/New_York');
      _now = tz.TZDateTime.now(newYork);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: _setup(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Click to get time in New York:'),
                  Text(
                    _now.toIso8601String(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getTime,
        tooltip: 'Get Time',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _setup() async {
    // Does not work in web.
    // await tz.initializeTimeZone();

    // Workaround 1: Works if Azure static web hosting is used.
    // await tz.initializeTimeZone('assets/packages/timezone/data/latest_10y.tzf');

    // Workaround 2: Works if the Flutter app is deployed under wwwroot/app and
    // the timezone database is copied as 'images/latest_10y.jpg' under the App service's wwwroot folder as a jpg file.
    await tz.initializeTimeZone('../images/latest_10y.jpg');
  }
}
