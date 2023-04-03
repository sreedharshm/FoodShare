import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFFFEDED),
  100: Color(0xFFFED3D2),
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
