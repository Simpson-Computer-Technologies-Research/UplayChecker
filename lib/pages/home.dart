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
  Color statusColor = Colors.white;
  String availability = ". . .";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future nameHttpRequest(String name) async {
    var response = await http.get(Uri.parse('https://authentication-ui.ubi.com/Default/CheckUsernameIsValid?Username='+name));
    if (response.body.contains("not available")) {
      setState(() {
        availability = "Unavailable";
        statusColor = Colors.redAccent;
      });
    } else {
      setState(() {
        availability = "Available";
        statusColor = Colors.greenAccent;
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
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor, width: 2)),
        border: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
        prefixIcon: const Icon(Icons.alternate_email_rounded, color: primaryColor),
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
      child: Text(availability, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: statusColor, fontSize: 22)),
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
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column (
          children: <Widget>[
            topMenuBox("   Ubisoft Name Checker", Icons.all_inclusive_rounded),
            Container(
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  nameStatusCircle(),
                  nameInputField()
                ]
              ),
              margin: const EdgeInsets.only(top: 5, bottom: 10, right: 10, left: 10),
              padding: const EdgeInsets.all(25),
              height: 500,
              width: 500,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            )
          ]
        ),
      )  
    )
  );
}
