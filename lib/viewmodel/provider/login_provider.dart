import 'package:flutter/foundation.dart';
import 'package:weather_app/core/api/api_service.dart';
import 'package:weather_app/core/constants/api_endpoints.dart';
import 'package:weather_app/data/controllers/auth_controller.dart';
import 'package:weather_app/data/models/user_model.dart';

class LoginProvider extends ChangeNotifier {
  bool _loginInProgress = false;
  String? _errorMessage;

  bool get loginInProgress => _loginInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String email, dynamic password) async {
    bool isSuccess = false;

    _loginInProgress = true;
    notifyListeners();

    Map<String,dynamic> requestBody = {
      "email" : email,
      "password" : password
    };

    final ApiResponse response = await ApiService.postRequest(url: ApiEndpoints.authLogin, body: requestBody);

    _loginInProgress = false;
    notifyListeners();

    if (response.isSuccess){
      UserModel model = UserModel.fromJson(response.responseData["user"]);
      String token = response.responseData["access_token"];
      await AuthController.saveUserData(model, token);

      _errorMessage = response.errorMessage.toString();
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage.toString();
    }

    return isSuccess;


  }

}