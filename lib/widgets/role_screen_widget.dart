// pubspec.yaml
// shared_preferences: ^2.2.2

import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveRole(String role) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_role', role); 
}