import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:tace/login.dart';
import 'package:tace/models/nav_item_model.dart';
import 'home.dart';
import 'user.dart';
import 'favorites.dart';
import 'search.dart';
import 'appState.dart';
import 'settings.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

const Color bottomNavBgColor = Color.fromARGB(255, 0, 0, 0);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.instance.initialise();
  const keyApplicationId = 'jY8zXQ8orJBWlw3ge5aOZsbpxBy6fUQ708wgmJXx';
  const keyClientKey = 'XQAeVe0upguJmVpRv2l8jY4GFV9pGn2FQKkx3upT';
  const keyParseServerUrl = 'https://parseapi.back4app.com';
    await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tace',
                  theme: ThemeData(
                    elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ButtonStyle(
                      )
                    ),
                    useMaterial3: true,
                    colorScheme: ColorScheme.dark(
                        primary: Color.fromARGB(255, 255, 255, 255),
                        secondary: Color.fromARGB(255, 0, 0, 0)),
                        scaffoldBackgroundColor: Colors.white,
                  ),
      home: FutureBuilder<bool>(
     future: SharedPreferencesHelper.instance.hasUserLogged(),
     builder: (buildContext, snapshot) {
       if(snapshot.hasData) {
         if(snapshot.data == false){
           // Return your login here
        return LoginPage();
      }

      // Return your home here
      return MyHomePage();
    } else {

      // Return loading screen while reading preferences
      return Center(child: CircularProgressIndicator());
    }
  },
));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  var showText = false;

  List<SMIBool> riveIconInputs = [];
  List<StateMachineController?> controllers = [];

  void animatedTheIcon(int index) {
    riveIconInputs[index].change(true);
    Future.delayed(Duration(seconds: 1), () {
      riveIconInputs[index].change(false);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void riveOnInit(Artboard artboard, {required String stateMachineName}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);
    artboard.addController(controller!);
    controllers.add(controller);

    riveIconInputs.add(controller.findInput<bool>('active') as SMIBool);
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
      case 1:
        page = FavoritesPage();
      case 2:
        page = SearchPage();
      case 3:
        page = UserPage();
      case 4:
        page = SettingsPage();
      default:
        page = HomePage();
        print("Not implemented");
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        extendBody: true,
        body: Row(
          children: [
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                color: bottomNavBgColor.withOpacity(0.8),
                borderRadius: BorderRadius.all(Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                      color: bottomNavBgColor.withOpacity(0.3),
                      //offset: Offset(0, 20),
                      //blurRadius: 20
                      ),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(bottomNavItems.length, (index) {
                final riveIcon = bottomNavItems[index].rive;
                return GestureDetector(
                  onTap: () {
                    animatedTheIcon(index);
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //AnimatedBar(isActive: showText),
                      SizedBox(
                          height: 36,
                          width: 36,
                          child: Opacity(
                            opacity: index == selectedIndex ? 1 : 0.5,
                            child: RiveAnimation.asset(riveIcon.src,
                                artboard: riveIcon.artboard,
                                onInit: (artboard) {
                              riveOnInit(artboard,
                                  stateMachineName: riveIcon.stateMachineName);
                            }),
                          )),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      );
    });
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(bottom: 2),
      height: isActive ? 4 : 0,
      width: 20,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}
