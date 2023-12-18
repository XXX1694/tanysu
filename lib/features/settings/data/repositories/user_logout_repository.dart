import 'package:shared_preferences/shared_preferences.dart';

final _storage = SharedPreferences.getInstance();

class UserLogOutRepository {
  logOut() async {
    final storage = await _storage;
    storage.remove('auth_token');
  }
}
