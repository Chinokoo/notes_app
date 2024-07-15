import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  final Function()? onTapEdit;
  final Function()? onTapDelete;
  const NoteSettings(
      {super.key, required this.onTapEdit, required this.onTapDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                onTapEdit!();
              },
              child: const Text("Edit"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              onTapDelete!();
            },
            child: const Text("Delete"),
          )
        ],
      ),
    );
  }
}
