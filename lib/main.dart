import 'package:flutter/material.dart';
import 'package:learn/screen/addtask.dart';
import 'package:learn/screen/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Taskprovider())],
      child: const myapp(),
    ),
  );
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(child: Homepage()),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xFF2A4E4E)),
    );
  }
}
