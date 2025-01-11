import 'package:todo_dart/app/http/controllers/home_controller.dart';
import 'package:todo_dart/app/http/middleware/authenticate.dart';
import 'package:todo_dart/app/http/middleware/error_response_middleware.dart';
import 'package:todo_dart/app/http/middleware/home_middleware.dart';
import 'package:vania/vania.dart';

import '../app/http/controllers/auth_controller.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api');

    Router.get("/home", homeController.index);

    Router.get("/hello-world", () {
      return Response.html('Hello World');
    }).middleware([HomeMiddleware()]);

    // Return error code 400
    Router.get('wrong-request',
            () => Response.json({'message': 'Hi wrong request'}))
        .middleware([ErrorResponseMiddleware()]);

    // Return Authenticated user data
    Router.get("/user", () {
      return Response.json(Auth().user());
    }).middleware([AuthenticateMiddleware()]);

    Router.group(prefix: 'auth', () {
      Router.post('register', authController.register);
    });
  }
}
