import 'package:flutter/material.dart';
import 'package:tace/appstate.dart';
import 'package:flutter/services.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<String> favs = [];
  final favController = TextEditingController();
  IconData icon = Icons.login;

  @override
  void dispose() {
    favController.dispose();
    super.dispose();
  }

  void loadFavs() async {
    var temp = SharedPreferencesHelper.instance.prefs.getStringList("favs");
    favs = temp ?? [];
    setState(() {});
    print(favs);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadFavs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style1 = theme.textTheme.headlineSmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return SafeArea(
      child: Column(
        children: [
          Text('Notes', style: style1),
          SizedBox(
            height: 10,
          ),
          
          
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200,
                height: 40,
                child: TextField(
                  controller: favController,
                  inputFormatters: [LengthLimitingTextInputFormatter(16)],
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () {
                    favs.add(favController.text.trim());
                    SharedPreferencesHelper.instance.prefs
                        .setStringList('favs', favs);
                    SharedPreferencesHelper.instance.uploadFavs();
                    setState(() {});
                    favController.clear();
                    FocusScope.of(context).unfocus();
                  },
                  cursorColor: Colors.black,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    favs.add(favController.text.trim());
                    SharedPreferencesHelper.instance.prefs
                        .setStringList('favs', favs);
                    SharedPreferencesHelper.instance.uploadFavs();
                    setState(() {});
                    favController.clear();
                  },
                  child: Text("Add"))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              children: [
                Column(
                  children: [
                    for (var text in favs)
                      FavItem(
                          func: () {
                            favs.remove(text);
                            SharedPreferencesHelper.instance.prefs
                                .setStringList('favs', favs);
                            SharedPreferencesHelper.instance.uploadFavs();
                            setState(() {});
                          },
                          text: text),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FavItem extends StatelessWidget {
  const FavItem({
    super.key,
    required this.text,
    required this.func,
  });

  final String text;
  final Function() func;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Expanded(child: Align(alignment: Alignment.center, child: Text(text))),
      IconButton(onPressed: func, icon: Icon(Icons.close)),
      SizedBox(
        width: 10,
      )
    ]);
  }
}
