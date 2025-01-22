import 'package:todo_dart/app/http/controllers/todo_controller.dart';
import 'package:todo_dart/app/http/middleware/authenticate.dart';
import 'package:vania/vania.dart';

import '../app/http/controllers/auth_controller.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api');

    // Router.get("/home", homeController.index);

    // Router.get("/hello-world", () {
    //   return Response.html('Hello World');
    // }).middleware([HomeMiddleware()]);

    // // Return error code 400
    // Router.get('wrong-request',
    //         () => Response.json({'message': 'Hi wrong request'}))
    //     .middleware([ErrorResponseMiddleware()]);

    // Return Authenticated user data
    Router.get("/user", () {
      return Response.json(Auth().user());
    }).middleware([AuthenticateMiddleware()]);

    Router.group(prefix: 'todo', () {
      Router.get('/', todoController.index)
          .middleware([AuthenticateMiddleware()]);
      // Router.get('/create', todoController.create);
      Router.post('/store', todoController.store)
          .middleware([AuthenticateMiddleware()]);
      // Router.get('/:id', todoController.show);
      // Router.get('/:id/edit', todoController.edit);
      // Router.put('/:id', todoController.update);
      // Router.delete('/:id', todoController.destroy);
    });

    Router.group(prefix: 'auth', () {
      Router.post('register', authController.register);
      Router.post('login', authController.login);
    });
  }
}
