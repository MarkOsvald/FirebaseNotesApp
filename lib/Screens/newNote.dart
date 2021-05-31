import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class NewNote extends StatelessWidget {
  TextEditingController headingController = TextEditingController();
  TextEditingController textController = TextEditingController();

  CollectionReference collectionRefrence =
      FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('New note')),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          ElevatedButton(
              onPressed: () {
                collectionRefrence.add({
                  'heading': headingController.text,
                  'text': textController.text
                }).whenComplete(() => Navigator.pop(context));
              },
              style: ElevatedButton.styleFrom(primary: Colors.deepOrangeAccent),
              child: Text('Done'))
        ],
      ),
      backgroundColor: Colors.grey,
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: headingController,
                  maxLength: 30,
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
