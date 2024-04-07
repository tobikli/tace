import 'package:flutter/cupertino.dart';
import 'package:tace/login.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'appstate.dart';
import 'package:flutter/material.dart';
import 'globals.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style1 = theme.textTheme.headlineSmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    final version = Globals().version;

    return Theme(
      data: theme,
      child: Scaffold(
        body: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Settings", style: style1),
                Padding(padding: EdgeInsets.all(20)),
                Expanded(
                  flex: 1,
                  child: ListView(
                    children: [Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          LogoutButton(),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: null, 
                          child: Text("Delete Account")), 
                          SizedBox(height: 20),
                          Text("version: $version"),
                        ],
                      )
                    ),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
        
      );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              Navigator.pop(context);
              ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
              await currentUser?.logout();
              SharedPreferencesHelper.instance.prefs.remove("name");
                if (!context.mounted) return;
              Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showAlertDialog(context);
      }, 
      child: Text("Logout"));
  }
}

