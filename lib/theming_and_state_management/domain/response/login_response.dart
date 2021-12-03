import 'package:deliveryapp/theming_and_state_management/domain/models/user.dart';

class LoginResponse {
  final String token;
  final User user;

  const LoginResponse({required this.token, required this.user});
}
