import 'package:flutter/material.dart';
import 'package:flutter_application_9/helper/note_provider.dart';
import 'package:flutter_application_9/models/note.dart';
import 'package:provider/provider.dart';

class DeletePopUp extends StatelessWidget {
  Note selectedNote;
  DeletePopUp(
    this.selectedNote,
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text('Delete?'),
      content: Text('Do you want to delete the note?'),
      actions: [
        ElevatedButton(
          child: Text('Yes'),
          onPressed: () {
            Provider.of<NoteProvider>(context, listen: false)
                .deleteNote(selectedNote.id);
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
        ElevatedButton(
          child: Text('No'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
