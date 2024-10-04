import 'package:flutter/material.dart';
import 'package:todo_project/main.dart';
import 'package:todo_project/models/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _databaseService = dbService;
  final _textFieldController = TextEditingController();

  void _getTodoList() {
    _databaseService.getAllTodos();
    setState(() {});
  }

  void _addTodo() {
    if (_textFieldController.text.isEmpty) return;
    _databaseService.addTodo(_textFieldController.text);
    _textFieldController.clear();
    setState(() {});
  }

  void _updateTodo(TodoModel todo) {
    _databaseService.updateTodo(todo);
    setState(() {});
  }

  void _deleteTodo(int id) {
    _databaseService.deleteTodo(id);
    setState(() {});
  }

  @override
  void initState() {
    _getTodoList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        backgroundColor: Colors.blue.shade700,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: Center(
        child: Column(
          children: [_addTodoWidget(), _todoListWidget()],
        ),
      ),
    );
  }

  Expanded _todoListWidget() {
    return Expanded(
      child: ListView.separated(
        itemCount: _databaseService.currentTodos.length,
        itemBuilder: (context, index) {
          final TodoModel todo = _databaseService.currentTodos[index];
          return Dismissible(
            key: UniqueKey(),
            background: Container(
              color: const Color.fromARGB(255, 100, 178, 102),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20.0),
              child: const Icon(Icons.check, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: const Color.fromARGB(255, 220, 108, 100),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                todo.isDone = !todo.isDone;
                _updateTodo(todo);
              } else if (direction == DismissDirection.endToStart) {
                _deleteTodo(todo.id);
              }
            },
            child: ListTile(
              title: Text(
                todo.text,
              ),
              tileColor: todo.isDone
                  ? const Color.fromARGB(255, 100, 178, 102)
                  : Colors.grey.shade300,
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(
          height: 2,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }

  Container _addTodoWidget() {
    return Container(
      margin: const EdgeInsets.all(14),
      child: TextField(
        controller: _textFieldController,
        decoration: InputDecoration(
            hintText: "Not yazın...",
            suffixIcon: IconButton(
                onPressed: () {
                  _addTodo();
                },
                icon: const Icon(Icons.add)),
            border: const OutlineInputBorder(),
            isDense: true),
      ),
    );
  }
}
