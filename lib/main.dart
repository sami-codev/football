import 'package:flutter/material.dart';
import 'package:football/providers/home.dart';
import 'package:football/screens/home/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: const MaterialApp(
        home:  HomeScreen(),
      ),
    );
  }
}