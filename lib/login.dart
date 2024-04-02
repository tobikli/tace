import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tace/home.dart';
import 'package:tace/main.dart';
import 'appState.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  IconData icon = Icons.login;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showAlertDialog(BuildContext context, String msg) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Error'),
        content: Text(msg),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  void doUserLogin(name, password) async {
    if (name != "" && password != "") {
      final user = ParseUser(name, password, null);
      var response = await user.login();
      if (response.success) {
        SharedPreferencesHelper.instance.prefs
            .setString("name", usernameController.text);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyHomePage()));
      } else {
        _showAlertDialog(context, response.error?.message ?? "Error");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.white,
          content: Center(
              child:
                  Text("Username and Password required!", style: TextStyle(color: Colors.black)))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        extendBody: true,
        body: Row(
          children: [
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: SafeArea(
                  child: Theme(
                    data: ThemeData(
                        useMaterial3: true,
                        colorScheme: ColorScheme(
                          brightness: Brightness.dark,
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          secondary: Colors.black,
                          onSecondary: Colors.black,
                          error: Colors.red,
                          onError: Colors.black,
                          background: Colors.white,
                          onBackground: Colors.black,
                          surface: Colors.black,
                          onSurface: Colors.black,
                        ),
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(color: Colors.black),
                          fillColor: Colors.black,
                          enabledBorder: OutlineInputBorder(),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30),
                              children: [
                                TextSpan(text: "Welcome to "),
                                TextSpan(
                                    text: "TACE",
                                    style: TextStyle(
                                        fontFamily: "Demode", fontSize: 35))
                              ]),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 320,
                              child: Column(children: [
                                TextField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(16)
                                  ],
                                  textInputAction: TextInputAction.done,
                                  onEditingComplete: () {
                                    FocusScope.of(context).nextFocus();
                                  },
                                  cursorColor: Colors.black,
                                  controller: usernameController,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    labelText: "Username",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    fillColor: Colors.black,
                                    enabledBorder: OutlineInputBorder(),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  textInputAction: TextInputAction.done,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(20)
                                  ],
                                  onEditingComplete: () {
                                    doUserLogin(usernameController.text.trim(),
                                        passwordController.text.trim());
                                  },
                                  cursorColor: Colors.black,
                                  controller: passwordController,
                                  textAlign: TextAlign.center,
                                  obscureText: true,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    fillColor: Colors.black,
                                    enabledBorder: OutlineInputBorder(),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                              },
                              icon: Icon(
                                Icons.app_registration_rounded,
                              ),
                              label: Text('Register'),
                            ),
                            SizedBox(width: 20),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black,
                              ),
                              onPressed: () {
                                doUserLogin(usernameController.text.trim(),
                                    passwordController.text.trim());
                              },
                              icon: Icon(
                                icon,
                              ),
                              label: Text('Login'),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.white;
                                }
                                return Colors.white;
                              }),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => forgotPage()));
                            },
                            child: Text("Reset Password",
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ))),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showAlertDialog(BuildContext context, String msg) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Error'),
        content: Text(msg),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  void doUserRegistration(name, password, mail) async {
    if (name != "" && password != "" && mail != "") {
      final user = ParseUser.createUser(name, password, mail);
      var response = await user.signUp();
      if (response.success) {
        SharedPreferencesHelper.instance.prefs.setString("name", name);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyHomePage()));
      } else {
        _showAlertDialog(context, response.error?.message ?? "Error");
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.white,
          content: Center(
              child:
                  Text("Username, Password and Mail required!", style: TextStyle(color: Colors.black)))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        extendBody: true,
        body: Row(
          children: [
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: SafeArea(
                  child: Theme(
                    data: ThemeData(
                        useMaterial3: true,
                        colorScheme: ColorScheme(
                          brightness: Brightness.dark,
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          secondary: Colors.black,
                          onSecondary: Colors.black,
                          error: Colors.red,
                          onError: Colors.black,
                          background: Colors.white,
                          onBackground: Colors.black,
                          surface: Colors.black,
                          onSurface: Colors.black,
                        ),
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(color: Colors.black),
                          fillColor: Colors.black,
                          enabledBorder: OutlineInputBorder(),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextBox(title: "Register"),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 320,
                              child: Column(children: [
                                TextField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(16)
                                  ],
                                  textInputAction: TextInputAction.done,
                                  onEditingComplete: () {
                                    FocusScope.of(context).nextFocus();
                                  },
                                  cursorColor: Colors.black,
                                  controller: usernameController,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    labelText: "Username",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    fillColor: Colors.black,
                                    enabledBorder: OutlineInputBorder(),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(20)
                                  ],
                                  textInputAction: TextInputAction.done,
                                  onEditingComplete: () {
                                    FocusScope.of(context).nextFocus();
                                  },
                                  cursorColor: Colors.black,
                                  controller: passwordController,
                                  textAlign: TextAlign.center,
                                  obscureText: true,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    fillColor: Colors.black,
                                    enabledBorder: OutlineInputBorder(),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(30)
                                  ],
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (value) {
                                    doUserRegistration(
                                        usernameController.text.trim(),
                                        passwordController.text.trim(),
                                        mailController.text.trim());
                                  },
                                  cursorColor: Colors.black,
                                  controller: mailController,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    labelText: "Mail",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    fillColor: Colors.black,
                                    enabledBorder: OutlineInputBorder(),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black,
                              ),
                              onPressed: () {
                                doUserRegistration(
                                    usernameController.text.trim(),
                                    passwordController.text.trim(),
                                    mailController.text.trim());
                              },
                              icon: Icon(
                                Icons.app_registration_rounded,
                              ),
                              label: Text('Register'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class forgotPage extends StatefulWidget {
  @override
  State<forgotPage> createState() => _forgotPageState();
}

class _forgotPageState extends State<forgotPage> {
  final mailController = TextEditingController();

  @override
  void dispose() {
    mailController.dispose();
    super.dispose();
  }

  void _showAlertDialog(BuildContext context, String msg, String title) {
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
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  void doReset(mail) async {
    if (mail != "") {
      final user = ParseUser.createUser(null, null, mail);
      var response = await user.requestPasswordReset();
      print(response.success);
      if (response.success) {
        Navigator.of(context).pop();
        _showAlertDialog(context,
            "Password reset instructions have been sent to email!", "Success");
      } else {
        _showAlertDialog(context, response.error?.message ?? "Error", "Error");
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.white,
          content: Center(
              child:
                  Text("Mail required!", style: TextStyle(color: Colors.black)))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        extendBody: true,
        body: Row(
          children: [
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: SafeArea(
                  child: Theme(
                    data: ThemeData(
                        useMaterial3: true,
                        colorScheme: ColorScheme(
                          brightness: Brightness.dark,
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          secondary: Colors.black,
                          onSecondary: Colors.black,
                          error: Colors.red,
                          onError: Colors.black,
                          background: Colors.white,
                          onBackground: Colors.black,
                          surface: Colors.black,
                          onSurface: Colors.black,
                        ),
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(color: Colors.black),
                          fillColor: Colors.black,
                          enabledBorder: OutlineInputBorder(),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextBox(title: "Password Reset"),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 320,
                              child: Column(children: [
                                TextField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(30)
                                  ],
                                  textInputAction: TextInputAction.done,
                                  onEditingComplete: () {
                                    doReset(mailController.text.trim());
                                  },
                                  cursorColor: Colors.black,
                                  controller: mailController,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    labelText: "Mail",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    fillColor: Colors.black,
                                    enabledBorder: OutlineInputBorder(),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black,
                              ),
                              onPressed: () {
                                doReset(mailController.text.trim());
                              },
                              icon: Icon(
                                Icons.mail,
                              ),
                              label: Text('Request'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
