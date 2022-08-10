import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_9/helper/note_provider.dart';
import 'package:flutter_application_9/models/note.dart';
import 'package:flutter_application_9/screens/note_edit_screen.dart';

import 'package:flutter_application_9/widget/delete_popup.dart';
import 'package:provider/provider.dart';

class NoteViewScreen extends StatefulWidget {
  static const route = '/note-view';
  @override
  _NoteViewScreenState createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State {
  Note? selectedNote;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = ModalRoute.of(context)!.settings.arguments;
    final provider = Provider.of<NoteProvider>(context);
    if (provider.getNote(id) != null) {
      selectedNote = provider.getNote(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors. white,
      appBar: AppBar(
        elevation: 0.7,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ),
            onPressed: () => _showDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                selectedNote!.title,
                style:const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 28.0,
                ),
              ),
            ),
            Row(
              children: [
               const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.access_time,
                    size: 18,
                  ),
                ),
                Text('${selectedNote?.date}')
              ],
            ),
            if (selectedNote!.imagePath != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.file(File(selectedNote!.imagePath)),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                selectedNote!.content,
                style: TextStyle(
                  letterSpacing: 1.0,
                  fontSize: 20.0,
                   height: 1.5,
                    fontWeight: FontWeight.w400)
                ),
              ),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NoteEditScreen.route,
              arguments: selectedNote!.id);
        },
        child: Icon(Icons.edit),
      ),
    );
  }

  _showDialog() {
    showDialog(
        context: this.context,
        builder: (context) {
          return DeletePopUp(selectedNote!);
        });
  }
}
