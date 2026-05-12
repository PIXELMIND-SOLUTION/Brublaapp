import 'package:brublaapp/helper/shared_preference.dart';
import 'package:brublaapp/model/auth_model.dart';
import 'package:brublaapp/services/auth/auth_services.dart';
import 'package:flutter/foundation.dart';

enum AuthState { idle, loading, otpSent, authenticated, error }

enum AuthFlow { login, register }

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService.instance;

  AuthState _state = AuthState.idle;
  AuthState get state => _state;

  AuthFlow _flow = AuthFlow.login;
  AuthFlow get flow => _flow;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _successMessage;
  String? get successMessage => _successMessage;

  String? _pendingToken;
  String? get pendingToken => _pendingToken;

  String? _pendingMobile;
  String? get pendingMobile => _pendingMobile;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  bool get isAuthenticated => _state == AuthState.authenticated;
  bool get isLoading => _state == AuthState.loading;

  Future<void> initSession() async {
    if (SharedPrefsHelper.isLoggedIn()) {
      _currentUser = SharedPrefsHelper.getUser();
      _setState(AuthState.authenticated);
    }
  }

  Future<void> login(String mobile) async {
    _flow = AuthFlow.login;
    _pendingMobile = mobile;
    _setState(AuthState.loading);

    final result = await _service.login(LoginRequest(mobile: mobile));

    if (result.isSuccess) {
      _pendingToken = result.data!.token;
      _successMessage = result.data!.message;
      _clearError();
      _setState(AuthState.otpSent);
    } else {
      _setError(result.errorMessage!);
    }
  }

  Future<void> verifyLoginOtp(String otp) async {
    if (_pendingMobile == null || _pendingToken == null) {
      _setError('Session expired. Please login again.');
      return;
    }

    _setState(AuthState.loading);

    final result = await _service.verifyLoginOtp(
      VerifyOtpRequest(
        mobile: _pendingMobile!,
        token: _pendingToken!,
        otp: otp,
      ),
    );

    if (result.isSuccess) {
      await _persistSession(
        token: result.data!.token ?? _pendingToken!,
        mobile: _pendingMobile!,
        user: result.data!.user,
      );
      _successMessage = result.data!.message;
      _clearError();
      _setState(AuthState.authenticated);
    } else {
      _setError(result.errorMessage!);
    }
  }

  Future<void> register({
    required String name,
    required String mobile,
    required String email,
    required String role,
  }) async {
    _flow = AuthFlow.register;
    _pendingMobile = mobile;
    _setState(AuthState.loading);

    final result = await _service.register(
      RegisterRequest(name: name, mobile: mobile, email: email, role: role),
    );

    if (result.isSuccess) {
      _pendingToken = result.data!.token;
      _successMessage = result.data!.message;

      _currentUser = UserModel(
        name: name,
        mobile: mobile,
        email: email,
        role: role,
      );

      _clearError();
      _setState(AuthState.otpSent);
    } else {
      _setError(result.errorMessage!);
    }
  }

  Future<void> verifyRegisterOtp(String otp) async {
    if (_pendingMobile == null || _pendingToken == null) {
      _setError('Session expired. Please register again.');
      return;
    }

    _setState(AuthState.loading);

    final result = await _service.verifyRegisterOtp(
      VerifyOtpRequest(
        mobile: _pendingMobile!,
        token: _pendingToken!,
        otp: otp,
      ),
    );

    if (result.isSuccess) {
      await _persistSession(
        token: result.data!.token ?? _pendingToken!,
        mobile: _pendingMobile!,
        user: result.data!.user ?? _currentUser,
      );
      _successMessage = result.data!.message;
      _clearError();
      _setState(AuthState.authenticated);
    } else {
      _setError(result.errorMessage!);
    }
  }

  Future<void> resendOtp() async {
    if (_pendingMobile == null) {
      _setError('Mobile number not found. Please start again.');
      return;
    }

    _setState(AuthState.loading);

    final result = await _service.resendOtp(
      ResendOtpRequest(mobile: _pendingMobile!),
    );

    if (result.isSuccess) {
      _pendingToken = result.data!.token;
      _successMessage = result.data!.message;
      _clearError();
      _setState(AuthState.otpSent);
    } else {
      _setError(result.errorMessage!);
    }
  }

  Future<void> logout() async {
    await SharedPrefsHelper.clearSession();
    _currentUser = null;
    _pendingToken = null;
    _pendingMobile = null;
    _clearError();
    _setState(AuthState.idle);
  }

  // Future<void> _persistSession({
  //   required String token,
  //   required String mobile,
  //   UserModel? user,
  // }) async {
  //   await SharedPrefsHelper.saveSession(token: token, mobile: mobile);
  //   if (user != null) {
  //     await SharedPrefsHelper.saveUser(user);
  //     _currentUser = user;
  //   }
  // }

  Future<void> _persistSession({
    required String token,
    required String mobile,
    UserModel? user,
  }) async {
    await SharedPrefsHelper.saveSession(token: token, mobile: mobile);
    if (user != null) {
      await SharedPrefsHelper.saveUser(user);
      await SharedPrefsHelper.saveUserId(user.id.toString());
      _currentUser = user;
    }
  }

  void _setState(AuthState newState) {
    _state = newState;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    _state = AuthState.error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }

  void reset() {
    _state = AuthState.idle;
    _errorMessage = null;
    _successMessage = null;
    _pendingToken = null;
    _pendingMobile = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }
}
