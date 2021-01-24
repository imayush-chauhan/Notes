import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note/auth/logIn.dart';
import 'package:note/database/data.dart';
import 'package:note/screens/aboutUs.dart';
import 'package:note/screens/feedback.dart';
import 'package:note/screens/fullNotes.dart';
import 'package:note/screens/whatsNew.dart';
import 'feedback.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final fireStore = Firebase.initializeApp();
  bool isLogIn = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController title = TextEditingController();
  TextEditingController edit = TextEditingController();

  bool onEdit = false;
  int onEditIndex;
  bool slide = false;


  addTitle() async{
       if(FirebaseAuth.instance.currentUser.uid != null){
         fireStore.then((value) async {
           await FirebaseFirestore.instance.
           collection("users").doc(FirebaseAuth.instance.currentUser.uid).update(
               {
                 "titles": Data.titles,
               }
           );
         });
       }
  }

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

  // addUsername() async{
  //    fireStore.then((value) async {
  //      FirebaseFirestore.instance.
  //     collection("users").doc(FirebaseAuth.instance.currentUser.uid)
  //          .get().then((result){
  //            Data.username = result.get("username");
  //      });
  //   });
  // }

  signOut(){
    setState(() {
      Data.username = "";
      Data.email = "";
    });
    _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      Data.getStringListValue();
      Data.get();
    });
    Data.addUsername();
    // ShowAds.showBannerAd();
    // Timer(Duration(seconds: 10), () {
    //   ShowAds.showInterstitialAd();
    //   print(">\n"
    //       ">\n"
    //       ">\n"
    //       ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    // });
  }

  snackBar(String s){
    SnackBar snackbar = SnackBar(duration: Duration(milliseconds: 2200), content: Text(s),behavior: SnackBarBehavior.floating);
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          slide = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.cyan[500],
                Color(0xff151515),
              ],
            )
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 600),
              top: slide == false ? 0 : MediaQuery.of(context).size.height*0.13,
              left: slide == false ? 0 : MediaQuery.of(context).size.width*0.6,
              height: slide == false ? MediaQuery.of(context).size.height :
              MediaQuery.of(context).size.height*0.7,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Scaffold(
                  key: _scaffoldKey,
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    elevation: 0,
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    title: Text( "Notes",
                        style: TextStyle(
                          color:  Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    leading: IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.dehaze),
                      onPressed: (){
                        setState(() {
                          slide = !slide;
                        });
                      },
                    ),
                  ),
                  body: Container(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Data.titles.isEmpty ? Text("") : ListView.builder(
                                shrinkWrap: true,
                                itemCount: Data.titles.length,
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.all(8),
                                itemBuilder: (BuildContext context,int index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap:(){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => FullNotes(
                                                title: Data.titles[index],
                                                index: index,
                                              )));
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context).size.height*0.18,
                                          width: MediaQuery.of(context).size.width*0.74,
                                          child: Hero(
                                            tag: index,
                                            child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                elevation: 5,
                                                color: Colors.white,
                                                child: Center(
                                                  child: onEdit == true && index == onEditIndex ?
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        height: MediaQuery.of(context).size.height*0.18,
                                                        width: MediaQuery.of(context).size.width*0.58,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 20,
                                                              top: 20,bottom: 20,right: 10),
                                                          child: Center(
                                                            child: TextFormField(
                                                              keyboardType: TextInputType.multiline,
                                                              maxLines: null,
                                                              autofocus: true,
                                                              controller: edit,
                                                              validator: (val){
                                                                return val.isEmpty ? "Title is Empty" : null;
                                                              },
                                                              decoration: InputDecoration(
                                                                suffixIcon: IconButton(
                                                                  color: Colors.black,
                                                                  onPressed: (){
                                                                    edit.clear();
                                                                  },
                                                                  icon: Icon(Icons.close),
                                                                ),
                                                                hintText: "Enter new Title",
                                                                hintStyle: TextStyle(
                                                                    color: Colors.black
                                                                ),
                                                                focusedBorder: UnderlineInputBorder(
                                                                    borderSide: BorderSide(color: Colors.black)
                                                                ),
                                                                // enabledBorder: UnderlineInputBorder(
                                                                //   borderSide: BorderSide(color: Colors.black),
                                                                // ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 5),
                                                        child: IconButton(
                                                          icon: Icon(Icons.arrow_downward,size: 25,),
                                                          onPressed: (){
                                                            setState(() {
                                                              Data.titles.insert(index+1, "New Notes");
                                                              Data.notes.insert(index+1, "");
                                                              Data.setStringListValue();
                                                              Data.set();
                                                              addTitle();
                                                              addNotes();
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ) :
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                                                    child: SingleChildScrollView(
                                                      physics: BouncingScrollPhysics(),
                                                      child: Text(
                                                        Data.titles[index],
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 2,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context).size.height*0.09,
                                            width: MediaQuery.of(context).size.width*0.2,
                                            child: Card(
                                                margin: EdgeInsets.only(top: 6,left: 2,right: 2),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                                ),
                                                elevation: 5,
                                                color: Colors.red,
                                                child: Center(
                                                  child: IconButton(
                                                    onPressed: (){
                                                      setState(() {
                                                        if(onEdit == true && index == onEditIndex){
                                                          onEdit = false;
                                                          onEditIndex = null;
                                                        }else{
                                                          showDeleteDialog(
                                                              Data.titles[index].indexOf(" ") == -1 ?
                                                              Data.titles[index] :
                                                              Data.titles[index].substring(0,Data.titles[index].indexOf(" ")),
                                                              index);
                                                        }
                                                      });
                                                    },
                                                    icon: onEdit == true && onEditIndex == index ?
                                                    Icon(Icons.redo,color: Colors.white) :
                                                    Icon(Icons.delete,color: Colors.white),
                                                  ),
                                                )
                                            ),
                                          ),
                                          Container(
                                            height: MediaQuery.of(context).size.height*0.09,
                                            width: MediaQuery.of(context).size.width*0.2,
                                            child: Card(
                                                margin: EdgeInsets.only(bottom: 6,left: 2,right: 2),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                                ),
                                                elevation: 5,
                                                color: Colors.green,
                                                child: Center(
                                                  child: IconButton(
                                                    onPressed: (){
                                                      setState(() {
                                                        if(onEdit == true && onEditIndex == index){
                                                          if(edit.text.isNotEmpty){
                                                            Data.titles[index] = edit.text;
                                                            Data.setStringListValue();
                                                            addTitle();
                                                            edit.clear();
                                                            onEdit = false;
                                                            onEditIndex = null;
                                                          }else{
                                                            snackBar("Title is Empty");
                                                          }
                                                        }else{
                                                          edit.text = Data.titles[index];
                                                          onEdit = true;
                                                          onEditIndex = index;
                                                          // titles.remove(titles[index]);
                                                          // setStringListValue("title",titles);
                                                        }
                                                      });
                                                    },
                                                    icon: onEdit == true && index == onEditIndex ?
                                                    Icon(Icons.add,color: Colors.white,) :
                                                    Icon(Icons.edit,color: Colors.white),
                                                  ),
                                                )
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                            onEdit == true ? Text("") : Container(
                              height: MediaQuery.of(context).size.height*0.18,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 5,
                                  color: Colors.white,
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.7,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: TextFormField(
                                              keyboardType: TextInputType.multiline,
                                              maxLines: null,
                                              controller: title,
                                              validator: (val){
                                                return val.isEmpty ? "Title is Empty" : null;
                                              },
                                              decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                  color: Colors.black,
                                                  onPressed: (){
                                                    title.clear();
                                                  },
                                                  icon: Icon(Icons.close),
                                                ),
                                                hintText: "Enter Title",
                                                hintStyle: TextStyle(
                                                    color: Colors.black
                                                ),
                                                focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.black)
                                                ),
                                                enabledBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15),
                                          child: MaterialButton(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            color: Colors.red,
                                            splashColor: Color(0xFF5B16D0),
                                            minWidth: MediaQuery.of(context).size.width*0.2,
                                            height: 50.0,
                                            onPressed: (){
                                              setState(() {
                                                if(title.text.isEmpty){
                                                  snackBar("Title is empty");
                                                }else{
                                                  Data.titles.add(title.text);
                                                  Data.notes.add("");
                                                  Data.setStringListValue();
                                                  Data.set();
                                                  addTitle();
                                                  addNotes();
                                                  title.clear();
                                                }
                                              });
                                            },
                                            child: Text(
                                              'Add',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 600),
              top: slide == true ? MediaQuery.of(context).size.height*0.1 :
              MediaQuery.of(context).size.height*0.5,
              height: slide == true ? MediaQuery.of(context).size.height*0.8 :
              0,
              left: slide == true ? 0 :
              -MediaQuery.of(context).size.width*0.55,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    slide = true;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.55,
                  child: Card(
                    margin: EdgeInsets.only(
                      left: 4
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.12,
                            width: MediaQuery.of(context).size.width*0.55,
                            child: Card(
                              margin: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(0),
                                ),
                              ),
                              color: Colors.black.withOpacity(0.8),
                              child: Center(
                                child: Text(
                                    Data.username == "" ? "Notes" :
                                    Data.username.indexOf(" ") == -1 ?
                                    Data.username : Data.username.substring(0,Data.username.indexOf(" ")),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height*0.14,
                          left: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    slide = false;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width*0.55,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        IconButton(icon: Icon(Icons.home_outlined,
                                          size: 24,
                                          color: Colors.black.withOpacity(0.8),
                                        ), onPressed: (){
                                          setState(() {
                                            slide = false;
                                          });
                                        }),
                                        Text("Home",
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black.withOpacity(0.8),
                                          ),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Data.username == "" ? GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return LogIn(
                                      isLogIn: false,
                                    );
                                  }));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width*0.55,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.person_add_outlined,
                                            size: 24,
                                            color: Colors.black.withOpacity(0.8),
                                          ),
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context){
                                              return LogIn(
                                                isLogIn: false,
                                              );
                                            }));
                                          }),
                                      Text("Sign Up",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black.withOpacity(0.8),
                                        ),),
                                    ],
                                  ),
                                ),
                              ) : Text("",style: TextStyle(fontSize: 0),),
                              Data.username == "" ? GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return LogIn(
                                      isLogIn: true,
                                    );
                                  }));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width*0.55,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.person_outline,
                                            size: 24,
                                            color: Colors.black.withOpacity(0.8),
                                          ),
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context){
                                              return LogIn(
                                                isLogIn: true,
                                              );
                                            }));
                                          }),
                                      Text("Sign In",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black.withOpacity(0.8),
                                        ),),
                                    ],
                                  ),
                                ),
                              ) : Text("",style: TextStyle(fontSize: 0),),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return Help();
                                  }));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width*0.55,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        IconButton(icon: Icon(Icons.mail_outline,
                                          size: 24,
                                          color: Colors.black.withOpacity(0.8),
                                        ), onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return Help();
                                          }));
                                        }),
                                        Text("Help & Feedback",
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black.withOpacity(0.8),
                                          ),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return About();
                                  }));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width*0.55,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        IconButton(icon: Icon(Icons.help_outline,
                                          size: 24,
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                                return About();
                                              }));
                                            }),
                                        Text("About",
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black.withOpacity(0.8),
                                          ),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Data.username == "" ?
                                  Text("",style: TextStyle(fontSize: 0),) :
                              GestureDetector(
                                onTap: (){
                                 signOut();
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width*0.55,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      IconButton(icon: Icon(Icons.person,
                                        size: 24,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                          onPressed: (){
                                            signOut();
                                          }),
                                      Text("Log out",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black.withOpacity(0.8),
                                        ),),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showDeleteDialog(String yo,int index) {
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Center(child: Text(yo)),
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: Colors.red)
            ),
            actions: [
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Text("cancel",
                      style: TextStyle(
                        fontSize: 21,
                        color: Color(0xff151515),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.12,
                  ),
                  MaterialButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Colors.red,
                    splashColor: Color(0xFF5B16D0),
                    minWidth: 120,
                    height: 50.0,
                    onPressed: (){
                      setState(() {
                        Data.titles.remove(Data.titles[index]);
                        Data.notes.remove(Data.notes[index]);
                        Data.setStringListValue();
                        Data.set();
                        addTitle();
                        addNotes();
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
    );
  }
}
