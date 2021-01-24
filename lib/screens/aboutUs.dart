import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  Future<void> socialMedias(String s) async{
    await launch(s,forceSafariVC: false,
      forceWebView: false,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.94),
      appBar: AppBar(
        title: Text("About"),
        centerTitle: true,
        elevation: 3,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*1.19,
            ),
            Positioned(
              top: 10,
              child: Container(
                height: MediaQuery.of(context).size.height*0.28,
                width: MediaQuery.of(context).size.width*0.97,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Version Details",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black.withOpacity(0.7),
                        ),),
                      Text("v1.0.0",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black.withOpacity(0.7),
                      ),),
                      GestureDetector(
                        onTap: (){
                          showAboutDialog(
                              context: context,
                            applicationVersion: "1.0.0",
                          );
                        },
                        child: Container(
                          height: 55,
                          width: 180,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.black26),
                            ),
                            child: Center(child: Text("LICENSES",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black45
                            ),)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height*0.3,
              child: Container(
                height: MediaQuery.of(context).size.height*0.48,
                width: MediaQuery.of(context).size.width*0.97,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Social Media",
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.black.withOpacity(0.7),
                        ),),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15
                        ),
                        child: Text("If you enjoy using Notes or want to know more about it, consider"
                            "following us on different social medias. You will get all the latest news"
                            "regarding to updates or ask any query we will always there to help you.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black.withOpacity(0.5),
                          ),),
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              socialMedias("");
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width*0.8,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(color: Colors.red.shade300),
                                ),
                                child: Center(child: Text("Follow us on Instagram",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.red.shade800
                                  ),)),
                              ),
                            ),
                          ),
                          SizedBox(height: 6,),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(color: Colors.blue.shade400),
                              ),
                              child: Center(child: Text("Follow us on Twitter",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue
                                ),)),
                            ),
                          ),
                          SizedBox(height: 6,),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(color: Colors.blue.shade800),
                              ),
                              child: Center(child: Text("Follow us on Facebook",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue.shade900
                                ),)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height*0.79,
              child: Container(
                height: MediaQuery.of(context).size.height*0.39,
                width: MediaQuery.of(context).size.width*0.97,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Legal",
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.black.withOpacity(0.7),
                        ),),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                        ),
                        child: Text(
                          "By using Notes, you conform that you have read the"
                              "Privacy Policy and have agreed to the Terms of"
                              "Services. Read again by tapping the button below",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black.withOpacity(0.5),
                          ),),
                      ),
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.black26)
                              ),
                              child: Center(child: Text("PRIVACY POLICY",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black45,
                                ),)),
                            ),
                          ),
                          SizedBox(height: 6,),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.black26),
                              ),
                              child: Center(child: Text("TERMS OF SERVICES",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black45
                                ),)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
