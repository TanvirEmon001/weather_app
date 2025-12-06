// lib/view/widgets/weather_details_grid.dart
import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather_model.dart';

class WeatherDetailsGrid extends StatelessWidget {
  final CurrentWeather current;

  const WeatherDetailsGrid({super.key, required this.current});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12, // Reduced spacing
      mainAxisSpacing: 12, // Reduced spacing
      childAspectRatio: 1.3, // Increased aspect ratio for more vertical space
      children: [
        _buildDetailCard(
          Icons.visibility,
          '${current.visibility?.toStringAsFixed(1) ?? "0"} km',
          'Visibility',
          Colors.blue,
        ),
        _buildDetailCard(
          Icons.cloud,
          '${current.cloudcover}%',
          'Cloud Cover',
          Colors.lightBlue,
        ),
        _buildDetailCard(
          Icons.water,
          '${current.precip.toStringAsFixed(1)} mm',
          'Precipitation',
          Colors.cyan,
        ),
        _buildDetailCard(
          Icons.brightness_6,
          current.uvIndex.toString(),
          'UV Index',
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildDetailCard(IconData icon, String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(12), // Reduced padding
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24), // Reduced icon size
          const SizedBox(height: 6), // Reduced spacing
          Flexible( // Added Flexible to prevent overflow
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16, // Reduced font size
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 4), // Reduced spacing
          Text(
            label,
            style: TextStyle(
              fontSize: 12, // Reduced font size
              color: Colors.white.withOpacity(0.7),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}