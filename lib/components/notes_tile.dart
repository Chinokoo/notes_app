import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesTile extends StatefulWidget {
  const NotesTile({super.key});

  @override
  State<NotesTile> createState() => _NotesTileState();
}

class _NotesTileState extends State<NotesTile> {
  //update a note
  void updateNote(Note note) {
    //pre-fill the current note text
    TextEditingController textController =
        TextEditingController(text: note.text);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.zero),
              title: const Text('Update Note'),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    //updating the note in the database
                    context
                        .read<NoteDatabase>()
                        .updateNote(note.id, textController.text);
                    //clearing the text field
                    textController.clear();
                    // closing the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text("Update"),
                ),
                MaterialButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Cancel"))
              ],
            ));
  }

  //delete a note
  void deleteNote(Note note) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.zero),
              title: const Text('Delete Note'),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context.read<NoteDatabase>().deleteNote(note.id);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Yes"),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final notesDatabase = context.watch<NoteDatabase>();
    List<Note> currentNotes = notesDatabase.currentNotes;
    return ListView.builder(
      itemCount: currentNotes.length,
      itemBuilder: (context, index) {
        final note = currentNotes[index];

        return ListTile(
          title: Text(note.text),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    updateNote(note);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  )),
              IconButton(
                  onPressed: () {
                    deleteNote(note);
                  },
                  icon: const Icon(Icons.delete, color: Colors.red))
            ],
          ),
        );
      },
    );
  }
}
