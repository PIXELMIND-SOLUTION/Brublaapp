import 'package:brublaapp/constant/api_constant.dart';
import 'package:brublaapp/model/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  SharedPrefsHelper._();

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get _instance {
    assert(
      _prefs != null,
      'SharedPrefsHelper not initialised. Call SharedPrefsHelper.init() first.',
    );
    return _prefs!;
  }

  static Future<void> saveUserId(String id) =>
      _instance.setString(ApiConstants.prefUserId, id);

  static String? getUserId() => _instance.getString(ApiConstants.prefUserId);

  static Future<void> saveUserAbout(String about) =>
      _instance.setString(ApiConstants.prefUserAbout, about);

  static String? getUserAbout() =>
      _instance.getString(ApiConstants.prefUserAbout);

  static Future<bool> saveAuthToken(String token) =>
      _instance.setString(ApiConstants.prefAuthToken, token);

  static String? getAuthToken() =>
      _instance.getString(ApiConstants.prefAuthToken);

  static Future<bool> setLoggedIn(bool value) =>
      _instance.setBool(ApiConstants.prefIsLoggedIn, value);

  static bool isLoggedIn() =>
      _instance.getBool(ApiConstants.prefIsLoggedIn) ?? false;

  static Future<void> saveUserMobile(String mobile) =>
      _instance.setString(ApiConstants.prefUserMobile, mobile);

  static String? getUserMobile() =>
      _instance.getString(ApiConstants.prefUserMobile);

  static Future<void> saveUserName(String name) =>
      _instance.setString(ApiConstants.prefUserName, name);

  static String? getUserName() =>
      _instance.getString(ApiConstants.prefUserName);

  static Future<void> saveUserEmail(String email) =>
      _instance.setString(ApiConstants.prefUserEmail, email);

  static String? getUserEmail() =>
      _instance.getString(ApiConstants.prefUserEmail);

  static Future<void> saveUserRole(String role) =>
      _instance.setString(ApiConstants.prefUserRole, role);

  static String? getUserRole() =>
      _instance.getString(ApiConstants.prefUserRole);

  // static Future<void> saveUser(UserModel user) async {
  //   await Future.wait([
  //     saveUserMobile(user.mobile),
  //     saveUserName(user.name),
  //     saveUserEmail(user.email),
  //     saveUserRole(user.role),
  //   ]);
  // }

  static Future<void> saveUser(UserModel user) async {
    await Future.wait([
      saveUserMobile(user.mobile),
      saveUserName(user.name),
      saveUserEmail(user.email),
      saveUserRole(user.role),
      saveUserId(user.id.toString()),
    ]);
  }

  static UserModel? getUser() {
    final mobile = getUserMobile();
    if (mobile == null) return null;
    return UserModel(
      name: getUserName() ?? '',
      mobile: mobile,
      email: getUserEmail() ?? '',
      role: getUserRole() ?? '',
    );
  }

  static Future<void> saveSession({
    required String token,
    required String mobile,
  }) async {
    await Future.wait([
      saveAuthToken(token),
      saveUserMobile(mobile),
      setLoggedIn(true),
    ]);
  }

  static Future<void> clearSession() async {
    await Future.wait([
      _instance.remove(ApiConstants.prefAuthToken),
      _instance.remove(ApiConstants.prefUserMobile),
      _instance.remove(ApiConstants.prefUserName),
      _instance.remove(ApiConstants.prefUserEmail),
      _instance.remove(ApiConstants.prefUserRole),
      _instance.remove(ApiConstants.prefIsLoggedIn),
    ]);
  }
}
