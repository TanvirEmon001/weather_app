# Weather App with User Authentication

A feature-rich Flutter application that provides real-time weather data and a secure user authentication system, including advanced identity verification.

## 🚀 Key Features

* **Real-time Weather:** Integrated with an OpenWeatherMap-style API (Free Plan) to provide current weather details.
* **Secure Authentication:** Complete Login and Sign-up flow.
* **OTP Verification:** Secure password recovery system using One-Time Passwords (OTP) for the "Forgot Password" process.
* **Responsive UI:** A modern, clean interface built with Flutter.

## 🛠️ Tech Stack

* **Frontend:** [Flutter](https://flutter.dev/) (Dart)
* **Weather Data:** Open Weather API (Free Plan)
* **Backend/Auth:** [Add your backend here, e.g., Firebase / Node.js]
* **OTP Service:** [Add your service here, e.g., Email/SMS or Firebase Auth]

## 📸 Screenshots

| Login Page | Weather Home | OTP Verification |
| :--- | :--- | :--- |
| ![Login](https://via.placeholder.com/200x400?text=Login+UI) | ![Home](https://via.placeholder.com/200x400?text=Weather+UI) | ![OTP](https://via.placeholder.com/200x400?text=OTP+UI) |

## 🏁 Getting Started

### Prerequisites

* Flutter SDK installed on your machine.
* A valid API Key from [OpenWeatherMap](https://openweathermap.org/api).

### Installation

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/your-username/weather_app.git](https://github.com/your-username/weather_app.git)
    ```
2.  **Navigate to the project directory:**
    ```bash
    cd weather_app
    ```
3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Configuration:**
    Create a configuration file (or update your constants file) with your Weather API Key:
    ```dart
    const String weatherApiKey = "YOUR_API_KEY_HERE";
    ```
5.  **Run the application:**
    ```bash
    flutter run
    ```

## 🔒 Authentication Flow

1.  **Sign Up/Login:** Users enter credentials to access weather data.
2.  **Forgot Password:** Initiates a request that sends an OTP to the user's registered contact.
3.  **OTP Verification:** Secure verification screen to validate the user before allowing a password reset.

## 📄 Documentation

For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, and full API reference.