import 'package:flutter/material.dart';
import 'package:todo_project/screens/home_screen.dart';
import 'package:todo_project/services/objectbox_service.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

late final ObjectboxService dbService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  dbService = await ObjectboxService.init();

  runApp(const TodoList());
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
