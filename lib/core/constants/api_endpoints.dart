class ApiEndpoints {
  static const String _baseUrl = "http://api.weatherstack.com";
  static const String _accessKey = "7d76cc4a990086b91a147a00a808eade";
  static const String _authBaseUrl = "http://192.168.10.129:5001/api/auth";



  static const String authRegister = "$_authBaseUrl/register";
  static const String authLogin = "$_authBaseUrl/login";
  static const String authForgotPassword = "$_authBaseUrl/forgot-password";
  static const String authVerifyOtp = "$_authBaseUrl/verify-otp";
  static const String authResetPassword = "$_authBaseUrl/reset-password";





  // final URL maker for any endpoint
  static String url(String endpoint, {required String query, Map<String, String>? extra}) {
    final Map<String, String> params = {
      "access_key": _accessKey,
      "query": query,
    };

    if (extra != null) {
      params.addAll(extra);
    }

    final queryString =
    params.entries.map((e) => "${e.key}=${e.value}").join("&");

    return "$_baseUrl/$endpoint?$queryString";
  }



}
