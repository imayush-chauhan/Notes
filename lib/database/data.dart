import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note/auth/logIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Data{

  static List<String> titles = [];
  static List<String> notes = [];
  static String username = "";
  static String email = "";

  static setStringListValue() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setStringList("title", titles).then((value){
      getStringListValue();
    });

  }

  static getStringListValue() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    if(myPrefs.getStringList("title").isNotEmpty || myPrefs.getStringList("title") != null) {
      titles = myPrefs.getStringList("title");
    }
    return titles;
  }

  static set() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
      myPrefs.setStringList("full", notes).then((value) {
        get();
      });
  }

  static get() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
      if(myPrefs.getStringList("full").isNotEmpty || myPrefs.getStringList("full") != null) {
        notes = myPrefs.getStringList("full");
      }
  }

  static addUsername() async{
    fireStore.then((value) async {
      FirebaseFirestore.instance.
      collection("users").doc(FirebaseAuth.instance.currentUser.uid)
          .get().then((result){
        username = result.get("username");
        email = result.get("Email");
      });
    });
  }


}