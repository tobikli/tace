import 'package:flutter/material.dart';

class Special extends StatefulWidget{
    const Special({super.key});

  @override
  State<Special> createState() => _SpecialPageState();
}

class _SpecialPageState extends State<Special> {
      @override
      Widget build(BuildContext context) {
return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Special")
            ],
        ),
      ),
    );      }
}