import 'package:flutter/material.dart';
import 'package:tace/appstate.dart';

class HomeHomePage extends StatefulWidget {
  const HomeHomePage({super.key});

  @override
  State<HomeHomePage> createState() => _HomeHomePageState();
}

class _HomeHomePageState extends State<HomeHomePage> {
    var usrname = SharedPreferencesHelper.instance.prefs.getString('name');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("HOME"),
            SizedBox(height: 10,),
            Text("Welcome back $usrname!",
                style: TextStyle(
                    color: theme.colorScheme.secondary, fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
