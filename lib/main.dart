import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(AIGuideApp());

class AIGuideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Guide App',
      home: QueryScreen(),
    );
  }
}

class QueryScreen extends StatefulWidget {
  @override
  _QueryScreenState createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen> {
  final TextEditingController _controller = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();
  List<String> steps = [];
  int currentStep = 0;

  Future<void> getStepsFromAI(String query) async {
    final response = await http.post(
      Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=YOUR_GEMINI_API_KEY"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
            lass QueryScreen extends StatefulWidget {
        @override
        _QueryScreenState createState() => _QueryScreenState();
        }

        class _QueryScreenState extends State<QueryScreen> {
        final TextEditingController _controller = TextEditingController();
        final FlutterTts flutterTts = FlutterTts();
        List<String> steps = [];
        int currentStep = 0;

        Future<void> getStepsFromAI(String query) async {
        final response = await http.post(
        Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=YOUR_GEMINI_API_KEY"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
        "contents": [
        {
        "parts": [lass QueryScreen extends StatefulWidget {
        @override
        _QueryScreenState createState() => _QueryScreenState();
        }

        class _QueryScreenState extends State<QueryScreen> {
        final TextEditingController _controller = TextEditingController();
        final FlutterTts flutterTts = FlutterTts();
        List<String> steps = [];
        int currentStep = 0;

        Future<void> getStepsFromAI(String query) async {
        final response = await http.post(
        Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=YOUR_GEMINI_API_KEY"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
        "contents": [
        {
        "parts": [
              {
                "text": "Give step-by-step instructions for: $query. Reply in numbered steps."
              }
            ]
          }
        ]
      }),
    );

    final data = jsonDecode(response.body);
    final rawText = data['candidates'][0]['content']['parts'][0]['text'];
    setState(() {
      steps = rawText.split(RegExp(r'\d+\.'));
      steps.removeWhere((step) => step.trim().isEmpty);
      currentStep = 0;
    });
    speakStep();
    // Trigger native service here (via MethodChannel)
  }

  Future<void> speakStep() async {
    if (currentStep < steps.length) {
      await flutterTts.speak("Step ${currentStep + 1}: ${steps[currentStep]}");
    }
  }

  void nextStep() {
    if (currentStep + 1 < steps.length) {
      setState(() => currentStep++);
      speakStep();
      // Highlight next button from native code
    } else {
      flutterTts.speak("All steps completed!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AI UI Guide")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Enter your query"),
            ),
            ElevatedButton(
              onPressed: () => getStepsFromAI(_controller.text),
              child: Text("Start Guide"),
            ),
            if (steps.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Current Step:", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(steps[currentStep]),
                  ElevatedButton(
                    onPressed: nextStep,
                    child: Text("Next Step"),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
