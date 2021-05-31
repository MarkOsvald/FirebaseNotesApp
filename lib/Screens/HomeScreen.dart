import 'package:final_project/Screens/newNote.dart';
import 'package:final_project/Screens/selectNote.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => QuickNotes();
}

class QuickNotes extends State<HomeScreen> {
  var random = new Random();
  static Color themeColour = Colors.black;
  List<Color> colorList = [
    Colors.deepOrange,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.pink,
    Colors.blue,
    Colors.black,
    Colors.brown,
    Colors.deepPurple,
    Colors.tealAccent
  ];

  void changeColor(){
    setState(() {
      themeColour = colorList[random.nextInt(10)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColour,
        title: Center(child: Text('Quick notes')),
        actions: [
          ElevatedButton(
              onPressed: changeColor,
              style: ElevatedButton.styleFrom(primary: themeColour),
              child: Icon(Icons.color_lens_outlined))
        ],
      ),
      backgroundColor: Colors.grey,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        backgroundColor: themeColour,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => NewNote()));
        },
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('notes').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
                itemBuilder: (_, index) {
                  var field = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SelectNote(
                                    docToEdit: snapshot.data.docs[index],
                                  )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              field["heading"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }

}
