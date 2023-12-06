import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_keep/helpers/auth_helper.dart';
import 'package:note_keep/providers/todo_provider.dart';
import 'package:note_keep/screens/add_todo_screen.dart';
import 'package:note_keep/screens/splash_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TodoProvider todoProvider;
  @override
  void initState() {
    todoProvider = Provider.of<TodoProvider>(context, listen: false);
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("What To Do?"),
          backgroundColor: Color.fromARGB(255, 128, 158, 186),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await AuthHelper.instance.logout();
                Get.to(() => const SplashScreen());
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddTodoScreen()));
          },
          child: const Icon(Icons.add),
        ),
        body: Consumer<TodoProvider>(
          builder: (context, todoProvider, child) {
            return todoProvider.todos.isEmpty
                ? const Center(
                    child: Text("No todo added"),
                  )
                : ListView.builder(
                    itemCount: todoProvider.todos.length,
                    itemBuilder: (context, index) => Card(
                          elevation: 10,
                          shadowColor: Colors.white30,
                          color: Color.fromARGB(255, 222, 226, 231),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: todoProvider.todos[index].isDone,
                                      onChanged: (value) {
                                        setState(() {
                                          todoProvider.todos[index].isDone =
                                              value!;
                                          todoProvider.updateTodo(
                                            index,
                                            todoProvider.todos[index],
                                          );
                                        });
                                      },
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              todoProvider.todos[index].title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "(${todoProvider.todos[index].createdAt.day}-${todoProvider.todos[index].createdAt.month}-${todoProvider.todos[index].createdAt.year})",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Text(todoProvider
                                            .todos[index].description)
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Color.fromARGB(255, 234, 100, 90),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      todoProvider.removeTodo(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                   
                    );
          },
        ));
  }

  void getData() async {
    await todoProvider.getTodo();
  }
}
