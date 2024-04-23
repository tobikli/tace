import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Globals {
  var version = "0.0.31";

  var favorites = [];

  void showAlertDialog(BuildContext context, String msg, String title) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok', style: TextStyle(color: Colors.black),),
          ),
        ],
      ),
    );
  }
}

/*
return ChangeNotifierProvider(
                create: (context) => MyAppState(),
                child: MaterialApp(
                  title: 'Tace',
                  theme: ThemeData(
                    useMaterial3: true,
                    colorScheme: ColorScheme.dark(
                        primary: Color.fromARGB(255, 255, 255, 255),
                        secondary: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  home: MyHomePage(),
                ),
              );*/