import 'package:flutter/material.dart';

class Trending extends StatefulWidget{
    const Trending({super.key});

  @override
  State<Trending> createState() => _HomeHomePageState();
}

class _HomeHomePageState extends State<Trending> {
      @override
      Widget build(BuildContext context) {
return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Trending")
            ],
        ),
      ),
    );      }
}