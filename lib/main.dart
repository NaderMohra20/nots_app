import 'package:flutter/material.dart';
import 'package:flutter_application_9/helper/note_provider.dart';
import 'package:flutter_application_9/screens/note_edit_screen.dart';
import 'package:flutter_application_9/screens/note_list_screen.dart';
import 'package:flutter_application_9/screens/note_view_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: NoteProvider(),
      child: MaterialApp(
        title: "Flutter Notes",
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => NoteListScreen(),
          NoteViewScreen.route: (context) => NoteViewScreen(),
          NoteEditScreen.route: (context) => NoteEditScreen(),
        },
      ),
    );
  }
}
