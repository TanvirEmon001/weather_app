import 'package:flutter/foundation.dart';
import 'package:weather_app/core/api/api_service.dart';
import 'package:weather_app/core/constants/api_endpoints.dart';

class ResetPasswordProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> resetPassword(
    String email,
    String verificationToken,
    String newPassword,
    String confirmPassword,
  ) async {
    bool isSuccess = false;

    _isLoading = true;
    notifyListeners();

    Map<String,String> requestBody = {
      "email" : email,
      "verification_token" : verificationToken,
      "new_password" : newPassword,
      "confirm_password" : confirmPassword,
    };


    final ApiResponse response = await ApiService.postRequest(url: ApiEndpoints.authResetPassword, body: requestBody);
    _isLoading = false;
    notifyListeners();

    if (response.isSuccess){
      isSuccess = true;
      _errorMessage = response.errorMessage.toString();
    } else {
      _errorMessage = response.errorMessage.toString();
    }


    return isSuccess;
  }
}
