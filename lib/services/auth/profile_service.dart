import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:brublaapp/constant/api_constant.dart';
import 'package:brublaapp/model/user_profile_model.dart';

class UserProfileService {
  UserProfileService._();

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      headers: {ApiConstants.contentType: ApiConstants.applicationJson},
    ),
  );

  static Options _authOptions(String token) => Options(
    headers: {ApiConstants.authorization: '${ApiConstants.bearer} $token'},
  );

  static Future<UserProfileModel?> fetchUser({
    required String userId,
    required String token,
  }) async {
    final url = ApiConstants.userProfile(userId);

    try {
      final response = await _dio.get(url, options: _authOptions(token));

      print(
        '🟢 Response  Status Code for get user profile: ${response.statusCode}',
      );

      print('📦 Response Body for get user Profile: ${response.data}');

      final body = response.data is String
          ? jsonDecode(response.data as String) as Map<String, dynamic>
          : response.data as Map<String, dynamic>;

      if (body[ApiConstants.keySuccess] == true && body['user'] != null) {
        return UserProfileModel.fromJson(body['user'] as Map<String, dynamic>);
      }

      throw Exception(body[ApiConstants.keyMessage] ?? 'Failed to fetch user');
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      rethrow;
    }
  }

  static Future<UserProfileModel> updateUser({
    required String userId,
    required String token,
    required String name,
    required String email,
    required String about,
  }) async {
    final url = ApiConstants.updateUser(userId);

    final response = await _dio.put(
      url,
      data: jsonEncode({
        ApiConstants.keyName: name,
        ApiConstants.keyEmail: email,
        ApiConstants.keyAbout: about,
      }),
      options: _authOptions(token),
    );

    print('🟢 Response Status Code for update profile: ${response.statusCode}');
    print('📦 Response Body for Update profile: ${response.data}');
    print('🙍 Nameeeeeeeeeeeeeeeeeeeee: $name');
    print('✉️ Emmaaaaailllllllllllllll: $email');
    print('📝 aabbbbouttttttttttttttt:  $about');

    final body = response.data is String
        ? jsonDecode(response.data as String) as Map<String, dynamic>
        : response.data as Map<String, dynamic>;

    if (body[ApiConstants.keySuccess] == true && body['user'] != null) {
      return UserProfileModel.fromJson(body['user'] as Map<String, dynamic>);
    }

    throw Exception(body[ApiConstants.keyMessage] ?? 'Failed to update user');
  }
}
