import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/note.dart';
import 'package:flutter_application_1/models/todo.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  // Initialization of DB
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema, TodoSchema], directory: dir.path);
  }

  final List<Todo> currentTodos = [];
  final List<Note> currentNotes = [];

  // Create a todo task
  Future<void> addTask(String textFromUser) async {
    final newTask = Todo()..name = textFromUser;
    newTask.taskDone = false;

    // save to db
    await isar.writeTxn(() => isar.todos.put(newTask));
    fetchTasks();
  }

  // Read todo tasks
  Future<void> fetchTasks() async {
    List<Todo> fetchedTasks = await isar.todos.where().findAll();
    currentTodos.clear();
    currentTodos.addAll(fetchedTasks);
    notifyListeners();
  }

  // Update a todo task
  Future<void> updateTask(int id) async {
    final oldTask = await isar.todos.get(id);
    if (oldTask != null) {
      oldTask.taskDone = !oldTask.taskDone;
      await isar.writeTxn(() => isar.todos.put(oldTask));
      await fetchTasks();
    }
  }

  Future<void> editTask(int id, String newText) async {
    final oldTask = await isar.todos.get(id);
    if (newText == '') {
      deleteTask(id);
    } else if (oldTask != null) {
      oldTask.name = newText;
      await isar.writeTxn(() => isar.todos.put(oldTask));
      await fetchTasks();
    }
  }

  // Delete a todo task
  Future<void> deleteTask(int id) async {
    await isar.writeTxn(() => isar.todos.delete(id));
    await fetchTasks();
  }

  // Create a note
  Future<void> addNote(String textFromUser) async {
    final newNote = Note()..text = textFromUser;

    // save to db
    await isar.writeTxn(() => isar.notes.put(newNote));
    fetchNotes();
  }

  // Read notes
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  // Update a note
  Future<void> updateNote(int id, String newText) async {
    final oldNote = await isar.notes.get(id);
    if (oldNote != null) {
      if (newText == '') {
        deleteNote(id);
      } else {
        oldNote.text = newText;
        await isar.writeTxn(() => isar.notes.put(oldNote));
        await fetchNotes();
      }
    } else {
      if (newText != '') {
        addNote(newText);
      }
    }
  }

  // Delete a note
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}
