import 'dart:io';
import 'package:brublaapp/helper/shared_preference.dart';
import 'package:brublaapp/services/auth/profile_image_service.dart';
import 'package:flutter/foundation.dart';
import 'package:brublaapp/constant/api_constant.dart';

enum ProfileImageState { idle, loading, success, error }

class ProfileImageProvider extends ChangeNotifier {
  ProfileImageState _state = ProfileImageState.idle;
  String _errorMessage = '';
  String _successMessage = '';
  String? _updatedImageUrl;

  ProfileImageState get state => _state;
  String get errorMessage => _errorMessage;
  String get successMessage => _successMessage;
  String? get updatedImageUrl => _updatedImageUrl;

  bool get isLoading => _state == ProfileImageState.loading;

  Future<bool> updateProfileImage(File imageFile) async {
    final userId = SharedPrefsHelper.getUserId();
    final token = SharedPrefsHelper.getAuthToken();

    if (userId == null || token == null) {
      _setError('Session expired. Please login again.');
      return false;
    }

    _setState(ProfileImageState.loading);

    final result = await ProfileImageService.updateProfileImage(
      userId: userId,
      token: token,
      imageFile: imageFile,
    );

    final bool success = result[ApiConstants.keySuccess] == true;

    if (success) {
      _updatedImageUrl = result['data']?['profileImage'] as String?;
      _successMessage =
          result[ApiConstants.keyMessage] as String? ??
          'Profile image updated successfully';
      _setState(ProfileImageState.success);
      return true;
    } else {
      _setError(
        result[ApiConstants.keyMessage] as String? ?? 'Failed to update image',
      );
      return false;
    }
  }

  void reset() {
    _state = ProfileImageState.idle;
    _errorMessage = '';
    _successMessage = '';
    _updatedImageUrl = null;
    notifyListeners();
  }

  void _setState(ProfileImageState state) {
    _state = state;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    _setState(ProfileImageState.error);
  }
}