// lib/view/screens/weather_screen.dart (updated)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/controllers/auth_controller.dart';
import 'package:weather_app/viewmodel/weather_viewmodel.dart';
import 'package:weather_app/view/widgets/weather_card.dart';
import 'package:weather_app/view/widgets/air_quality_card.dart';
import 'package:weather_app/view/widgets/weather_details_grid.dart';
import 'package:weather_app/view/widgets/astro_card.dart';
import 'profile_screen.dart';

class WeatherScreen extends StatefulWidget {
  static const String route = "/weather";
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _showSearch = false;
  int _currentIndex = 0; // For bottom navigation
  final List<Widget> _screens = []; // Will hold our screens

  @override
  void initState() {
    super.initState();
    // Initialize screens
    _screens.add(_buildWeatherContent());
    _screens.add(const ProfileScreen());

    // Load default city on start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherViewModel>().fetchWeather(AuthController.userModel?.location ?? "Dhaka");
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: SafeArea(
        child: Column(
          children: [
            // Only show header on weather screen
            if (_currentIndex == 0) _buildHeader(context),

            // Main content area
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: _screens,
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0A0E21),
          border: Border(
            top: BorderSide(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF0A0E21),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.white.withOpacity(0.6),
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedFontSize: 12,
          unselectedFontSize: 12,
        ),
      ),
    );
  }

  // Build the weather content as a widget
  Widget _buildWeatherContent() {
    return Consumer<WeatherViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          children: [
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildBody(viewModel),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    final viewModel = Provider.of<WeatherViewModel>(context, listen: true);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              if (!_showSearch)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        viewModel.locationText,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Updated: ${viewModel.formattedTime}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              if (_showSearch)
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search city...',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          setState(() => _showSearch = false);
                          _searchController.clear();
                        },
                      ),
                    ),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        viewModel.fetchWeather(value.trim());
                        setState(() => _showSearch = false);
                        _searchController.clear();
                      }
                    },
                  ),
                ),
              const SizedBox(width: 16),
              IconButton(
                icon: Icon(
                  _showSearch ? Icons.search_off : Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() => _showSearch = !_showSearch);
                  if (_showSearch) {
                    _searchFocusNode.requestFocus();
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: viewModel.state != WeatherState.loading
                    ? viewModel.refreshWeather
                    : null,
              ),
            ],
          ),

          // Recent cities chips
          if (viewModel.recentCities.isNotEmpty && !_showSearch)
            const SizedBox(height: 12),
          if (viewModel.recentCities.isNotEmpty && !_showSearch)
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.recentCities.length,
                itemBuilder: (context, index) {
                  final city = viewModel.recentCities[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ActionChip(
                      label: Text(
                        city,
                        style: const TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.blue.withOpacity(0.3),
                      onPressed: () => viewModel.fetchWeather(city),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBody(WeatherViewModel viewModel) {
    switch (viewModel.state) {
      case WeatherState.initial:
        return _buildInitialView();
      case WeatherState.loading:
        return _buildLoadingView();
      case WeatherState.loaded:
        return _buildWeatherView(viewModel);
      case WeatherState.error:
        return _buildErrorView(viewModel);
    }
  }

  Widget _buildInitialView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud,
            size: 80,
            color: Colors.white.withOpacity(0.5),
          ),
          const SizedBox(height: 20),
          Text(
            'Search for a city',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation(Colors.blue[400]!),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Fetching weather data...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(WeatherViewModel viewModel) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red.withOpacity(0.7),
            ),
            const SizedBox(height: 20),
            Text(
              'Error',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              viewModel.errorMessage ?? 'Failed to fetch weather data',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => viewModel.refreshWeather(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherView(WeatherViewModel viewModel) {
    final weather = viewModel.weather!;
    final current = weather.current;

    return RefreshIndicator(
      backgroundColor: const Color(0xFF0A0E21),
      color: Colors.blue,
      onRefresh: () async => viewModel.refreshWeather(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Main weather card
            WeatherCard(weather: weather),

            // Air quality (if available)
            if (viewModel.hasAirQualityData && current.airQuality != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: AirQualityCard(airQuality: current.airQuality!),
              ),

            // Weather details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: WeatherDetailsGrid(current: current),
            ),

            // Astronomical data (if available)
            if (current.astro != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
                child: AstroCard(astro: current.astro!),
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}