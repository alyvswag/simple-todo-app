import 'package:todo_project/models/todo_model.dart';
import 'package:todo_project/objectbox.g.dart';
// Person modelini daxil edin

class ObjectboxService {
  late final Store _store; // Verilənlər bazası Store obyekti
  late final Box<TodoModel> _todoBox; // Person üçün Box

  ObjectboxService._create(this._store) {
    _todoBox = _store.box<TodoModel>(); // Person üçün Box başlat
  }

  // Singleton pattern - yalnız bir instance
  static Future<ObjectboxService> init() async {
    final store = await openStore(); // Verilənlər bazası faylını aç
    return ObjectboxService._create(store);
  }

  // Verilənlər bazasını bağlamaq üçün metod
  void close() {
    _store.close();
  }

  List<TodoModel> currentTodos = [];

  // Person əlavə etmək üçün metod
  void addTodo(String? textTodo) {
    final todo = TodoModel(text: textTodo!);
    _todoBox.put(todo);
    getAllTodos();
    // ID geri qaytarır
  }

  // Bütün Personları almaq üçün metod
  void getAllTodos() {
    currentTodos = _todoBox.getAll(); // Bütün Person obyektləri
  }

  // ID ilə Person almaq üçün metod
  TodoModel? getTodoById(int id) {
    return _todoBox.get(id); // ID-ə görə person qaytarır
  }

  // Person silmək üçün metod
  void deleteTodo(int id) {
    _todoBox.remove(id);
    getAllTodos();
    // Uğurla silindiyini qaytarır
  }

  // Bütün Personları silmək üçün metod
  void deleteAllTodo() {
    _todoBox.removeAll();
    getAllTodos();
  }

  // Person yeniləmək üçün metod
  void updateTodo(TodoModel todo) {
    _todoBox.put(todo, mode: PutMode.update);
    getAllTodos();
  }
}
