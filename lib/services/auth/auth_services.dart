// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:brublaapp/constant/api_constant.dart';
import 'package:brublaapp/model/auth_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();
  final http.Client _client = http.Client();

  Map<String, String> get _headers => {
    ApiConstants.contentType: ApiConstants.applicationJson,
  };

  Future<ApiResult<LoginResponse>> login(LoginRequest request) async {
    return _post<LoginResponse>(
      url: ApiConstants.login,
      body: request.toJson(),
      fromJson: LoginResponse.fromJson,
    );
  }

  Future<ApiResult<VerifyOtpResponse>> verifyLoginOtp(
    VerifyOtpRequest request,
  ) async {
    return _post<VerifyOtpResponse>(
      url: ApiConstants.loginVerifyOtp,
      body: request.toJson(),
      fromJson: VerifyOtpResponse.fromJson,
    );
  }

  Future<ApiResult<RegisterResponse>> register(RegisterRequest request) async {
    return _post<RegisterResponse>(
      url: ApiConstants.register,
      body: request.toJson(),
      fromJson: RegisterResponse.fromJson,
    );
  }

  Future<ApiResult<VerifyOtpResponse>> verifyRegisterOtp(
    VerifyOtpRequest request,
  ) async {
    return _post<VerifyOtpResponse>(
      url: ApiConstants.registerVerifyOtp,
      body: request.toJson(),
      fromJson: VerifyOtpResponse.fromJson,
    );
  }

  Future<ApiResult<ResendOtpResponse>> resendOtp(
    ResendOtpRequest request,
  ) async {
    return _post<ResendOtpResponse>(
      url: ApiConstants.resendOtp,
      body: request.toJson(),
      fromJson: ResendOtpResponse.fromJson,
    );
  }

  Future<ApiResult<T>> _post<T>({
    required String url,
    required Map<String, dynamic> body,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      print("🌍 API URL: $url");
      print("📤 Request Body: ${jsonEncode(body)}");
      print("📋 Headers: $_headers");
      final response = await _client
          .post(Uri.parse(url), headers: _headers, body: jsonEncode(body))
          .timeout(ApiConstants.connectTimeout);

      print("✅ Status Code: ${response.statusCode}");
      print("📥 Response Body: ${response.body}");

      return _handleResponse<T>(response, fromJson);
    } on SocketException {
      return ApiResult.failure(
        'No internet connection. Please check your network.',
      );
    } on HttpException {
      return ApiResult.failure('Unable to reach the server. Try again later.');
    } on FormatException {
      return ApiResult.failure('Unexpected server response format.');
    } catch (e) {
      return ApiResult.failure('Something went wrong: ${e.toString()}');
    }
  }

  ApiResult<T> _handleResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      final Map<String, dynamic> json =
          jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final bool success = json[ApiConstants.keySuccess] as bool? ?? false;
        if (success) {
          return ApiResult.success(fromJson(json));
        } else {
          final msg =
              json[ApiConstants.keyMessage] as String? ??
              'Request failed. Please try again.';
          return ApiResult.failure(msg);
        }
      }

      final msg =
          json[ApiConstants.keyMessage] as String? ??
          'Server error (${response.statusCode})';
      return ApiResult.failure(msg);
    } catch (_) {
      return ApiResult.failure(
        'Failed to parse server response (${response.statusCode}).',
      );
    }
  }

  void dispose() => _client.close();
}
