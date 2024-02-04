import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Speech to Text';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = true;
  String _lastWords = '';
  int bpm = 80;
  int n = 5; // Normal state interval

  late Timer _timer;
  static const String codename = 'ninja';

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _startTimer();
    _startListening();
  }

  void callin(String a, String b) {
    if (b.contains(a) && (n==20) && (bpm - 5 < 70 || bpm  + 5 > 80)) {
      FlutterPhoneDirectCaller.callNumber('+21694459923');
      _lastWords = '';
      // If in emergency state, switch back to normal state after call
      setState(() {
        n = 5;
      });

    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }
  bool increaseBPM =( Random().nextInt(1) + 0 == 1 ) ;


  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      _startListening();
      callin(codename.toLowerCase(), _lastWords.toLowerCase());

      // Update bpm with a positive or negative value depending on the emergency mode
      if (n == 20) {
        setState(() {
          if (increaseBPM) {
            bpm += Random().nextInt(10) + 1; // Increase BPM by a random value between 1 and 3
            if (bpm >= 130) {
              //   If BPM reaches 100, start decreasing
              increaseBPM = false;
            }
          } else {
            bpm -= Random().nextInt(3) + 1; // Decrease BPM by a random value between 1 and 3
            if (bpm <= 40) {
              // If BPM reaches 60, start increasing again
              increaseBPM = true;
            }
          }
        });
      } else {
        // In normal state, generate a value between -n and n
        setState(() {
          if (bpm<80 ){
            bpm += Random().nextInt(5) + 1;
          }
          if (bpm>80 ) {
            bpm -= Random().nextInt(5) + 1;
          }
          if (bpm-n>70 ) {
            bpm -= Random().nextInt(n) + 1;
          }
          if (bpm+n<90 ) {
            bpm += Random().nextInt(n) + 1;
          }
          bpm += Random().nextInt(2 * n + 1) - n;
        });
      }
    });
  }


  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: Duration(seconds: 10),
    );
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Recognized words:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'BPM: $bpm',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _speechToText.isListening
                      ? _lastWords
                      : _speechEnabled
                      ? _lastWords
                      : 'Speech not available',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Toggle emergency state
                setState(() {
                  n = 20;
                });
              },
              child: Text('Emergency'),
            ),
          ],
        ),
      ),

    );
  }
}
