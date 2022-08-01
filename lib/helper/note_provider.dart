import 'package:flutter/cupertino.dart';
import 'package:flutter_application_9/helper/database_helper.dart';
import 'package:flutter_application_9/models/note.dart';
import 'package:flutter_application_9/utils/constants.dart';

class NoteProvider with ChangeNotifier {
  List _items = [];
  List get items {
    return [..._items];
  }

  Note getNote(id) {
    return _items.firstWhere((note) => note.id == id);
  }

  Future deleteNote(int id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    return DatabaseHelper.delete(id);
  }

  Future addOrUpdateNote(int id, String title, String content, String imagePath,
      EditMode editMode) async {
    final note = Note(id, title, content, imagePath);
    if (EditMode.ADD == editMode) {
      _items.insert(0, note);
    } else {
      _items[_items.indexWhere((note) => note.id == id)] = note;
    }
    notifyListeners();
    DatabaseHelper.insert(
      {
        'id': note.id,
        'title': note.title,
        'content': note.content,
        'imagePath': note.imagePath,
      },
    );
  }

  Future getNotes() async {
    final notesList = await DatabaseHelper.getNotesFromDB();
    _items = notesList
        .map(
          (item) => Note(
              item['id'], item['title'], item['content'], item['imagePath']),
        )
        .toList();
    notifyListeners();
  }
}
