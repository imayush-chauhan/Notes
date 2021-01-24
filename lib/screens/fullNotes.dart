import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note/ads/ads.dart';
import 'package:note/database/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FullNotes extends StatefulWidget {
  final String title;
  final int index;
  FullNotes({this.index,this.title,});

  @override
  _FullNotesState createState() => _FullNotesState();
}

class _FullNotesState extends State<FullNotes> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final String userUid = FirebaseAuth.instance.currentUser.uid;
  final fireStore = Firebase.initializeApp();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController full = TextEditingController();
  bool text = false;

  // set() async {
  //   SharedPreferences myPrefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     myPrefs.setStringList("full", Data.notes);
  //   });
  // }
  //
  // get() async {
  //   SharedPreferences myPrefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     if(myPrefs.getStringList("full").isNotEmpty || myPrefs.getStringList("full") != null) {
  //       Data.notes = myPrefs.getStringList("full");
  //     }
  //   });
  // }

  addNotes() async{
    if(FirebaseAuth.instance.currentUser.uid != null){
      fireStore.then((value) async {
        await FirebaseFirestore.instance.
        collection("users").doc(FirebaseAuth.instance.currentUser.uid).update(
            {
              "notes": Data.notes,
            }
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Data.get();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.cyan[500],
                Color(0xff151515),
              ]
          )
      ),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Hero(
              tag: widget.index,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
              ),
                elevation: 5,
                color: Colors.white,
                child: Container(
                  height: MediaQuery.of(context).size.height*0.84,
                  width: MediaQuery.of(context).size.width*0.9,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 18,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width*0.8,
                              child: Text(
                                widget.title.indexOf(" ") == -1 ?
                                widget.title : widget.title.substring(0,widget.title.indexOf(" ")),
                                style: TextStyle(
                                  fontSize: 35,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width*0.9,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30,left: 25,right: 25),
                                child: text == true || Data.notes[widget.index] == "" ?
                                TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  controller: full,
                                  autofocus: true,
                                  validator: (val){
                                    return val.isEmpty ? "Note is Empty" : null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Enter new Notes",
                                    hintStyle: TextStyle(
                                        color: Colors.black
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black)
                                    ),
                                  ),
                                ) :
                                Container(
                                  width: MediaQuery.of(context).size.width*0.9,
                                  height: MediaQuery.of(context).size.height*0.8,
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Center(
                                      child: Text(Data.notes[widget.index],
                                          style: TextStyle(
                                            fontSize: 18,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -6,
                        right: -6,
                        child: Container(
                          alignment: Alignment.topRight,
                          width: MediaQuery.of(context).size.width*0.9,
                          child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 40,
                              child: text == true || Data.notes[widget.index] == "" ?
                              IconButton(
                                color: Colors.white,
                                iconSize: 24,
                                icon: Icon(Icons.add),
                                onPressed: (){
                                  setState(() {
                                    Data.notes[widget.index] = full.text;
                                    Data.set();
                                    addNotes();
                                    text = false;
                                    full.clear();
                                  });
                                },
                              ) :
                              IconButton(
                                color: Colors.white,
                                iconSize: 24,
                                icon: Icon(Icons.edit),
                                onPressed: (){
                                  setState(() {
                                    text = true;
                                    full.text = Data.notes[widget.index];
                                    ShowAds.showInterstitialAd();
                                  });
                                },
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
