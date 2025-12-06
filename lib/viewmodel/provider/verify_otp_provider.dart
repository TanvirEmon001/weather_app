import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/api/api_service.dart';
import 'package:weather_app/core/constants/api_endpoints.dart';
import 'package:weather_app/view/screens/auth/reset_password_screen.dart';

class VerifyOtpProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  String? _otpToken;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get otpToken => _otpToken;

  Future<bool> verifyOtp(String otp, String email) async {
    bool isSuccess = false;

    _isLoading = true;
    notifyListeners();

    Map<String,String> requestBody = {
      "email" : email,
      "otp" : otp
    };

    final ApiResponse response = await ApiService.postRequest(url: ApiEndpoints.authVerifyOtp, body: requestBody);
    _isLoading = false;
    notifyListeners();

    if (response.isSuccess){
      _errorMessage = response.errorMessage.toString();
      isSuccess = true;
      _otpToken = response.responseData["verification_token"];
    } else {
      _errorMessage = response.errorMessage.toString();
    }


    return isSuccess;
  }

}