import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_project/Screens/HomeScreen.dart';

// ignore: must_be_immutable
class SelectNote extends StatefulWidget {
  DocumentSnapshot docToEdit;

  SelectNote({this.docToEdit});

  @override
  _SelectNoteState createState() => _SelectNoteState();
}

class _SelectNoteState extends State<SelectNote> {
  TextEditingController headingController = TextEditingController();
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    headingController =
        TextEditingController(text: widget.docToEdit.get('heading'));
    textController = TextEditingController(text: widget.docToEdit.get('text'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Edit note')),
        backgroundColor: QuickNotes.themeColour,
        actions: [
          ElevatedButton(
              onPressed: () {
                widget.docToEdit.reference.update({
                  'heading': headingController.text,
                  'text': textController.text
                }).whenComplete(() => Navigator.pop(context));
              },
              style: ElevatedButton.styleFrom(primary: QuickNotes.themeColour),
              child: Icon(Icons.check))
        ],
      ),
      backgroundColor: Colors.grey,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        backgroundColor: QuickNotes.themeColour,
        onPressed: () {
          widget.docToEdit.reference
              .delete()
              .whenComplete(() => Navigator.pop(context));
        },
      ),
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  maxLength: 30,
                  controller: headingController,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(hintText: 'Heading'),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: textController,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(hintText: 'Text...'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
