import 'package:weather_app/data/models/weather_model.dart';

import '../../core/api/api_service.dart';
import '../../core/constants/api_endpoints.dart';

abstract class WeatherRepository {
  Future<WeatherModel> getWeather(String city);
}

class WeatherRepositoryImpl implements WeatherRepository {
  @override
  Future<WeatherModel> getWeather(String city) async {
    final url = ApiEndpoints.url(
      'current',
      query: city,
      extra: {
        'units': 'm', // metric units
      },
    );

    final response = await ApiService.getRequest(url);

    if (response.isSuccess && response.responseData != null) {
      return WeatherModel.fromJson(response.responseData);
    } else {
      throw Exception(
          response.errorMessage ?? 'Failed to fetch weather data'
      );
    }
  }
}