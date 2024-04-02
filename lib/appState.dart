import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class MyAppState extends ChangeNotifier {
  var theme = 0;
  var name = "TestUser";
  
}

class SharedPreferencesHelper {
  SharedPreferencesHelper._();

  late SharedPreferences prefs;

  Future<void> initialise() async {
    prefs = await SharedPreferences.getInstance();
  }

  static final SharedPreferencesHelper instance = SharedPreferencesHelper._();

  Future<bool> getLogin() async {
    String? user = prefs.getString('name');
    return user == null;
  }

  Future<String> getToken() async {
    return prefs.getString('token') ?? "";
  }

  Future<String> getName() async {
    return prefs.getString('name') ?? "";
  }


  Future<bool> hasUserLogged() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      return false;
    }
    //Checks whether the user's session token is valid
    final ParseResponse? parseResponse =
        await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);

    if (parseResponse?.success == null || !parseResponse!.success) {
      //Invalid session. Logout
      await currentUser.logout();
      return false;
    } else {
      return true;
    }
  }
}
