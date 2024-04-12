import 'package:flutter/material.dart';
import 'package:tace/home/fy.dart';
import 'package:tace/home/homepage.dart';
import 'package:tace/home/recent.dart';
import 'package:tace/home/special.dart';
import 'package:tace/home/trending.dart';
import '../appstate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../globals.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void checkVersion() async {
    final resp = await ParseObject('AppInfo').getObject('nVMy3lp4IL');
    if (resp.success) {
      final obje = resp.result;
      var serVer = await obje.get('version');
      print(serVer);
      if (serVer != Globals().version) {
        if (!mounted) return;
        Globals().showAlertDialog(
            context, "App ist outdated!\nPlease update", "Update");
      }
    }

  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkVersion();
    });
  }

  var selectedIndex = 0;

  ScrollController _scrollController = ScrollController();

  // Parameter to be changed when scrolled to the end
  bool ending = false;

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        // When scrolled to the end, change the parameter to true
        ending = true;
        print(ending);
      });
    } else {
      setState(() {
        // When scrolled away from the end, reset the parameter to false
        ending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var usrname = SharedPreferencesHelper.instance.prefs.getString('name');

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "TACE",
            style: TextStyle(
                color: Colors.black, fontFamily: "Demode", fontSize: 30),
          ),
          Divider(
            color: theme.colorScheme.secondary,
            indent: 15,
            endIndent: 15,
          ),
          SizedBox(height: 10),
          Text("Welcome back $usrname!",
              style:
                  TextStyle(color: theme.colorScheme.secondary, fontSize: 20)),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [Colors.white, Colors.transparent],
                  stops: ending != true ? [1, 1] : [1, 1],
                  tileMode: TileMode.mirror,
                ).createShader(bounds);
              },
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 30,
                  child: ListView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      TopButton(
                          index: 0,
                          selectedIndex: selectedIndex,
                          fun: () {
                            selectedIndex = 0;
                            setState(() {});
                          },
                          text: "Home"),
                      SizedBox(width: 8),
                      TopButton(
                          index: 1,
                          selectedIndex: selectedIndex,
                          fun: () {
                            selectedIndex = 1;
                            setState(() {});
                          },
                          text: "Trending"),
                      SizedBox(width: 8),
                      TopButton(
                          index: 2,
                          selectedIndex: selectedIndex,
                          fun: () {
                            selectedIndex = 2;
                            setState(() {});
                          },
                          text: "For you"),
                      SizedBox(width: 8),
                      TopButton(
                          index: 3,
                          selectedIndex: selectedIndex,
                          fun: () {
                            selectedIndex = 3;
                            setState(() {});
                          },
                          text: "Special"),
                      SizedBox(width: 8),
                      TopButton(
                          index: 4,
                          selectedIndex: selectedIndex,
                          fun: () {
                            selectedIndex = 4;
                            setState(() {});
                          },
                          text: "Recent"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          MainScreen(index: selectedIndex),
        ],
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({
    required this.index,
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (index) {
      case 0:
        page = HomeHomePage();
      case 1:
        page = Trending();
      case 2:
        page = Fy();
      case 3:
        page = Special();
      case 4:
        page = Recent();
      default:
        page = HomeHomePage();
    }

    return Expanded(child: page);
  }
}

class TopButton extends StatelessWidget {
  const TopButton({
    required this.fun,
    required this.text,
    required this.selectedIndex,
    required this.index,
    super.key,
  });

  final String text;
  final Function() fun;
  final int selectedIndex;
  final int index;

  @override
  Widget build(
    BuildContext context,
  ) {
    return ElevatedButton(
        style: ButtonStyle(
            animationDuration: Duration.zero,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ))),
        onPressed: index != selectedIndex ? fun : null,
        child: Text(text));
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
