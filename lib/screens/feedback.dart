import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {

  bool someData = false;
  bool use = false;
  bool sighIn = false;
  bool update = false;

  Future<void> socialMedias(String s) async{
    await launch(s);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.94),
      appBar: AppBar(
        elevation: 2,
        title: Text("Help & Feedback"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*1.4,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              top: MediaQuery.of(context).size.height*0.035,
              left: MediaQuery.of(context).size.width*0.12,
              child: Container(
                child: Row(
                  children: [
                    Icon(Icons.live_help_outlined,
                      size: 35,
                      color: Colors.black.withOpacity(0.7),),
                    SizedBox(
                      width: 8,
                    ),
                    Text("FAQ",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600
                    ),),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: MediaQuery.of(context).size.height*0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: someData == false ?
                    MediaQuery.of(context).size.height*0.13 :
                    MediaQuery.of(context).size.height*0.3,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Some Data is missing/\n"
                                      "incorrect",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(0.65),
                                  ),),
                                  IconButton(
                                    iconSize: 24,
                                    icon: Icon( someData == false ?
                                        Icons.keyboard_arrow_down_sharp :
                                        Icons.keyboard_arrow_up_sharp,
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        someData = !someData;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            someData == false ?
                                Text("",style: TextStyle(fontSize: 0),) :
                            Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20),
                              child: Text(
                                "Our app works on both online and offline mode "
                                    "if you add some new data while your device "
                                    "is offline than the data is "
                                    "only accessible to the same device.",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black45
                                ),
                              ),
                            ) ,
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: use == false ?
                    MediaQuery.of(context).size.height*0.12 :
                    MediaQuery.of(context).size.height*0.3,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30,
                          right: 30
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("How to use",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.65),
                                    ),),
                                  IconButton(
                                    iconSize: 24,
                                    icon: Icon( use == false ?
                                    Icons.keyboard_arrow_down_sharp :
                                    Icons.keyboard_arrow_up_sharp,
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        use = !use;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            use == false ?
                            Text("",style: TextStyle(fontSize: 0),) :
                            Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20),
                              child: Text(
                                "Notes is an app which store text data "
                                "First give a Title to your notes in main "
                                    "Screen and by clicking on it you can "
                                    "wrote anything",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black45
                                ),
                              ),
                            ) ,
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: sighIn == false ?
                    MediaQuery.of(context).size.height*0.12 :
                    MediaQuery.of(context).size.height*0.3,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Can't LogIn",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.65),
                                    ),),
                                  IconButton(
                                    iconSize: 24,
                                    icon: Icon( sighIn == false ?
                                    Icons.keyboard_arrow_down_sharp :
                                    Icons.keyboard_arrow_up_sharp,
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        sighIn = !sighIn;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            sighIn == false ?
                            Text("",style: TextStyle(fontSize: 0),) :
                            Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20),
                              child: Text(
                                "Make sure your device is connected "
                                    "to internet and your Email or Password "
                                    "is correct.\n"
                                    "You can Further inform us "
                                    "by tapping on Help & Feedback ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black45
                                ),
                              ),
                            ) ,
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: update == false ?
                    MediaQuery.of(context).size.height*0.12 :
                    MediaQuery.of(context).size.height*0.3,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30,
                          right: 30
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "What comes in next\n"
                                      "Update of Notes",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.65),
                                    ),),
                                  IconButton(
                                    iconSize: 24,
                                    icon: Icon( update == false ?
                                    Icons.keyboard_arrow_down_sharp :
                                    Icons.keyboard_arrow_up_sharp,
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        update = !update;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            update == false ?
                            Text("",style: TextStyle(fontSize: 0),) :
                            Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20),
                              child: Text(
                                "In the next update we will add bucket list "
                                    "and switches, So you can uncheck the things that "
                                    "done.\n"
                                "If you want some thing, Please let us know."
                                    "By tapping on Help & Feedback",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black45
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      socialMedias("mailto:");
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Card(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(child: Text("Help & Feedback",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white
                          ),)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
