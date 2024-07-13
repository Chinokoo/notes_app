import 'package:flutter/material.dart';
import 'package:notes_app/components/notes_tile.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({
    super.key,
  });

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();
  void isEmpty() {
    const Center(
      child: Text("You don't have any notes yet !"),
    );
  }

  //displaying the notes page at the start of the application
  @override
  void initState() {
    super.initState();

    readNotes();
  }

  //create a note
  void createNote() {
    //show dialog to create a note
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter your note here',
          ),
        ),
        actions: [
          MaterialButton(
              onPressed: () {
                context.read<NoteDatabase>().createNote(textController.text);
                textController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('OK')),
          MaterialButton(
              onPressed: () {
                textController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'))
        ],
      ),
    );
  }

  //read and display all notes
  void readNotes() {
    //read all notes from the database
    context.read<NoteDatabase>().fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'Notes',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNote,
          backgroundColor: Colors.white,
          child: const Icon(Icons.add),
        ),
        body: const NotesTile());
  }
}
