import 'dart:io';
import 'package:dio/dio.dart';
import 'package:brublaapp/constant/api_constant.dart';

class ProfileImageService {
  ProfileImageService._();

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
    ),
  );

  static Future<Map<String, dynamic>> updateProfileImage({
    required String userId,
    required String token,
    required File imageFile,
  }) async {
    try {
      final fileName = imageFile.path.split('/').last;

      final formData = FormData.fromMap({
        ApiConstants.keyProfileImage: await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      final response = await _dio.post(
        ApiConstants.updateProfileImage(userId),
        data: formData,
        options: Options(
          headers: {
            ApiConstants.authorization: '${ApiConstants.bearer} $token',
          },
        ),
      );

      print('✅ Response status code for profile image ${response.statusCode}');
      print(
        '📶 Response  bodddddyyyyyyyyyyyyyy for profile image ${response.data}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data as Map<String, dynamic>;
      }

      return {
        ApiConstants.keySuccess: false,
        ApiConstants.keyMessage: 'Unexpected status: ${response.statusCode}',
      };
    } on DioException catch (e) {
      return {
        ApiConstants.keySuccess: false,
        ApiConstants.keyMessage:
            e.response?.data?[ApiConstants.keyMessage] ??
            e.message ??
            'Something went wrong',
      };
    } catch (e) {
      return {
        ApiConstants.keySuccess: false,
        ApiConstants.keyMessage: e.toString(),
      };
    }
  }
}
