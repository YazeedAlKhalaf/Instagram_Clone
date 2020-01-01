import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String app_name = 'App Name';

TextStyle _primaryTextStyle = TextStyle(
  color: Colors.black,
);

TextStyle _accentTextStyle = TextStyle(
  color: Colors.blueGrey,
);

TextStyle _textStyle = TextStyle(
  color: Colors.black,
);

TextTheme _primaryTextTheme = TextTheme(
  display1: GoogleFonts.raleway(
    fontSize: 35,
    textStyle: _primaryTextStyle,
  ),
  display2: GoogleFonts.raleway(
    fontSize: 49,
    textStyle: _primaryTextStyle,
  ),
  display3: GoogleFonts.raleway(
    fontSize: 61,
    textStyle: _primaryTextStyle,
  ),
  display4: GoogleFonts.raleway(
    fontSize: 98,
    textStyle: _primaryTextStyle,
  ),
  headline: GoogleFonts.raleway(
    fontSize: 24,
    textStyle: _primaryTextStyle,
  ),
  title: GoogleFonts.raleway(
    fontSize: 20,
    textStyle: _primaryTextStyle,
  ),
  subtitle: GoogleFonts.raleway(
    fontSize: 14,
    textStyle: _primaryTextStyle,
  ),
  subhead: GoogleFonts.raleway(
    fontSize: 16,
    textStyle: _primaryTextStyle,
  ),
  body1: GoogleFonts.raleway(
    fontSize: 15,
    textStyle: _primaryTextStyle,
  ),
  body2: GoogleFonts.raleway(
    fontSize: 17,
    textStyle: _primaryTextStyle,
  ),
  caption: GoogleFonts.raleway(
    fontSize: 13,
    textStyle: _primaryTextStyle,
  ),
  overline: GoogleFonts.raleway(
    fontSize: 11,
    textStyle: _primaryTextStyle,
  ),
  button: GoogleFonts.raleway(
    fontSize: 20,
    textStyle: _primaryTextStyle,
  ),
);

TextTheme _accentTextTheme = TextTheme(
  display1: GoogleFonts.raleway(
    fontSize: 35,
    textStyle: _accentTextStyle,
  ),
  display2: GoogleFonts.raleway(
    fontSize: 49,
    textStyle: _accentTextStyle,
  ),
  display3: GoogleFonts.raleway(
    fontSize: 61,
    textStyle: _accentTextStyle,
  ),
  display4: GoogleFonts.raleway(
    fontSize: 98,
    textStyle: _accentTextStyle,
  ),
  headline: GoogleFonts.raleway(
    fontSize: 24,
    textStyle: _accentTextStyle,
  ),
  title: GoogleFonts.raleway(
    fontSize: 20,
    textStyle: _accentTextStyle,
  ),
  subtitle: GoogleFonts.raleway(
    fontSize: 14,
    textStyle: _accentTextStyle,
  ),
  subhead: GoogleFonts.raleway(
    fontSize: 16,
    textStyle: _accentTextStyle,
  ),
  body1: GoogleFonts.raleway(
    fontSize: 15,
    textStyle: _accentTextStyle,
  ),
  body2: GoogleFonts.raleway(
    fontSize: 17,
    textStyle: _accentTextStyle,
  ),
  caption: GoogleFonts.raleway(
    fontSize: 13,
    textStyle: _accentTextStyle,
  ),
  overline: GoogleFonts.raleway(
    fontSize: 11,
    textStyle: _accentTextStyle,
  ),
  button: GoogleFonts.raleway(
    fontSize: 20,
    textStyle: _accentTextStyle,
  ),
);

TextTheme _textTheme = TextTheme(
  display1: GoogleFonts.raleway(
    fontSize: 35,
    textStyle: _textStyle,
  ),
  display2: GoogleFonts.raleway(
    fontSize: 49,
    textStyle: _textStyle,
  ),
  display3: GoogleFonts.raleway(
    fontSize: 61,
    textStyle: _textStyle,
  ),
  display4: GoogleFonts.raleway(
    fontSize: 98,
    textStyle: _textStyle,
  ),
  headline: GoogleFonts.raleway(
    fontSize: 24,
    textStyle: _textStyle,
  ),
  title: GoogleFonts.raleway(
    fontSize: 20,
    textStyle: _textStyle,
  ),
  subtitle: GoogleFonts.raleway(
    fontSize: 14,
    textStyle: _textStyle,
  ),
  subhead: GoogleFonts.raleway(
    fontSize: 16,
    textStyle: _textStyle,
  ),
  body1: GoogleFonts.raleway(
    fontSize: 15,
    textStyle: _textStyle,
  ),
  body2: GoogleFonts.raleway(
    fontSize: 17,
    textStyle: _textStyle,
  ),
  caption: GoogleFonts.raleway(
    fontSize: 13,
    textStyle: _textStyle,
  ),
  overline: GoogleFonts.raleway(
    fontSize: 11,
    textStyle: _textStyle,
  ),
  button: GoogleFonts.raleway(
    fontSize: 20,
    textStyle: _textStyle,
  ),
);

AppBarTheme _appBarTheme = AppBarTheme(
  textTheme: _textTheme,
  color: Colors.white,
  iconTheme: IconThemeData(color: Colors.black),
);

ButtonThemeData _buttonTheme = ButtonThemeData(
  padding: EdgeInsets.all(10.0),
  shape: StadiumBorder(),
);

ThemeData themeData = ThemeData(
  primaryColor: Colors.blueGrey,
  primarySwatch: Colors.blueGrey,
  accentColor: Colors.blueGrey,
  scaffoldBackgroundColor: Colors.white,
  bottomAppBarColor: Colors.white,
  brightness: Brightness.light,
  textTheme: _textTheme,
  primaryTextTheme: _primaryTextTheme,
  accentTextTheme: _accentTextTheme,
  iconTheme: IconThemeData(color: Colors.black),
  accentIconTheme: IconThemeData(color: Colors.black),
  primaryIconTheme: IconThemeData(color: Colors.black),
  appBarTheme: _appBarTheme,
  buttonTheme: _buttonTheme,
);
