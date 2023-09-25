import 'dart:async';
import 'package:flutter/material.dart';
import 'nextpage.dart';


void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key}) ;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo'),
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
  int _second = 0;
  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    toggleTimer();

  }


  void stopTimer() {
    _timer?.cancel();
  }

  void resetTimer() {
    _timer?.cancel();

    setState(() {
      _second = 0;
      _isRunning = false;
    });
  }

  void toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
            (timer) {
          setState(() {
            _second++;
          });
          if (_second == 10) {
            resetTimer();
            Navigator.push (
              context,
              MaterialPageRoute(builder: (context) => NextPage()),
              //MaterialPageRoute(builder: (context) => NextPage()),
            );
          }
        },
      );
    }
    setState(() {
      _isRunning = !_isRunning;
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
        children:[ Text(
            '$_second',
        style: const TextStyle(fontSize: 100),
        ),
        ElevatedButton(
          onPressed: () {
            toggleTimer();
          },
          child: Text(
            _isRunning? 'ストップ' : 'スタート',
          ),
        ),
          ElevatedButton(
            onPressed: () {
              resetTimer();
            },
            child: Text(
              'リセット',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],

      ),
      ),
    );
  }


}
