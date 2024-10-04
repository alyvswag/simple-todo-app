import 'package:objectbox/objectbox.dart';

@Entity()
class TodoModel {
  @Id()
  int id;
  String text;
  bool isDone;

  TodoModel({this.id = 0, required this.text, this.isDone = false});
}
