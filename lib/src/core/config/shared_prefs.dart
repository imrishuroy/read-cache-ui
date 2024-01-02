import 'package:shared_preferences/shared_preferences.dart';

const _token = 'token';

class SharedPrefs {
  factory SharedPrefs() => SharedPrefs._internal();
  SharedPrefs._internal();
  static SharedPreferences? _sharedPrefs;

  static Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  static Future<void> setToken({required String token}) async {
    if (_sharedPrefs != null) {
      await _sharedPrefs?.setString(
        _token,
        token,
      );
    }
  }

  static String? getToken() {
    return _sharedPrefs?.getString(_token);
  }

  static Future<void> clear() async {
    await _sharedPrefs?.clear();
  }
}
