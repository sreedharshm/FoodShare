import 'package:flutter/material.dart';

// ye use karo bhai
const Color tdRed = Color(0xFFDA4040);
const Color tdBlue = Color(0xFF284B63);

const Color tdBlack = Color(0xFF3A3A3A);

const Color tdWhite = Color.fromARGB(255, 255, 255, 255);
const Color tdBGcolor = Color.fromARGB(255, 233, 233, 233);

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFFFFFFF),
  100: Color(0xFFFFFFFF),
  200: Color(0xFFFEB5B4),
  300: Color(0xFFFE9795),
  400: Color(0xFFFD817F),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFFFD6360),
  700: Color(0xFFFC5855),
  800: Color(0xFFFC4E4B),
  900: Color(0xFFFC3C3A),
});
const int _primaryPrimaryValue = 0xFFFD6B68;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_primaryAccentValue),
  400: Color(0xFFFFE0DF),
  700: Color(0xFFFFC7C6),
});
const int _primaryAccentValue = 0xFFFFFFFF;
