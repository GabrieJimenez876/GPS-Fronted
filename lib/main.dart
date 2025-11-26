import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Minimal Flutter app kept as a placeholder. The web UI is served
    // by static HTML pages, so this Flutter app is optional.
    return MaterialApp(
      title: 'GPS Transporte (Flutter stub)',
      theme: ThemeData(useMaterial3: true),
      home: const Scaffold(
        body: Center(
          child: Text('Flutter UI disabled — web pages are primary.'),
        ),
      ),
    );
  }
}
