import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';

// Constant Colors
const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const backgroundColor = Color(0xFF212332);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: const HomePage(),
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: backgroundColor,
      textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.white),
      canvasColor: secondaryColor,
    ),
  );
}