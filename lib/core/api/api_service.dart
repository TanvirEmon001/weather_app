import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class ApiService {
  static final Logger _logger = Logger();

  static Future<ApiResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);

      final Response response = await get(uri);
      _logResponse(url, response);

      final int statusCode = response.statusCode;

      if (statusCode == 200) {
        // SUCCESS BODY
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: true,
          responseCode: statusCode,
          responseData: decodedData,
        );
      } else {
        // FAILED BODY
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: false,
          responseCode: statusCode,
          responseData: decodedData,
        );
      }
    } on Exception catch (e) {
      _logger.e("GET Exception: $e");
      return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  } //get request method ends here

  static Future<ApiResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, body: body);

      final Response response = await post(uri, headers: {
        'Content-Type': 'application/json',
      }, body: jsonEncode(body));
      _logResponse(url, response);

      final int statusCode = response.statusCode;
      if (statusCode == 201 || statusCode == 200) {
        // Success
        final decodedJson = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: true,
          responseCode: statusCode,
          responseData: decodedJson,
          errorMessage: decodedJson["message"]
        );
      } else {
        // failed
        final decodedJson = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: false,
          responseCode: statusCode,
          responseData: decodedJson,
          errorMessage: decodedJson['message']
        );
      }
    } on Exception catch (e) {
      _logger.e("Get Exception: $e");
      return ApiResponse(
        isSuccess: false,
        responseCode: -2,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

  static void _logRequest(String url, {Map<String, dynamic>? body}) {
    _logger.i(
      'URL => $url\n'
      'Request Body: $body',
    );
  }

  static void _logResponse(String url, Response response) {
    _logger.i(
      'URL => $url\n'
      'Status Code: ${response.statusCode}\n'
      'Body: ${response.body}',
    );
  }
}

class ApiResponse {
  final bool isSuccess;
  final int responseCode;
  final dynamic responseData;
  final String? errorMessage;

  ApiResponse({
    required this.isSuccess,
    required this.responseCode,
    required this.responseData,
    this.errorMessage = 'Something went wrong...',
  });
}
