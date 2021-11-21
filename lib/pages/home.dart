// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../constants.dart';

// Home Page (Create State)
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// Home Page (Widget)
class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  Color statusColor = primaryColor;
  String statusText = ". . .";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose(); 
  }

  Future nameHttpRequest(String name) async {
    var response = await http.get(Uri.parse('https://authentication-ui.ubi.com/Default/CheckUsernameIsValid?Username='+name));
    if (name.isNotEmpty && !response.body.contains("your username is not allowed")) {
      if (response.body.contains("not available")) {
        setState(() {
          statusText = "Unavailable";
          statusColor = Colors.redAccent;
        });
      } else if (response.body.contains("true")){
        setState(() {
          statusText = "Available";
          statusColor = Colors.greenAccent;
        });
      }
    } else {
      setState(() {
        statusColor = Colors.redAccent;
        statusText = "Invalid";
      });
    }
  }

  Widget nameInputField() => Expanded(
    child: TextField(
      controller: _controller,
      textInputAction: TextInputAction.go,
      onChanged: (String name) => nameHttpRequest(name),
      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: Colors.white, fontSize: 22),
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: statusColor, width: 2)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: statusColor, width: 2)),
        border: UnderlineInputBorder(borderSide: BorderSide(color: statusColor)),
        prefixIcon: Icon(Icons.alternate_email_rounded, color: statusColor),
        labelText: "Username",
        labelStyle: TextStyle(fontSize: 20.0, color: Colors.white),
      )
    )
  );

  Widget nameStatusCircle() => Container(
    margin: const EdgeInsets.only(bottom: 50, top: 20),
    height: 200,
    width: 200,
    child: Container(
      child: Text(statusText, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: statusColor, fontSize: 22)),
      padding: const EdgeInsets.only(top: 85),
    ),
    decoration: BoxDecoration(
      border: Border.all(color: statusColor, width: 3.0),
      shape: BoxShape.circle,
    )
  );


  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Ubisoft Name Checker',
    home: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Column (
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Column(
              children: <Widget>[
                nameStatusCircle(),
                nameInputField()
              ]
            ),
            margin: const EdgeInsets.only(top: 50, bottom: 10, right: 10, left: 10),
            padding: const EdgeInsets.all(25),
            height: 600,
            width: 500,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
          )
        ]
      ),
    )
  );
}
