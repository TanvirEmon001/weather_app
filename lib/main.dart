import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/controllers/auth_controller.dart';
import 'package:weather_app/view/screens/auth/registration_screen.dart';
import 'package:weather_app/view/screens/weather_screen.dart';
import 'package:weather_app/weather_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final String initialRoute;

  final bool isLoggedIn = await AuthController.isLoggedIn();

  if (isLoggedIn){
    await AuthController.getUserData();
    initialRoute = WeatherScreen.route;
  } else {
    initialRoute = RegistrationScreen.route;
  }

  runApp(WeatherApp(initialRoute: initialRoute));
}