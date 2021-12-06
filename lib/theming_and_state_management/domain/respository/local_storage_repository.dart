import 'package:deliveryapp/theming_and_state_management/domain/models/user.dart';

abstract class LocalRepositoryInterface {
// Define que cosas quiero hacer (es como un contrato)
// La implementacion la puedo hacer en lo que yo quiera
// En este caso puede ser Hive, shared_preferences, etc.

  Future<String?> getToken();
  Future<void> clearAllData();
  Future<String?> saveToken(String token);
  Future<User?> getUser();
  Future<User?> saveUser(User user);
  Future<void> saveDarkMode(bool darkMode);
  Future<bool?> isDarkMode();
}
