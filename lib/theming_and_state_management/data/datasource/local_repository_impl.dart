import 'package:deliveryapp/theming_and_state_management/domain/models/user.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/local_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _preftoken = 'TOKEN';
const _prefusername = 'USERNAME';
const _prefname = 'NAME';
const _prefimage = 'IMAGE';
const _pref_dark_theme = 'THEME_DARK';
const no_image = 'assets/others/no_image.jpg';

class LocalRepositoryImpl extends LocalRepositoryInterface {
  @override
  Future<void> clearAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  @override
  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_preftoken);
  }

  @override
  Future<String> saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_preftoken, token);
    return token;
  }

  @override
  Future<User> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final username = sharedPreferences.getString(_prefusername);
    final name = sharedPreferences.getString(_prefname);
    final image = sharedPreferences.getString(_prefimage);

    final user = User(
      name: name,
      username: username,
      image: image,
    );

    return user;
  }

  @override
  Future<User?> saveUser(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(_prefusername, user.username ?? '');
    sharedPreferences.setString(_prefname, user.name ?? '');
    sharedPreferences.setString(_prefimage, user.image ?? '');
    return user;
  }

  @override
  Future<bool?> isDarkMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(_pref_dark_theme);
  }

  @override
  Future<void> saveDarkMode(bool darkMode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_pref_dark_theme, darkMode);
  }
}
