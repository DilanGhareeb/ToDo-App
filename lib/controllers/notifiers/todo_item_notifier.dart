import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/controllers/services/database.dart';

part 'todo_item_notifier.g.dart';

@riverpod
class TodoItemNotifier extends _$TodoItemNotifier {
  final db = AppDatabase();

  @override
  FutureOr<List<TodoItem>> build() async {
    // Fetch all todo items from the database
    return await db.select(db.todoItems).get();
  }

  // Create a new Todo item
  Future<void> createTodo({
    required String title,
    required String description,
  }) async {
    await db.managers.todoItems.create(
      (row) => row(title: title, description: description),
    );
    // Refresh the state to include the new item
    final result = await db.select(db.todoItems).get();
    state = AsyncData(result);
  }

  // Update an existing Todo item
  Future<void> updateTodo({
    required int id,
    String? title,
    String? description,
    bool? isCompleted,
  }) async {
    await db.update(db.todoItems).replace(
          TodoItem(
            id: id,
            title: title ?? '',
            description: description ?? '',
          ),
        );
    // Refresh the state to reflect the update
    final result = await db.select(db.todoItems).get();
    state = AsyncData(result);
  }

  // Delete a Todo item
  Future<void> deleteTodo({
    required int id,
  }) async {
    await db.delete(db.todoItems).delete(
          TodoItem(
            id: id,
            title: '',
            description: '',
          ),
        );
    // Refresh the state to reflect the deletion
    final result = await db.select(db.todoItems).get();
    state = AsyncData(result);
  }

  // Fetch all items (refresh state explicitly)
  Future<void> fetchTodos() async {
    final result = await db.select(db.todoItems).get();
    state = AsyncData(result);
  }
}
