import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
      stt.SpeechToText speech = stt.SpeechToText();

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}