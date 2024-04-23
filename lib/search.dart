import 'package:flutter/material.dart';
import 'package:tace/appstate.dart';
import 'package:flutter/services.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "";
  List<String> results = ["Nothing here"];

  final searchControlller = TextEditingController();

  @override
  void dispose() {
    searchControlller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style1 = theme.textTheme.headlineSmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Column(
      children: [
        Center(
          child: SafeArea(bottom: false, child: Text('Search', style: style1)),
        ),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 250,
              height: 40,
              child: TextField(
                inputFormatters: [LengthLimitingTextInputFormatter(16)],
                textInputAction: TextInputAction.done,
                controller: searchControlller,
                onEditingComplete: () {
                  query = searchControlller.text.trim();
                  searchControlller.clear();
                  setState(() {});
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
                  query = searchControlller.text.trim();
                  searchControlller.clear();
                  setState(() {});
                },
                child: Icon(Icons.search))
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(query == "" ? "" : "Results for $query"),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView(
            children: [
              Column(
                children: [for (var text in results) Text(text)],
              )
            ],
          ),
        ),
      ],
    );
  }
}
