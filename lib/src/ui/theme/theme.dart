import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/src/ui/global/app_colors.dart';

String appName = 'App Name';

TextStyle _primaryTextStyle = TextStyle(
  color: primaryColor,
);

TextStyle _accentTextStyle = TextStyle(
  color: accentColor,
);

TextStyle _textStyle = TextStyle(
  color: textColorBlack,
);

TextTheme _primaryTextTheme = TextTheme(
  headline4: GoogleFonts.raleway(
    fontSize: 35,
    textStyle: _primaryTextStyle,
  ),
  headline3: GoogleFonts.raleway(
    fontSize: 49,
    textStyle: _primaryTextStyle,
  ),
  headline2: GoogleFonts.raleway(
    fontSize: 61,
    textStyle: _primaryTextStyle,
  ),
  headline1: GoogleFonts.raleway(
    fontSize: 98,
    textStyle: _primaryTextStyle,
  ),
  headline5: GoogleFonts.raleway(
    fontSize: 24,
    textStyle: _primaryTextStyle,
  ),
  headline6: GoogleFonts.raleway(
    fontSize: 20,
    textStyle: _primaryTextStyle,
  ),
  subtitle2: GoogleFonts.raleway(
    fontSize: 14,
    textStyle: _primaryTextStyle,
  ),
  subtitle1: GoogleFonts.raleway(
    fontSize: 16,
    textStyle: _primaryTextStyle,
  ),
  bodyText2: GoogleFonts.raleway(
    fontSize: 15,
    textStyle: _primaryTextStyle,
  ),
  bodyText1: GoogleFonts.raleway(
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
  headline4: GoogleFonts.raleway(
    fontSize: 35,
    textStyle: _accentTextStyle,
  ),
  headline3: GoogleFonts.raleway(
    fontSize: 49,
    textStyle: _accentTextStyle,
  ),
  headline2: GoogleFonts.raleway(
    fontSize: 61,
    textStyle: _accentTextStyle,
  ),
  headline1: GoogleFonts.raleway(
    fontSize: 98,
    textStyle: _accentTextStyle,
  ),
  headline5: GoogleFonts.raleway(
    fontSize: 24,
    textStyle: _accentTextStyle,
  ),
  headline6: GoogleFonts.raleway(
    fontSize: 20,
    textStyle: _accentTextStyle,
  ),
  subtitle2: GoogleFonts.raleway(
    fontSize: 14,
    textStyle: _accentTextStyle,
  ),
  subtitle1: GoogleFonts.raleway(
    fontSize: 16,
    textStyle: _accentTextStyle,
  ),
  bodyText2: GoogleFonts.raleway(
    fontSize: 15,
    textStyle: _accentTextStyle,
  ),
  bodyText1: GoogleFonts.raleway(
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
  headline4: GoogleFonts.raleway(
    fontSize: 35,
    textStyle: _textStyle,
  ),
  headline3: GoogleFonts.raleway(
    fontSize: 49,
    textStyle: _textStyle,
  ),
  headline2: GoogleFonts.raleway(
    fontSize: 61,
    textStyle: _textStyle,
  ),
  headline1: GoogleFonts.raleway(
    fontSize: 98,
    textStyle: _textStyle,
  ),
  headline5: GoogleFonts.raleway(
    fontSize: 24,
    textStyle: _textStyle,
  ),
  headline6: GoogleFonts.raleway(
    fontSize: 20,
    textStyle: _textStyle,
  ),
  subtitle2: GoogleFonts.raleway(
    fontSize: 14,
    textStyle: _textStyle,
  ),
  subtitle1: GoogleFonts.raleway(
    fontSize: 16,
    textStyle: _textStyle,
  ),
  bodyText2: GoogleFonts.raleway(
    fontSize: 15,
    textStyle: _textStyle,
  ),
  bodyText1: GoogleFonts.raleway(
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
  primaryColor: primaryColor,
  accentColor: accentColor,
  scaffoldBackgroundColor: Colors.white,
  bottomAppBarColor: Colors.white,
  brightness: Brightness.light,
  textTheme: _textTheme,
  primaryTextTheme: _primaryTextTheme,
  accentTextTheme: _accentTextTheme,
  iconTheme: IconThemeData(color: primaryColor),
  accentIconTheme: IconThemeData(color: primaryColor),
  primaryIconTheme: IconThemeData(color: primaryColor),
  appBarTheme: _appBarTheme,
  buttonTheme: _buttonTheme,
);
