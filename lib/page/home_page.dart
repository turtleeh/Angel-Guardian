import 'package:flutter/material.dart';
import 'package:project/api/speech_api.dart';
import 'package:project/main.dart';
import 'package:project/widget/substring_highlighted.dart';

import '../utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = 'Press the button and start speaking';
  bool isListening = false;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(MyApp.title),
      centerTitle: true,
    ),
    body: SingleChildScrollView(
      reverse: true,
      padding: const EdgeInsets.all(30).copyWith(bottom: 150),
      child: SubstringHighlight(
        text: text,
        terms: Command.all,
        textStyle: TextStyle(
          fontSize: 32.0,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        textStyleHighlight: TextStyle(
          fontSize: 32.0,
          color: Colors.red,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    floatingActionButtonLocation:
    FloatingActionButtonLocation.centerFloat,
    floatingActionButton: FloatingActionButton(
      onPressed: toggleRecording,
      // Add any other properties for the FloatingActionButton as needed
    ),
  );

  Future<void> toggleRecording() async {
    try {
      await SpeechApi.toggleRecording(
        onResult: (resultText) {
          setState(() => this.text = resultText);
          Utils.scanText(resultText);
          showSnackBarWithText(resultText);
        },
        onListening: (isListening) {
          setState(() => this.isListening = isListening);

          if (!isListening) {
            Future.delayed(Duration(seconds: 1), () {
              // Additional logic after finishing listening
            });
          }
        },
      );
    } catch (e) {
      // Handle any exceptions that might occur during speech recognition
      print("Error during speech recognition: $e");
    }
  }

  void showSnackBarWithText(String snackBarText) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(snackBarText),
        duration: Duration(seconds: 10), // Set the duration to 10 seconds
      ),
    );
  }
}