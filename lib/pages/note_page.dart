import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/note.dart';
import 'package:flutter_application_1/models/note_database.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  final Note? oldNote;
  const NotePage({super.key, this.oldNote});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.oldNote?.text ?? '');
  }

  // create a new Note or update in db
  void saveNote() {
    context.read<NoteDatabase>().updateNote(
      widget.oldNote?.id ?? -1,
      textController.text,
    );
    textController.clear();

    // close the page
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: BackButton(onPressed: saveNote),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: TextField(
        maxLines: 999,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(25),
          border: InputBorder.none,
        ),
        controller: textController,
      ),
    );
  }
}
