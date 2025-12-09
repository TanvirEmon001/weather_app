import 'package:flutter/foundation.dart';
import 'package:weather_app/core/api/api_service.dart';
import 'package:weather_app/core/constants/api_endpoints.dart';
import 'package:weather_app/data/controllers/auth_controller.dart';
import 'package:weather_app/data/models/user_model.dart';

class EditProfileProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  UserModel? _user;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserModel? get user => _user;

  Future<bool> updateProfile({Map<String, String>? requestBody}) async {
    bool isSuccess = false;

    _isLoading = true;
    notifyListeners();

    final ApiResponse response = await ApiService.putRequest(
      ApiEndpoints.updateProfile,
      requestBody: requestBody,
    );
    _isLoading = false;
    notifyListeners();

    if(response.isSuccess){
      UserModel userModel = UserModel.fromJson(response.responseData["user"]);
      await AuthController.updateUserData(userModel);
      await AuthController.getUserData();
      _errorMessage = response.errorMessage.toString();
      isSuccess = true;
      _user = userModel;
      notifyListeners();
    } else {
      _errorMessage = response.errorMessage.toString();
    }

    return isSuccess;
  }
}
