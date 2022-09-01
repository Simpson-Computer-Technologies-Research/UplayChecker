import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../main.dart';

// Home Page (Create State)
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  // Initialize the state
  @override
  State<HomePage> createState() => _HomePageState();
}

// Home Page (Widget)
class _HomePageState extends State<HomePage> {

  // TextEditingController for managing the user's name input
  final TextEditingController _controller = TextEditingController();

  // The Status Color (Red for unavailable, green for available, etc.)
  Color statusColor = primaryColor;

  // The Status Text (Available, Unavailable, Invalid, etc.)
  String statusText = ". . .";

  // Dispose the controller once 
  // no longer needed
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // The nameHttpRequest() Future function is used to send an
  // http request to the ubisoft api. This request returns whether
  // the provided name is available, unavailable or invalid.
  Future nameHttpRequest(String name) async {
    // Send the http request
    var response = await http.get(Uri.parse('https://authentication-ui.ubi.com/Default/CheckUsernameIsValid?Username='+name));

    // Check to make sure the name is valid
    if (name.isNotEmpty && !response.body.contains("your username is not allowed")) {
      // Change the status color to red and the 
      // status text to unavailable
      if (response.body.contains("not available")) {
        setState(() {
          statusText = "Unavailable";
          statusColor = Colors.redAccent;
        });
      } else if (response.body.contains("true")) {
        // Change the status color to green and the 
        // status text to available
        setState(() {
          statusText = "Available";
          statusColor = Colors.greenAccent;
        });
      }
    } else {
      // Change the status color to red and the 
      // status text to invalid
      setState(() {
        statusColor = Colors.redAccent;
        statusText = "Invalid";
      });
    }
  }

  // The nameInputField() Widget is where the user will
  // input the name they want to check.
  Widget nameInputField() => Expanded(
    child: TextField(
      // Text input controller
      controller: _controller,
      // Synchronously send the http request to the ubisoft api
      onChanged: (String name) => Future.sync(() => nameHttpRequest(name)),

      // Text Input Styling
      textInputAction: TextInputAction.go,
      style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: Colors.white, fontSize: 22),
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: statusColor, width: 2)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: statusColor, width: 2)),
        prefixIcon: Icon(Icons.alternate_email_rounded, color: statusColor),
        labelText: "Username",
        labelStyle: const TextStyle(fontSize: 20.0, color: Colors.white),
      )
    )
  );

  // The nameStatusCircle() Widget is used to change the
  // page circle's color based off the name availability.
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

  // Build the home page widget
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Ubisoft Name Checker',
    home: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Container(
        child: Column(
          children: <Widget>[
            nameStatusCircle(),
            nameInputField()
          ]
        ),
        decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.only(top: 50, bottom: 10, right: 10, left: 10),
        padding: const EdgeInsets.all(25),
        height: 600,
        width: 500
      )
    )
  );
}
