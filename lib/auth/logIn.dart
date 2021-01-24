import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/database/data.dart';
import 'package:note/screens/notes.dart';

class LogIn extends StatefulWidget {

  final bool isLogIn;
  LogIn({this.isLogIn});

  @override
  _LogInState createState() => _LogInState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final fireStore = Firebase.initializeApp();

class _LogInState extends State<LogIn> {

  final nameKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();
  final conformKey = GlobalKey<FormState>();
  final signInEmailKey = GlobalKey<FormState>();
  final signInPasswordKey = GlobalKey<FormState>();
  final signUpKey = GlobalKey<FormState>();
  final signInKey = GlobalKey<FormState>();

  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conformPassword = TextEditingController();
  TextEditingController signInEmail = TextEditingController();
  TextEditingController signInPassword = TextEditingController();

  bool isSignIn = true;
  bool isLoading = false;
  bool isSuccessfulSignUp = false;
  bool isSuccessfulSignIn = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isSignIn = widget.isLogIn;
    });
  }
  signUpWithEmail(String username,String email,String password) async{
    if(isLoading == false) {
      setState(() {
        isLoading = true;
      });

      User user = (await _auth.createUserWithEmailAndPassword(
          email: email, password: password).catchError((error){
            if(error.toString() == "[firebase_auth/email-already-in-use] The email address is already in use by another account."){
              showDeleteDialog("Email already in use");
              setState(() {
                isLoading = false;
              });
            }
      })).user;


      if(user != null && isLoading == true){
        setState(() {
          fireStore.then((value) async {
            await FirebaseFirestore.instance.
            collection("users").doc(user.uid).set(
                {
                  "Email": user.email,
                  "password": password,
                  "UserEmailId": user.uid,
                  "UserUid": _auth.currentUser.uid,
                  "Data": DateTime.now(),
                  "titles": Data.titles,
                  "notes": Data.notes,
                  "username": username,
                }
            );
          });
        });
      }

    }

    setState(() {
      Data.addUsername();
      isLoading = false;
    });
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context){
          return Notes();
        }));
  }
  
  
  signInWithEmail(String email,String password) async{

      if(isLoading == false) {
        setState(() {
          isLoading = true;
        });

        User user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password).catchError((error){
              if(error.toString() == "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted."){
                showDeleteDialog("User not found");
              }
              setState(() {
                isLoading = false;
              });
        })
        ).user;

        if (user != null && isLoading == true) {

            setState(() {
              fireStore.then((value) async {
                await FirebaseFirestore.instance.
                collection("users").doc(user.uid).get().then((querySnapshot){
                  Data.username = querySnapshot.get("username");
                  Data.titles = querySnapshot.get("titles").cast<String>();
                  Data.notes = querySnapshot.get("notes").cast<String>();
                  Data.setStringListValue();
                  Data.set();
                });
              });
            });

            Data.addUsername();

          setState(() {
            isSuccessfulSignIn = false;
            isLoading = false;
          });
        }

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return Notes();
            }));
      }
  }

  Container signUp(){
    return Container(
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Sign Up"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          color: Colors.transparent,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(horizontal: 24,vertical: 10),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: signUpKey,
                  child: Column(
                    children: [
                      TextFormField(
                        key: nameKey,
                        validator: (val){
                          return val.isEmpty ||  val.length < 4 ? "More than 4 characters" : null;
                        },
                        controller: userName,
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(
                              color: Colors.white70
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      TextFormField(
                        key: emailKey,
                        validator: (val){
                          return RegExp(
                              "@").hasMatch(val) ? null : "Email is not valid";
                        },
                        controller: email,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                              color: Colors.white70
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      TextFormField(
                        key: passwordKey,
                        validator: (val){
                          return val.length > 6 ? null : "Greater than 6 characters";
                        },
                        obscureText: true,
                        controller: password,
                        decoration: InputDecoration(
                          hintText: "Create Password",
                          hintStyle: TextStyle(
                              color: Colors.white70
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      TextFormField(
                        key: conformKey,
                        validator: (val){
                          return val != password.text ? "Conform Password is wrong" : null;
                        },
                        obscureText: true,
                        controller: conformPassword,
                        decoration: InputDecoration(
                          hintText: "Conform Password",
                          hintStyle: TextStyle(
                              color: Colors.white70
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                GestureDetector(
                    onTap: (){
                      if (signUpKey.currentState.validate()) {
                        signUpWithEmail(userName.text,email.text,password.text);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              colors: [
                                const Color(0xff007EF4),
                                const Color(0xff2A75BC),
                              ]
                          )
                      ),
                      child: Text("Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),),
                    ),),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have account? ",style: TextStyle(fontSize: 16,color: Colors.white),),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isSignIn = true;
                        });
                      },
                      child: Text("SignIn",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 17,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 18,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true ? Container(
      alignment: Alignment.topCenter,
      color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width*0.8,
              child: Card(
                color: Colors.greenAccent,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: Text("Welcome 😊",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),)),
              ),
            ),

            CircularProgressIndicator(),
          ],
        )) :
    isSignIn == true ? signIn() : signUp();
  }

  Container signIn(){
    return Container(
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text("Sign In"),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.transparent,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(horizontal: 24,vertical: 30),
          child: Form(
            key: signInKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: signInEmailKey,
                  validator: (val){
                    return RegExp(
                        "@").hasMatch(val) ? null : "Email is not valid";
                  },
                  controller: signInEmail,
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(
                        color: Colors.white54
                    ),

                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                  ),
                ),
                TextFormField(
                  key: signInPasswordKey,
                  validator: (val){
                    return val.length > 6 ? null : "Grater than 6 characters";
                  },
                  controller: signInPassword,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(
                        color: Colors.white54
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 35,),
                Hero(
                  tag: "SignIn",
                  child: GestureDetector(
                    onTap: (){
                      if (signInKey.currentState.validate()) {
                        print("pass the SignIn key\n"
                            ">>>>>>>>>>>>>>>>>>>>>>>\n"
                            ">>>>>>>>>>>>>>>>>>>>>>>\n"
                            ">>>>>>>>>>>>>>>>>>>>>>>\n"
                            ">>>>>>>>>>>>>>>>>>>>>>>\n");
                        signInWithEmail(signInEmail.text,signInPassword.text);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              colors: [
                                const Color(0xff007EF4),
                                const Color(0xff2A75BC),
                              ]
                          )
                      ),
                      child: Text("Sign In",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),),
                    ),
                  ),
                ),

                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account? ",style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                    )),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isSignIn = false;
                        });
                      },
                      child: Text("Register now",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 17,
                            color: Colors.white,
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showDeleteDialog(String yo) {
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
          );
        }
    );
  }
}
