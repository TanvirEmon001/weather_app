// lib/view/widgets/air_quality_card.dart
import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather_model.dart';

class AirQualityCard extends StatelessWidget {
  final AirQuality airQuality;

  const AirQualityCard({super.key, required this.airQuality});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12), // Reduced from 16
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16), // Reduced from 20
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Important: Use min size
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.air, color: Colors.white, size: 16), // Smaller
                  const SizedBox(width: 6),
                  Text(
                    'Air Quality',
                    style: TextStyle(
                      fontSize: 14, // Smaller
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 120, // Limit width of the AQI label
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: airQuality.airQualityColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: airQuality.airQualityColor),
                ),
                child: Text(
                  airQuality.airQualityText,
                  style: TextStyle(
                    fontSize: 11, // Smaller
                    fontWeight: FontWeight.bold,
                    color: airQuality.airQualityColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (airQuality.usEpaIndex ?? 0) / 6,
            backgroundColor: Colors.white.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation(airQuality.airQualityColor),
            borderRadius: BorderRadius.circular(6),
            minHeight: 6,
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible( // Use Flexible for the PM2.5 text
                child: Text(
                  'PM2.5: ${airQuality.pm25?.toStringAsFixed(1) ?? '--'} µg/m³',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible( // Use Flexible for the AQI text
                child: Text(
                  'AQI: ${airQuality.usEpaIndex ?? '--'}',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}