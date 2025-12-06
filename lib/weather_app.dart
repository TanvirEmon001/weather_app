import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/view/screens/auth/login_screen.dart';
import 'package:weather_app/view/screens/auth/otp_verification_screen.dart';
import 'package:weather_app/view/screens/auth/registration_screen.dart';
import 'package:weather_app/view/screens/auth/reset_password_screen.dart';
import 'package:weather_app/view/screens/auth/verify_email_screen.dart';
import 'package:weather_app/view/screens/weather_screen.dart';
import 'package:weather_app/viewmodel/provider/login_provider.dart';
import 'package:weather_app/viewmodel/provider/reset_password_provider.dart';
import 'package:weather_app/viewmodel/provider/user_registration_provider.dart';
import 'package:weather_app/viewmodel/provider/verify_email_provider.dart';
import 'package:weather_app/viewmodel/provider/verify_otp_provider.dart';
import 'package:weather_app/viewmodel/weather_viewmodel.dart';

class WeatherApp extends StatelessWidget {
  final String? initialRoute;
  const WeatherApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherViewModel(WeatherRepositoryImpl()),),
        ChangeNotifierProvider(create: (context) => UserRegistrationProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => VerifyEmailProvider()),
        ChangeNotifierProvider(create: (context) => VerifyOtpProvider()),
        ChangeNotifierProvider(create: (context) => ResetPasswordProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        routes: {
          WeatherScreen.route : (context) => WeatherScreen(),
          LoginScreen.route : (context) => LoginScreen(),
          RegistrationScreen.route : (context) => RegistrationScreen(),
          VerifyEmailScreen.route : (context) => VerifyEmailScreen(),
          //OtpVerificationScreen.route : (context) => OtpVerificationScreen()
        },
      ),
    );
  }

}
