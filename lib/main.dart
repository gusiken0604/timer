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
        const Duration(milliseconds: 100),
            (timer) {
          setState(() {
            //_second++;
            _second += 100;
          });
          if (_second >= 10000) {
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
    int minutes = (_second ~/ 60000);
    int seconds = (_second % 60000) ~/ 1000;
    int hundredth = (_second % 1000) ~/ 100;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
        children:[ Text(
          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${hundredth.toString().padLeft(1, '0')}',
          style: const TextStyle(fontSize: 40),
        //     '$_second',
        // style: const TextStyle(fontSize: 100),
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
