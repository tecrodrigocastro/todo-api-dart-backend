import 'package:vania/vania.dart';

class CreateTodoTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('todos', () {
      id();
      string('title');
      string('description');
      tinyInt('is_done');
      string('user_id');
      foreign('user_id', 'users', 'id', onDelete: 'CASCADE');
      timeStamps();
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('todos');
  }
}
