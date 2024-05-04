import 'package:flutter/material.dart';
import 'package:google_gemini/screen/home/view/home_screen.dart';
import 'package:google_gemini/screen/splash/view/splash_screen.dart';

Map<String,WidgetBuilder> appRoutes={
  "/":(context) => const SplashScreen(),
  "home":(context) => const HomeScreen()
};