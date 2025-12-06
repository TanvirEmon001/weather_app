// lib/view/widgets/weather_card.dart
import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final current = weather.current;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade800.withOpacity(0.6),
            Colors.purple.shade800.withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${current.temperature.toInt()}°',
                    style: const TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 0.9,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Feels like ${current.feelslike.toInt()}°',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getWeatherIcon(current.weatherCode),
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    current.weatherDescriptions.first,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Additional info row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherItem(Icons.water_drop, '${current.humidity}%', 'Humidity'),
                _buildWeatherItem(Icons.air, '${current.windSpeed} km/h', 'Wind'),
                _buildWeatherItem(Icons.compress, '${current.pressure} hPa', 'Pressure'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(int weatherCode) {
    // Simplified mapping - you can expand this based on weatherstack codes
    if (weatherCode >= 200 && weatherCode < 300) return Icons.thunderstorm;
    if (weatherCode >= 300 && weatherCode < 400) return Icons.grain;
    if (weatherCode >= 500 && weatherCode < 600) return Icons.umbrella;
    if (weatherCode >= 600 && weatherCode < 700) return Icons.ac_unit;
    if (weatherCode >= 700 && weatherCode < 800) return Icons.foggy;
    if (weatherCode == 800) return Icons.wb_sunny;
    if (weatherCode > 800) return Icons.cloud;
    return Icons.wb_sunny;
  }

  Widget _buildWeatherItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}