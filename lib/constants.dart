import 'package:flutter/material.dart';

// Colors
const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const backgroundColor = Color(0xFF212332);

// Widgets
Widget topMenuBox(String title, icon, [context]) => Container(
  child: Row(
    children: <Widget>[
      Icon(icon, size: 30, color: primaryColor),
      Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: Colors.white, fontSize: 22)),
    ]
  ),
  margin: const EdgeInsets.only(top: 20, bottom: 10, right: 10, left: 10),
  padding: const EdgeInsets.all(25),
  height: 80,
  width: 500,
  decoration: BoxDecoration(
    color: secondaryColor,
    borderRadius: BorderRadius.circular(10),
  ),
);