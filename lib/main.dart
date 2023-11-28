import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://brspumxsfaxdwykftuwd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJyc3B1bXhzZmF4ZHd5a2Z0dXdkIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY5OTk1NTYyMSwiZXhwIjoyMDE1NTMxNjIxfQ.TonutFWLQhInrKU2gTrKHgQScflzaWrSmiKgKnJvYyE',
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
