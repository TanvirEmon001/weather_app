import 'package:flutter/material.dart';
import 'dart:convert';

class WeatherModel {
  final Location location;
  final CurrentWeather current;
  final Request? request;

  WeatherModel({
    required this.location,
    required this.current,
    this.request,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: Location.fromJson(json['location']),
      current: CurrentWeather.fromJson(json['current']),
      request: json['request'] != null
          ? Request.fromJson(json['request'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
    "current": current.toJson(),
    "request": request?.toJson(),
  };
}

class Request {
  final String? type;
  final String? query;
  final String? language;
  final String? unit;

  Request({
    this.type,
    this.query,
    this.language,
    this.unit,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      type: json['type'],
      query: json['query'],
      language: json['language'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() => {
    "type": type,
    "query": query,
    "language": language,
    "unit": unit,
  };
}

class Location {
  final String name;
  final String country;
  final String? region;
  final double lat;
  final double lon;
  final String timezoneId;
  final String localtime;
  final int localtimeEpoch;
  final String utcOffset;

  Location({
    required this.name,
    required this.country,
    this.region,
    required this.lat,
    required this.lon,
    required this.timezoneId,
    required this.localtime,
    required this.localtimeEpoch,
    required this.utcOffset,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      region: json['region'],
      lat: double.tryParse(json['lat'].toString()) ?? 0.0,
      lon: double.tryParse(json['lon'].toString()) ?? 0.0,
      timezoneId: json['timezone_id'] ?? '',
      localtime: json['localtime'] ?? '',
      localtimeEpoch: json['localtime_epoch'] ?? 0,
      utcOffset: json['utc_offset']?.toString() ?? '0',
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "country": country,
    "region": region,
    "lat": lat,
    "lon": lon,
    "timezone_id": timezoneId,
    "localtime": localtime,
    "localtime_epoch": localtimeEpoch,
    "utc_offset": utcOffset,
  };
}

class CurrentWeather {
  final String? observationTime;
  final double temperature;
  final int weatherCode;
  final List<String> weatherIcons;
  final List<String> weatherDescriptions;
  final Astro? astro;
  final AirQuality? airQuality;
  final double windSpeed;
  final int windDegree;
  final String windDir;
  final int pressure;
  final double precip;
  final int humidity;
  final int cloudcover;
  final double feelslike;
  final int uvIndex;
  final double? visibility;
  final bool isDay;

  CurrentWeather({
    this.observationTime,
    required this.temperature,
    required this.weatherCode,
    required this.weatherIcons,
    required this.weatherDescriptions,
    this.astro,
    this.airQuality,
    required this.windSpeed,
    required this.windDegree,
    required this.windDir,
    required this.pressure,
    required this.precip,
    required this.humidity,
    required this.cloudcover,
    required this.feelslike,
    required this.uvIndex,
    this.visibility,
    required this.isDay,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      observationTime: json['observation_time'],
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.0,
      weatherCode: json['weather_code'] ?? 0,
      weatherIcons: List<String>.from(json['weather_icons'] ?? []),
      weatherDescriptions: List<String>.from(json['weather_descriptions'] ?? []),
      astro: json['astro'] != null ? Astro.fromJson(json['astro']) : null,
      airQuality: json['air_quality'] != null
          ? AirQuality.fromJson(json['air_quality'])
          : null,
      windSpeed: (json['wind_speed'] as num?)?.toDouble() ?? 0.0,
      windDegree: json['wind_degree'] ?? 0,
      windDir: json['wind_dir'] ?? '',
      pressure: json['pressure'] ?? 0,
      precip: (json['precip'] as num?)?.toDouble() ?? 0.0,
      humidity: json['humidity'] ?? 0,
      cloudcover: json['cloudcover'] ?? 0,
      feelslike: (json['feelslike'] as num?)?.toDouble() ?? 0.0,
      uvIndex: json['uv_index'] ?? 0,
      visibility: (json['visibility'] as num?)?.toDouble(),
      isDay: json['is_day'] == "yes",
    );
  }

  Map<String, dynamic> toJson() => {
    "observation_time": observationTime,
    "temperature": temperature,
    "weather_code": weatherCode,
    "weather_icons": weatherIcons,
    "weather_descriptions": weatherDescriptions,
    "astro": astro?.toJson(),
    "air_quality": airQuality?.toJson(),
    "wind_speed": windSpeed,
    "wind_degree": windDegree,
    "wind_dir": windDir,
    "pressure": pressure,
    "precip": precip,
    "humidity": humidity,
    "cloudcover": cloudcover,
    "feelslike": feelslike,
    "uv_index": uvIndex,
    "visibility": visibility,
    "is_day": isDay ? "yes" : "no",
  };
}

class Astro {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;
  final int moonIllumination;

  Astro({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.moonIllumination,
  });

  factory Astro.fromJson(Map<String, dynamic> json) {
    return Astro(
      sunrise: json['sunrise'] ?? '',
      sunset: json['sunset'] ?? '',
      moonrise: json['moonrise'] ?? '',
      moonset: json['moonset'] ?? '',
      moonPhase: json['moon_phase'] ?? '',
      moonIllumination: json['moon_illumination'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "sunrise": sunrise,
    "sunset": sunset,
    "moonrise": moonrise,
    "moonset": moonset,
    "moon_phase": moonPhase,
    "moon_illumination": moonIllumination,
  };
}

class AirQuality {
  final double? co;
  final double? no2;
  final double? o3;
  final double? so2;
  final double? pm25;
  final double? pm10;
  final int? usEpaIndex;
  final int? gbDefraIndex;

  AirQuality({
    this.co,
    this.no2,
    this.o3,
    this.so2,
    this.pm25,
    this.pm10,
    this.usEpaIndex,
    this.gbDefraIndex,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) {
    return AirQuality(
      co: _parseDouble(json['co']),
      no2: _parseDouble(json['no2']),
      o3: _parseDouble(json['o3']),
      so2: _parseDouble(json['so2']),
      pm25: _parseDouble(json['pm2_5']),
      pm10: _parseDouble(json['pm10']),
      usEpaIndex: _parseInt(json['us-epa-index']),
      gbDefraIndex: _parseInt(json['gb-defra-index']),
    );
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  Map<String, dynamic> toJson() => {
    "co": co,
    "no2": no2,
    "o3": o3,
    "so2": so2,
    "pm2_5": pm25,
    "pm10": pm10,
    "us-epa-index": usEpaIndex,
    "gb-defra-index": gbDefraIndex,
  };

  String get airQualityText {
    final index = usEpaIndex ?? 0;
    switch (index) {
      case 1:
        return 'Good';
      case 2:
        return 'Moderate';
      case 3:
        return 'Unhealthy for Sensitive Groups';
      case 4:
        return 'Unhealthy';
      case 5:
        return 'Very Unhealthy';
      case 6:
        return 'Hazardous';
      default:
        return 'Unknown';
    }
  }

  Color get airQualityColor {
    final index = usEpaIndex ?? 0;
    switch (index) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.red;
      case 5:
        return Colors.purple;
      case 6:
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  bool get hasData => usEpaIndex != null;
}