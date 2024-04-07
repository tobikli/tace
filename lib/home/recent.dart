import 'package:flutter/material.dart';

class Recent extends StatefulWidget{
    const Recent({super.key});

  @override
  State<Recent> createState() => _HomeHomePageState();
}

class _HomeHomePageState extends State<Recent> {
      @override
      Widget build(BuildContext context) {
return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Recent")
            ],
        ),
      ),
    );      }
}