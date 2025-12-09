import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_app/view/screens/auth/login_screen.dart';
import 'package:weather_app/view/screens/auth/registration_screen.dart';

import '../../../data/controllers/auth_controller.dart';
import '../weather_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "/splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _cloudAnimation1;
  late Animation<Offset> _cloudAnimation2;
  late Animation<Offset> _sunAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Scale animation for the main logo
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    // Fade animation for the text
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeInOut),
      ),
    );

    // Cloud animations
    _cloudAnimation1 = Tween<Offset>(
      begin: const Offset(-1.5, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );

    _cloudAnimation2 = Tween<Offset>(
      begin: const Offset(1.5, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    // Sun animation
    _sunAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.6, curve: Curves.bounceOut),
      ),
    );

    _controller.forward();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    final bool isLoggedIn = await AuthController.isLoggedIn();

    if (isLoggedIn){
      await AuthController.getUserData();
      Navigator.pushNamedAndRemoveUntil(context, WeatherScreen.route, (predicate) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.route, (predicate) => false);
    }

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: Stack(
        children: [
          // Animated Background Elements
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: _BackgroundPainter(
                    animationValue: _controller.value,
                  ),
                );
              },
            ),
          ),

          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Sun
                SlideTransition(
                  position: _sunAnimation,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.yellow.shade300.withOpacity(0.9),
                          Colors.orange.withOpacity(0.7),
                          Colors.deepOrange.withOpacity(0.5),
                        ],
                        stops: const [0.1, 0.5, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.4),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.wb_sunny,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Animated Clouds
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Left Cloud
                    SlideTransition(
                      position: _cloudAnimation1,
                      child: Container(
                        width: 100,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.1),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Main Logo Container
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.blue.shade800.withOpacity(0.9),
                              Colors.purple.shade800.withOpacity(0.9),
                              Colors.indigo.shade800.withOpacity(0.9),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.4),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.2),
                              blurRadius: 60,
                              spreadRadius: 20,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.cloud,
                          color: Colors.white,
                          size: 80,
                        ),
                      ),
                    ),

                    // Right Cloud
                    SlideTransition(
                      position: _cloudAnimation2,
                      child: Container(
                        width: 120,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.1),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 60),

                // App Name with Fade Animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      Text(
                        'Weather Pro',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              color: Colors.blue.withOpacity(0.5),
                              blurRadius: 20,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Weather Forecast App',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.7),
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 60),

                // Loading Indicator with Fade
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation(
                        Colors.blue.withOpacity(0.8),
                      ),
                      backgroundColor: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Version Info
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Animated Particles
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: _ParticlePainter(
                    animationValue: _controller.value,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for Animated Background
class _BackgroundPainter extends CustomPainter {
  final double animationValue;

  _BackgroundPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // Animated gradient background
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFF0A0E21).withOpacity(1.0),
        Colors.blue.shade900.withOpacity(0.8 * animationValue),
        Colors.purple.shade900.withOpacity(0.6 * animationValue),
        const Color(0xFF0A0E21).withOpacity(1.0),
      ],
      stops: [0.0, 0.3 * animationValue, 0.7 * animationValue, 1.0],
    );

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    paint.shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);

    // Draw some animated circles/particles in background
    final particleCount = 15;
    for (int i = 0; i < particleCount; i++) {
      final radius = 2.0 + (i % 3).toDouble();
      final x = (size.width / particleCount) * i;
      final y = size.height * (0.2 + 0.6 * (i % 5) / 5);

      final particlePaint = Paint()
        ..color = Colors.white.withOpacity(
          0.05 * (1.0 + 0.5 * sin(animationValue * 2 * pi + i * 0.5)),
        )
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), radius, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Custom Painter for Floating Particles
class _ParticlePainter extends CustomPainter {
  final double animationValue;

  _ParticlePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final particleCount = 30;

    for (int i = 0; i < particleCount; i++) {
      final progress = (animationValue + i * 0.05) % 1.0;
      final radius = 1.0 + (i % 3).toDouble();
      final x = size.width * (0.1 + 0.8 * progress);
      final y = size.height * (0.1 + 0.8 * sin(progress * pi * 2 + i * 0.3));

      final alpha = 0.1 * (1.0 - progress);
      final particlePaint = Paint()
        ..color = Colors.white.withOpacity(alpha)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), radius, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}