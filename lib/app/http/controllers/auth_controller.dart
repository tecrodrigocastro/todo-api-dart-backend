import 'package:vania/vania.dart';

class AuthController extends Controller {
  Future<Response> register(Request request) async {
    final data = request.all();
    return Response.json({'data': data});
  }
}

final AuthController authController = AuthController();
