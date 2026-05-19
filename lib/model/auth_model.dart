class LoginRequest {
  final String mobile;

  const LoginRequest({required this.mobile});

  Map<String, dynamic> toJson() => {'mobile': mobile};
}

class RegisterRequest {
  final String name;
  final String mobile;
  final String email;
  final String role;

  const RegisterRequest({
    required this.name,
    required this.mobile,
    required this.email,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'mobile': mobile,
    'email': email,
    'role': role,
  };
}

class VerifyOtpRequest {
  final String mobile;
  final String token;
  final String otp;

  const VerifyOtpRequest({
    required this.mobile,
    required this.token,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
    'mobile': mobile,
    'token': token,
    'otp': otp,
  };
}

class ResendOtpRequest {
  final String mobile;

  const ResendOtpRequest({required this.mobile});

  Map<String, dynamic> toJson() => {'mobile': mobile};
}

class LoginResponse {
  final bool success;
  final bool exists;
  final String message;
  final String token;

  const LoginResponse({
    required this.success,
    required this.exists,
    required this.message,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json['success'] as bool? ?? false,
    exists: json['exists'] as bool? ?? false,
    message: json['message'] as String? ?? '',
    token: json['token'] as String? ?? '',
  );

  @override
  String toString() =>
      'LoginResponse(success: $success, exists: $exists, message: $message, token: $token)';
}

class RegisterResponse {
  final bool success;
  final String message;
  final String token;

  const RegisterResponse({
    required this.success,
    required this.message,
    required this.token,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        success: json['success'] as bool? ?? false,
        message: json['message'] as String? ?? '',
        token: json['token'] as String? ?? '',
      );

  @override
  String toString() =>
      'RegisterResponse(success: $success, message: $message, token: $token)';
}

// class VerifyOtpResponse {
//   final bool success;
//   final String message;
//   final String? token;
//   final UserModel? user;

//   const VerifyOtpResponse({
//     required this.success,
//     required this.message,
//     this.token,
//     this.user,
//   });

//   factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
//       VerifyOtpResponse(
//         success: json['success'] as bool? ?? false,
//         message: json['message'] as String? ?? '',
//         token: json['token'] as String?,
//         user: json['user'] != null
//             ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
//             : null,
//       );

//   @override
//   String toString() =>
//       'VerifyOtpResponse(success: $success, message: $message, token: $token)';
// }

class VerifyOtpResponse {
  final bool success;
  final String message;
  final String? token;
  final UserModel? user;

  const VerifyOtpResponse({
    required this.success,
    required this.message,
    this.token,
    this.user,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      VerifyOtpResponse(
        success: json['success'] as bool? ?? false,
        message: json['message'] as String? ?? '',
        // ✅ Check both "jwtToken" and "token" field names
        token: (json['jwtToken'] ?? json['token']) as String?,
        user: json['user'] != null
            ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
            : null,
      );

  @override
  String toString() =>
      'VerifyOtpResponse(success: $success, message: $message, token: $token)';
}

class ResendOtpResponse {
  final bool success;
  final String message;
  final String token;

  const ResendOtpResponse({
    required this.success,
    required this.message,
    required this.token,
  });

  factory ResendOtpResponse.fromJson(Map<String, dynamic> json) =>
      ResendOtpResponse(
        success: json['success'] as bool? ?? false,
        message: json['message'] as String? ?? '',
        token: json['token'] as String? ?? '',
      );

  @override
  String toString() =>
      'ResendOtpResponse(success: $success, message: $message, token: $token)';
}

class UserModel {
  final String? id;
  final String name;
  final String mobile;
  final String email;
  final String role;

  const UserModel({
    this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String?,
    name: json['name'] as String? ?? '',
    mobile: json['mobile'] as String? ?? '',
    email: json['email'] as String? ?? '',
    role: json['role'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'mobile': mobile,
    'email': email,
    'role': role,
  };

  UserModel copyWith({
    String? id,
    String? name,
    String? mobile,
    String? email,
    String? role,
  }) => UserModel(
    id: id ?? this.id,
    name: name ?? this.name,
    mobile: mobile ?? this.mobile,
    email: email ?? this.email,
    role: role ?? this.role,
  );

  @override
  String toString() =>
      'UserModel(id: $id, name: $name, mobile: $mobile, email: $email, role: $role)';
}

class ApiResult<T> {
  final T? data;
  final String? errorMessage;
  final bool isSuccess;

  const ApiResult._({this.data, this.errorMessage, required this.isSuccess});

  factory ApiResult.success(T data) => ApiResult._(data: data, isSuccess: true);

  factory ApiResult.failure(String message) =>
      ApiResult._(errorMessage: message, isSuccess: false);

  bool get isFailure => !isSuccess;

  @override
  String toString() => isSuccess
      ? 'ApiResult.success($data)'
      : 'ApiResult.failure($errorMessage)';
}
