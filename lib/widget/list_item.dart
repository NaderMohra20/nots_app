import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_9/screens/note_view_screen.dart';


class ListItem extends StatelessWidget {
  final int? id;
  final String? title;
  final String? content;
  final String? imagePath;
  final String? date;
  ListItem({this.id, this.title, this.content, this.imagePath, this.date});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 135.0,
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, NoteViewScreen.route, arguments: id);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow:const[
               BoxShadow(
               color: Colors.grey,
                blurRadius: 30,
                offset: Offset(0, 10),
               )
              ],
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color:Colors. grey, width: 1.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style:  TextStyle(
                        fontSize: 18.0,
                        color:Colors. black,
                          fontWeight: FontWeight.bold,
                          ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        date!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.0,
                           color: Color(0xFF6D6D6D),
                            ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Expanded(
                        child: Text(
                          content!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
              ),
              if (imagePath != null)
                Row(
                  children: [
                    const SizedBox(
                      width: 12.0,
                    ),
                    Container(
                      width: 80.0,
                      height: 95.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                          image: FileImage(
                            File(imagePath!),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
