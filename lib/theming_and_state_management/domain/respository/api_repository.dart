import 'package:deliveryapp/theming_and_state_management/domain/models/user.dart';
import 'package:deliveryapp/theming_and_state_management/domain/request/login_request.dart';
import 'package:deliveryapp/theming_and_state_management/domain/response/login_response.dart';

abstract class ApiRepository {
  Future<User> getUserFromToken(String token);

  Future<LoginResponse> login(LoginRequest login);
}
