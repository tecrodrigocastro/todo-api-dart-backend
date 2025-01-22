import 'package:vania/vania.dart';

import '../../models/user.dart';

class AuthController extends Controller {
  Future<Response> register(Request request) async {
    final data = request.all();

    final user = await User().query().create({
      "name": data['name'],
      "email": data['email'],
      "password": data['password']
    });

    return Response.json({
      'success': true,
      'message': "User Registered",
      'data': user,
    });
  }

  Future<Response> login(Request request) async {
    final data = request.all();

    final user =
        await User().query().where('email', '=', data['email']).first();

    if (user == null) {
      return Response.json({
        'success': false,
        'message': "User not found",
      }, 404);
    }

    if (user['password'] != data['password']) {
      return Response.json({
        'success': false,
        'message': "Password not match",
      }, 401);
    }

    final token = await Auth().login(user).createToken(
          expiresIn: Duration(hours: 24),
          withRefreshToken: true,
        );

    return Response.json({
      'success': true,
      'message': "Login Success",
      'data': {
        'user': user,
        'token': token,
      },
    });
  }
}

final AuthController authController = AuthController();
