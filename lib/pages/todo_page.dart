import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/dialog.dart';
import 'package:flutter_application_1/components/drawer.dart';
import 'package:flutter_application_1/components/todo_tile.dart';
import 'package:flutter_application_1/models/note_database.dart';
import 'package:flutter_application_1/models/todo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  // controller
  final _myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readTasks();
  }

  // read
  void readTasks() {
    context.read<NoteDatabase>().fetchTasks();
  }

  // method to change checkbox
  void checkBoxChange(int id) {
    context.read<NoteDatabase>().updateTask(id);
  }

  // save new task (when we click save)
  void saveTask() {
    if (_myController.text != '') {
      context.read<NoteDatabase>().addTask(_myController.text);
      _myController.clear();
    }
    Navigator.of(context).pop();
  }

  void saveEditTask(int id) {
    context.read<NoteDatabase>().editTask(id, _myController.text);
    Navigator.of(context).pop();
    _myController.clear();
  }

  void editTask(Todo todo) {
    showDialog(
      context: context,
      builder: (context) {
        _myController.text = todo.name;
        return MyDialog(
          myController: _myController,
          saveTask: () => saveEditTask(todo.id),
        );
      },
    );
  }

  // method when we click + button
  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return MyDialog(myController: _myController, saveTask: saveTask);
      },
    );
  }

  // delete a task
  void deleteTask(int id) {
    context.read<NoteDatabase>().deleteTask(id);
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    List<Todo> currentTodos = noteDatabase.currentTodos;
    return Scaffold(
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createTask(),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'To-do list',
              style: GoogleFonts.dmSerifText(
                fontSize: 44,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 50),
              itemCount: currentTodos.length,
              itemBuilder: (context, index) {
                final todo = currentTodos[index];
                return ToDoTile(
                  task: currentTodos[index],
                  onChanged: (value) => checkBoxChange(todo.id),
                  deleteTask: (context) => deleteTask(todo.id),
                  editTask: (context) => editTask(todo),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
