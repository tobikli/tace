import 'package:flutter/material.dart';
import 'appState.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var usrname = SharedPreferencesHelper.instance.prefs.getString('name');

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("TACE", style: TextStyle(color: Colors.black, fontFamily: "Demode", fontSize: 30),),
          Divider(
            color: theme.colorScheme.secondary,
            indent: 15,
            endIndent: 15,
          ),
          SizedBox(height: 10),
          Text("Welcome back $usrname!", style: TextStyle(color: theme.colorScheme.secondary, fontSize: 20)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              
            ],
          ),
        ],
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  const TextBox({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.normal,
      color: Color.fromARGB(255, 0, 0, 0),
    );
    return Title(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(title, style: GoogleFonts.kumbhSans(textStyle: style)),
      ),
    );
  }
}
