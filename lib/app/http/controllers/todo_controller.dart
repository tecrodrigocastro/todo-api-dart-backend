import 'package:todo_dart/app/models/todo.dart';
import 'package:vania/vania.dart';

class TodoController extends Controller {
  Future<Response> index() async {
    final user = Auth().user();
    if (user == null) {
      return Response.json({
        'success': false,
        'message': "User not found",
      }, 404);
    }
    final todos = await Todo().query().where('user_id', '=', user['id']).get();
    return Response.json({
      'success': true,
      'message': "Get Todo Success",
      'data': todos,
    });
  }

  Future<Response> create() async {
    return Response.json({});
  }

  Future<Response> store(Request request) async {
    final data = request.all();
    final user = Auth().user();

    if (user == null) {
      return Response.json({
        'success': false,
        'message': "User not found",
      }, 404);
    }

    final todo = await Todo().query().create({
      "title": data['title'],
      "description": data['description'],
      "is_done": 0,
      "user_id": user['id'],
    });

    return Response.json({
      'success': true,
      'message': "Create Todo Success",
      'data': todo,
    });
  }

  Future<Response> show(int id) async {
    return Response.json({});
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }

  Future<Response> update(Request request, int id) async {
    return Response.json({});
  }

  Future<Response> destroy(int id) async {
    return Response.json({});
  }
}

final TodoController todoController = TodoController();
