import 'package:brublaapp/helper/shared_preference.dart';
import 'package:brublaapp/services/auth/profile_service.dart';
import 'package:flutter/foundation.dart';
import 'package:brublaapp/model/user_profile_model.dart';

enum ProfileState { idle, loading, success, error }

class UserProfileProvider extends ChangeNotifier {
  ProfileState _fetchState = ProfileState.idle;
  ProfileState _updateState = ProfileState.idle;
  UserProfileModel? _user;
  String? _errorMessage;

  ProfileState get fetchState => _fetchState;
  ProfileState get updateState => _updateState;
  UserProfileModel? get user => _user;
  String? get errorMessage => _errorMessage;

  bool get isFetchLoading => _fetchState == ProfileState.loading;
  bool get isUpdateLoading => _updateState == ProfileState.loading;

  Future<void> fetchProfile() async {
    final token = SharedPrefsHelper.getAuthToken();
    final userId = SharedPrefsHelper.getUserId();

    print('🆔 userrrrrrrrrrrrrrrrrrrrrr idddddddddddddddddddddd $userId');

    print('🔑 tokkkkkkkkkkkkkkkeeeeeeeeeeeeeeeeeeeen $token');

    if (token == null || userId == null) {
      _setError('Session expired. Please log in again.');
      return;
    }

    _fetchState = ProfileState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await UserProfileService.fetchUser(
        userId: userId,
        token: token,
      );

      if (result == null) {
        _setError('User not found.');
        return;
      }

      _user = result;
      _fetchState = ProfileState.success;

      await SharedPrefsHelper.saveUserName(result.name);
      await SharedPrefsHelper.saveUserEmail(result.email);
      await SharedPrefsHelper.saveUserRole(result.role);
    } catch (e) {
      _setError(_friendlyError(e));
    } finally {
      notifyListeners();
    }
  }

  Future<bool> updateProfile({
    required String name,
    required String email,
    required String about,
  }) async {
    final token = SharedPrefsHelper.getAuthToken();
    final userId = SharedPrefsHelper.getUserId();

    if (token == null || userId == null) {
      _setError('Session expired. Please log in again.');
      return false;
    }

    _updateState = ProfileState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final updated = await UserProfileService.updateUser(
        userId: userId,
        token: token,
        name: name,
        email: email,
        about: about,
      );

      _user = updated;
      _updateState = ProfileState.success;

      await SharedPrefsHelper.saveUserName(updated.name);
      await SharedPrefsHelper.saveUserEmail(updated.email);

      notifyListeners();
      return true;
    } catch (e) {
      _setError(_friendlyError(e));
      return false;
    }
  }

  void clearUser() {
    _user = null;
    _fetchState = ProfileState.idle;
    _updateState = ProfileState.idle;
    _errorMessage = null;
    notifyListeners();
  }

  void resetUpdateState() {
    _updateState = ProfileState.idle;
    notifyListeners();
  }
  

  void _setError(String message) {
    _errorMessage = message;
    _fetchState = ProfileState.error;
    _updateState = ProfileState.error;
  }

  String _friendlyError(Object e) {
    final msg = e.toString();
    if (msg.contains('SocketException') || msg.contains('connection')) {
      return 'No internet connection.';
    }
    if (msg.contains('401')) return 'Unauthorised. Please log in again.';
    if (msg.contains('500')) return 'Server error. Please try again later.';
    return msg.replaceFirst('Exception: ', '');
  }
}
