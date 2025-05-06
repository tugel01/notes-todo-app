import 'package:isar/isar.dart';

// file generator
// run: dart run build_runner build
part 'todo.g.dart';

@Collection()
class Todo {
  Id id = Isar.autoIncrement;
  late String name;
  late bool taskDone;
}