import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/components/drawer.dart';
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
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter your note here',
              hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary)),
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
        backgroundColor: Theme.of(context).colorScheme.surface,
        //app bar or the header where the drawer button is placed
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),

        //floating action button to create a note
        floatingActionButton: FloatingActionButton(
          onPressed: createNote,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.note_add_sharp,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        drawer: const MyDrawer(),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text("Notes",
                style: GoogleFonts.dmSerifText(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
          ),
          const Expanded(child: NotesTile())
        ]));
  }
}
