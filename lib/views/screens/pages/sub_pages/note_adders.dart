import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/controllers/notifiers/todo_item_notifier.dart';

class ToDoAdders extends ConsumerStatefulWidget {
  const ToDoAdders({super.key});

  @override
  ConsumerState<ToDoAdders> createState() => _ToDoAddersState();
}

class _ToDoAddersState extends ConsumerState<ToDoAdders> {
  @override
  Widget build(BuildContext context) {
    final todoNotifier = ref.read(todoItemNotifierProvider.notifier);
    final TextEditingController titleCrl = TextEditingController();
    final TextEditingController descriptionCrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Adding Todo"),
        actions: [
          InkWell(
            onTap: () async {
              todoNotifier.createTodo(
                  title: titleCrl.text, description: descriptionCrl.text);
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.check),
            ),
          ),
          SizedBox(width: 20)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              controller: titleCrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter the title",
                labelText: "Title",
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionCrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter the description",
                labelText: "Description",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
