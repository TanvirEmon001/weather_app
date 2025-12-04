import 'package:flutter/material.dart';
import 'package:weather_app/features/pages/app_home_page.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppHomePage(),
    );
  }

}
