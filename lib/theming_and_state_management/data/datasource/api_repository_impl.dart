import 'package:deliveryapp/theming_and_state_management/domain/exception/auth_exception.dart';
import 'package:deliveryapp/theming_and_state_management/domain/models/products.dart';
import 'package:deliveryapp/theming_and_state_management/domain/response/login_response.dart';
import 'package:deliveryapp/theming_and_state_management/domain/request/login_request.dart';
import 'package:deliveryapp/theming_and_state_management/domain/models/user.dart';
import 'package:deliveryapp/theming_and_state_management/domain/respository/api_repository.dart';

import '../in_memory_products.dart';

class ApiRepositoryImpl extends ApiRepositoryInterface {
  @override
  Future<User> getUserFromToken(String token) async {
    // Conectarse con http o firebase, etc.

    await Future.delayed(const Duration(seconds: 3));

    if (token == 'AA111') {
      return User(
        name: 'Andres Racines',
        username: 'andrew',
        image: 'assets/others/andrew.jpeg',
      );
    } else if (token == 'AA222') {
      return User(
        name: 'Bugs Bunny',
        username: 'bunny',
        image: 'assets/others/bugs.jpg',
      );
    }

    throw AuthException();
  }

  @override
  Future<LoginResponse> login(LoginRequest login) async {
    await Future.delayed(const Duration(seconds: 3));

    if (login.username == 'andrew' && login.password == 'racin') {
      return LoginResponse(
        token: 'AA111',
        user: User(
          name: 'Andres Racines',
          username: 'andrew',
          image: 'assets/others/andrew.jpeg',
        ),
      );
    } else if (login.username == 'bunny' && login.password == '123') {
      return LoginResponse(
        token: 'AA222',
        user: User(
          name: 'Bugs Bunny',
          username: 'bunny',
          image: 'assets/others/bugs.jpg',
        ),
      );
    }

    throw AuthException();
  }

  @override
  Future<void> logout(String token) async {
    print('removing toker from server $token');
  }

  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return products;
  }
}
