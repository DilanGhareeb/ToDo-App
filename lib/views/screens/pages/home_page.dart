import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:todo_app/controllers/notifiers/todo_item_notifier.dart';
import 'package:todo_app/controllers/services/database.dart';
import 'package:todo_app/views/screens/pages/sub_pages/note_adders.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late AppDatabase database;
  var deleteItem = -1;
  var deletedTitle = '';
  var deletedDescription = '';

  @override
  void initState() {
    super.initState();
    database = AppDatabase();
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(todoItemNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO APP"),
        centerTitle: true,
      ),
      body: Center(
          child: list.when(
        data: (data) {
          return data.isEmpty
              ? const Text("Nothing to show")
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: index == deleteItem
                          ? Text(
                              data[index].title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough,
                              ),
                            )
                          : Text(
                              data[index].title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      subtitle: Text(
                        data[index].description,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                deleteItem = index;
                              });
                              deletedTitle = data[index].title;
                              deletedDescription = data[index].description;
                              Future.delayed(Duration(seconds: 5), () {
                                ref
                                    .read(todoItemNotifierProvider.notifier)
                                    .deleteTodo(
                                      id: data[index].id,
                                    );
                                setState(() {
                                  deleteItem = -1;
                                });
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      Text(
                                        "You have successfully delted the Todo",
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          ref
                                              .read(todoItemNotifierProvider
                                                  .notifier)
                                              .createTodo(
                                                title: deletedTitle,
                                                description: deletedDescription,
                                              );
                                        },
                                        child: Text("Undo"),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
        error: (error, stackTrace) {
          return null;
        },
        loading: () {
          return Skeletonizer(
            enabled: true,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("data[index].title"),
                  subtitle: Text(
                      "data[index].description .........................."),
                );
              },
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => const ToDoAdders(),
          ));
        },
        shape: const CircleBorder(),
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }
}
