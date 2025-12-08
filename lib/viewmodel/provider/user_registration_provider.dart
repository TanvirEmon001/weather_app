
import 'package:flutter/foundation.dart';
import 'package:weather_app/core/api/api_service.dart';
import 'package:weather_app/core/constants/api_endpoints.dart';

class UserRegistrationProvider extends ChangeNotifier {
  bool _registrationInProgress = false;
  String? _errorMessage;

  bool get registrationInProgress => _registrationInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> registration(String name, String email, String location, dynamic password) async {
    bool isSuccess = false;

    _registrationInProgress = true;
    _errorMessage = null;
    notifyListeners();

    try{
      Map<String,dynamic> requestBody = {
        "name" : name,
        "email" : email,
        "location" : location,
        "password" : password,
      };

      final ApiResponse response = await ApiService.postRequest(url: ApiEndpoints.authRegister, body: requestBody);


      if (response.isSuccess){
        isSuccess = true;
          _errorMessage = "Registration successful";
      } else {
        isSuccess = false;
        _errorMessage = response.errorMessage.toString();
      }
    } on Exception catch (e){
      isSuccess = false;
      _errorMessage = e.toString();
    } finally {
      _registrationInProgress = false;
      notifyListeners();
    }

    return isSuccess;
  }






}