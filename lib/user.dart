import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class UserPage extends StatefulWidget {
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var usrname = "";
  var mail = "";
  var verified = false;
  var createdString = "";
  var pressed = true;

  void loadUser() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    usrname = currentUser?.username ?? "";
    mail = currentUser?.emailAddress ?? "";
    verified = currentUser?.emailVerified ?? false;
    var dtCreated = currentUser?.createdAt ?? DateTime(1);
    DateFormat formatter = DateFormat('dd.mm.yyyy');
    createdString = formatter.format(dtCreated);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style1 = theme.textTheme.headlineSmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );


    return Theme(
      data: theme,
      child: Scaffold(
        body: Center(
          child: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text("Account", style: style1),
              Padding(padding: EdgeInsets.all(20)),
              SizedBox(
                width: 300,
                height: 120,
                child: Card(
                  color: Colors.white,
                    child: Column(
                  children: [
                    SizedBox(height:10),
                    Text("Username: $usrname",
                        style: TextStyle(color: Colors.black)),
                    Text("Mail: $mail", style: TextStyle(color: Colors.black)),
                    RichText(text: TextSpan(children: [
                      TextSpan(text: "Verified: ",
                        style: TextStyle(color: Colors.black)),
                      WidgetSpan(child: verified?Icon(Icons.check, color: Colors.green, size: 16,):Icon(Icons.clear, color: Colors.red, size: 16))
                    ])
                    ),
                    Text("Since: $createdString",
                        style: TextStyle(color: Colors.black)),
                  ],
                )),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: (verified || pressed) ? null : (){
                  pressed = true;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.white, content: Center(child: Text("Coming soon", style: TextStyle(color: Colors.black)))));
                  setState(() {
                    
                  });
                }, 
                child: Text("Verify Mail")),
            ]),
          ),
        ),
      ),
    );
  }
}
