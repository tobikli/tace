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

  Future<List<String>> getFavs() async {
    return prefs.getStringList('favs') ?? [];
  }

  Future<void> uploadFavs() async {
  var usrname = SharedPreferencesHelper.instance.prefs.getString('name');

  // Building the query with constraints
  QueryBuilder<ParseObject> queryTodo = QueryBuilder<ParseObject>(ParseObject('UserFavorites'))
    ..whereEqualTo('UserID', usrname); // Adding constraint to filter by UserID

  final ParseResponse apiResponse = await queryTodo.query();
  if (apiResponse.success && apiResponse.results != null && apiResponse.results!.isNotEmpty) {
    // Extracting objectId and favs array from the first result
    String objectId = apiResponse.results![0].objectId;
    List<String> favs = SharedPreferencesHelper.instance.prefs.getStringList("favs") ?? [];
    
    // Modify the favs array as needed

    // Update the favs array on the ParseObject
    ParseObject userFavorites = ParseObject('UserFavorites')
      ..objectId = objectId
      ..set("favs", favs);

    final ParseResponse updateResponse = await userFavorites.save();
    if (updateResponse.success) {
      print('Favs array updated successfully on the backend');
    } else {
      print('Failed to update favs array on the backend: ${updateResponse.error!.message}');
    }
  } else {
    print('No data found for the given UserID');
  }
}


  void doInit() async {
    var usrname = SharedPreferencesHelper.instance.prefs.getString('name');

    QueryBuilder<ParseObject> queryTodo =
        QueryBuilder<ParseObject>(ParseObject('UserFavorites'))
          ..whereEqualTo(
              'UserID', usrname); // Adding constraint to filter by UserID

    final ParseResponse apiResponse = await queryTodo.query();
    if (apiResponse.success &&
        apiResponse.results != null &&
        apiResponse.results!.isNotEmpty) {
      List<String> favs = List<String>.from(apiResponse.results![0]["favs"]);
      SharedPreferencesHelper.instance.prefs.setStringList('favs', favs);
      // Getting favs array from the first result (assuming there's only one matching record)
    }
    uploadFavs();
  }

  Future<bool> hasUserLogged() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      return false;
    }
    //Checks whether the user's session token is valid
    final ParseResponse? parseResponse =
        await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);
    doInit();

    if (parseResponse?.success == null || !parseResponse!.success) {
      //Invalid session. Logout
      await currentUser.logout();
      return false;
    } else {
      return true;
    }
  }
}
