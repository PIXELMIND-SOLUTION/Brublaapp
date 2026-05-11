class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'http://31.97.228.17:4077';
  static const String apiVersion = '/api';
  static const String _base = '$baseUrl$apiVersion';

  static const String login = '$_base/users/login';
  static const String loginVerifyOtp = '$_base/users/login/verify-otp';

  static const String register = '$_base/users/register';
  static const String registerVerifyOtp = '$_base/users/register/verify-otp';

  static const String resendOtp = '$_base/users/resend-otp';

  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';

  static const String keyMobile = 'mobile';
  static const String keyName = 'name';
  static const String keyEmail = 'email';
  static const String keyRole = 'role';
  static const String keyToken = 'token';
  static const String keyOtp = 'otp';

  static const String keySuccess = 'success';
  static const String keyExists = 'exists';
  static const String keyMessage = 'message';

  static const String prefAuthToken = 'auth_token';
  static const String prefUserMobile = 'user_mobile';
  static const String prefUserName = 'user_name';
  static const String prefUserEmail = 'user_email';
  static const String prefUserRole = 'user_role';
  static const String prefIsLoggedIn = 'is_logged_in';

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}