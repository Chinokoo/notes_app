import 'package:flutter/material.dart';
import 'package:notes_app/components/note_settings.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:popover/popover.dart';
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
              backgroundColor: Theme.of(context).colorScheme.secondary,
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
              backgroundColor: Theme.of(context).colorScheme.secondary,
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
    //getting info from the provider database.
    final notesDatabase = context.watch<NoteDatabase>();

    //*getting the current notes from the provider database.
    List<Note> currentNotes = notesDatabase.currentNotes;

    //creating a list view of the notes.
    return ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (context, index) {
          final note = currentNotes[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              tileColor: Theme.of(context).colorScheme.secondary,
              title: Text(
                note.text,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              trailing: Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () => showPopover(
                      context: context,
                      direction: PopoverDirection.bottom,
                      width: 80,
                      height: 80,
                      bodyBuilder: (context) => NoteSettings(
                        onTapEdit: () => updateNote(note),
                        onTapDelete: () => deleteNote(note),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
