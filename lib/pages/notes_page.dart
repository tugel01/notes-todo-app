import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/drawer.dart';
import 'package:flutter_application_1/components/note_tile.dart';
import 'package:flutter_application_1/models/note.dart';
import 'package:flutter_application_1/models/note_database.dart';
import 'package:flutter_application_1/pages/note_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();

  // initial state with notes
  @override
  void initState() {
    super.initState();
    Future.microtask(() => readNotes()); // to avoid blocking UI
  }

  // read
  void readNotes() async{
    await context.read<NoteDatabase>().fetchNotes();
  }

  // delete
  void deleteNote(int id) async {
    await context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    // access db
    final noteDatabase = context.watch<NoteDatabase>();
    // get current notes from db in the list
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        // new note button
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotePage()),
          );
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // heading
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText(
                fontSize: 44,
                color:  Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),

          // List of notes
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 50),
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                // get individual note
                final note =  currentNotes[index];
                return NoteTile(
                  note:  note,
                  onDeletePressed: (value) => deleteNote(note.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
