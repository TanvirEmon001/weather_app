import 'package:flutter/material.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/data/models/weather_model.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherRepository _repository;
  WeatherModel? _weather;
  WeatherState _state = WeatherState.initial;
  String? _errorMessage;
  List<String> _recentCities = [];

  WeatherViewModel(this._repository);

  WeatherModel? get weather => _weather;
  WeatherState get state => _state;
  String? get errorMessage => _errorMessage;
  List<String> get recentCities => _recentCities;

  Future<void> fetchWeather(String city) async {
    try {
      _state = WeatherState.loading;
      notifyListeners();

      _weather = await _repository.getWeather(city);

      // Add to recent cities if not already present
      if (!_recentCities.contains(city)) {
        _recentCities.insert(0, city);
        if (_recentCities.length > 5) {
          _recentCities.removeLast();
        }
      }

      _state = WeatherState.loaded;
      _errorMessage = null;
    } catch (e) {
      _state = WeatherState.error;
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> refreshWeather() async {
    if (_weather != null) {
      await fetchWeather('${_weather!.location.name}, ${_weather!.location.country}');
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  String get temperatureText {
    if (_weather == null) return '--';
    return '${_weather!.current.temperature.toInt()}°';
  }

  String get weatherDescription {
    if (_weather == null) return '--';
    return _weather!.current.weatherDescriptions.firstOrNull ?? 'Clear';
  }

  String get locationText {
    if (_weather == null) return '--';
    return '${_weather!.location.name}, ${_weather!.location.country}';
  }

  String get formattedTime {
    if (_weather == null) return '--';
    final time = _weather!.location.localtime;
    try {
      final dateTime = DateTime.parse(time);
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return time;
    }
  }

  bool get hasAirQualityData => _weather?.current.airQuality?.hasData ?? false;
}

enum WeatherState {
  initial,
  loading,
  loaded,
  error,
}