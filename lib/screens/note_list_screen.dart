import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/helper/note_provider.dart';
import 'package:flutter_application_9/screens/note_edit_screen.dart';

import 'package:flutter_application_9/widget/list_item.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NoteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<NoteProvider>(context, listen: false).getNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body:const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Consumer<NoteProvider>(
                child: noNotesUI(context),
                builder: (context, noteprovider, child) =>
                    noteprovider.items.length <= 0
                        ? child!
                        : ListView.builder(
                            itemCount: noteprovider.items.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return header();
                              } else {
                                final i = index - 1;
                                final item = noteprovider.items[i];
                                return ListItem(
                                  id: item.id,
                                  title: item.title,
                                  content: item.content,
                                  imagePath: item.imagePath,
                                  date: item.date,
                                );
                              }
                            },
                          ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  goToNoteEditScreen(context);
                },
                child: Icon(Icons.add),
              ),
            );
          }
          return Container(
            width: 0.0,
            height: 0.0,
          );
        }
      },
    );
  }

  Widget header() {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color:  Color(0xFFFD5872),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(75.0),
          ),
        ),
        height: 120,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:const [
            Text(
              'NOTES',
              style: TextStyle(
              color:Colors. white,
              fontSize: 45.0,
                fontWeight: FontWeight.bold,
             ),
            ),
          ],
        ),
      ),
    );
  }

  Widget noNotesUI(BuildContext context) {
    return ListView(
      children: [
        header(),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              // child: Image.asset(
              //   'crying_emoji.png',
              //   fit: BoxFit.cover,
              //   width: 200,
              //   height: 200,
              // ),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(
    fontSize: 22.0,
    color:Color(0xFF424242),
    fontWeight: FontWeight.w600,
  ),
                children: [
                  TextSpan(text: ' There is no note available\nTap on "'),
                  TextSpan(
                      text: '+',
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.blueAccent,
                           fontWeight: FontWeight.bold,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          goToNoteEditScreen(context);
                        }),
                  TextSpan(text: '" to add new note'),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  void goToNoteEditScreen(BuildContext context) {
    Navigator.of(context).pushNamed(NoteEditScreen.route);
  }

  Widget? contanaer() {
    return Container();
  }
}
