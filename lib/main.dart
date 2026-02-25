import 'package:flutter/material.dart';

void main() {
  runApp(const AIExpenseTracker());
}

class AIExpenseTracker extends StatelessWidget {
  const AIExpenseTracker({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: Theme.of(context).colorScheme,
      ),
    );
  }
}
