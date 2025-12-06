import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:weather_app/core/api/api_service.dart';
import 'package:weather_app/core/constants/api_endpoints.dart';

class VerifyEmailProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> verifyEmail(String email) async {
    bool isSuccess = false;

    _isLoading = true;
    notifyListeners();

    Map<String,String> requestBody = {
      'email' : email
    };

    final ApiResponse response = await ApiService.postRequest(url: ApiEndpoints.authForgotPassword,body: requestBody);
    _isLoading = false;
    notifyListeners();

    if (response.isSuccess){
      _errorMessage = response.errorMessage.toString();
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage.toString();
    }


    return isSuccess;
  }


}