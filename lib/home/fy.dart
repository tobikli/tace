import 'package:flutter/material.dart';

class Fy extends StatefulWidget{
    const Fy({super.key});

  @override
  State<Fy> createState() => _HomeHomePageState();
}

class _HomeHomePageState extends State<Fy> {
      @override
      Widget build(BuildContext context) {
return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("For you")
            ],
        ),
      ),
    );      }
}