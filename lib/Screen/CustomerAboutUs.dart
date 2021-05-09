import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pictiknew/Common/AppService.dart';
import 'package:pictiknew/Common/Constants.dart' as cnst;
import 'package:flutter/material.dart';
import 'package:pictiknew/Common/Constants.dart';
import 'package:pictiknew/Common/Services.dart';
import 'package:pictiknew/Components/NoDataComponent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerAboutUs extends StatefulWidget {
  @override
  _CustomerAboutUsState createState() => _CustomerAboutUsState();
}

class _CustomerAboutUsState extends State<CustomerAboutUs> {
  List giveData = [];
  bool isLoading = true;
  var aboutUs, _data;

  @override
  void initState() {
    //  _getGive();
    accessToken();
  }

  accessToken() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();

        AppServices.AccessToken(prefs.getString(Session.opicxoUserId),
                prefs.getString(Session.opicxoUserPass))
            .then((data) async {
          print("done1");
          setState(() {
            isLoading = false;
          });
          //  if (data.value == "true") {
          print("Message : " + data.access_token);
          getOpicxoAbout(data.access_token);
          // Navigator.of(context).pushReplacementNamed('/LoginForm');
          // } else {
          //   showMsg("Invalid login Detail");
          //   print("Invalid Cridintional");
          // }
        }, onError: (e) {
          setState(() {
            isLoading = false;
          });
          print("Something Went Wrong");
          print("error is " + e.toString());
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
      print("No Internet Connection");
    }
  }

  getOpicxoAbout(String token) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        AppServices.AboutUs(token).then((data) async {
          setState(() {
            isLoading = false;
          });
          print("Message : " + data.message);
          setState(() {
            _data = data.studio;
            aboutUs = data.studio[0]['description'];
          });
          print("prodile data : ..." + _data.toString());
        }, onError: (e) {
          setState(() {
            isLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  // _getGive() async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       Future res = Services.GetAboutUs();
  //       setState(() {
  //         isLoading = true;
  //       });
  //       res.then((data) async {
  //         if (data != null && data.length > 0) {
  //           setState(() {
  //             giveData = data;
  //             isLoading = false;
  //           });
  //         } else {
  //           setState(() {
  //             isLoading = false;
  //           });
  //         }
  //       }, onError: (e) {
  //         setState(() {
  //           isLoading = false;
  //         });
  //         print("Error : on Myask Call $e");
  //         showMsg("Try Again.");
  //       });
  //     } else {
  //       showMsg("No Internet Connection.");
  //     }
  //   } on SocketException catch (_) {
  //     showMsg("No Internet Connection.");
  //   }
  // }
  //
  // showMsg(String msg) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return AlertDialog(
  //         title: new Text("Error"),
  //         content: new Text(msg),
  //         actions: <Widget>[
  //           // usually buttons at the bottom of the dialog
  //           new FlatButton(
  //             child: new Text(
  //               "Close",
  //               style: TextStyle(color: cnst.appPrimaryMaterialColorPink),
  //             ),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  DateTime currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  cnst.appPrimaryMaterialColorYellow,
                  cnst.appPrimaryMaterialColorPink
                ],
              ),
            ),
          ),
          title: Text("About Us"),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            /*    Container(
              child: Opacity(
                opacity: 0.2,
                child: Image.asset(
                  "images/pencil.png",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                ),
              ),
            ),*/
            isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 10, right: 10, bottom: 10),
                      child: Text(
                        "${aboutUs}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ),
                  )
            // : _data.length > 0
            //     ? Container(
            //         padding: EdgeInsets.all(10),
            //         // color: Colors.grey[200],
            //         child: ListView.builder(
            //           itemCount: _data.length,
            //           itemBuilder: (BuildContext context, int index) {
            //             return ListTile(
            //               // title: Padding(
            //               //   padding: const EdgeInsets.only(top: 10),
            //               //   child: Center(
            //               //     child: Text(
            //               //       giveData[index]["Title"],
            //               //       textAlign: TextAlign.justify,
            //               //       style: TextStyle(
            //               //         fontSize: 21,
            //               //         fontWeight: FontWeight.bold,
            //               //       ),
            //               //     ),
            //               //   ),
            //               // ),
            //               subtitle: Padding(
            //                 padding: const EdgeInsets.only(top: 15),
            //                 child: Text(
            //                   aboutUs,
            //                   textAlign: TextAlign.justify,
            //                   style: TextStyle(
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.w400,
            //                       color: Colors.black54),
            //                 ),
            //               ),
            //             );
            //           },
            //         ),
            //       )
            //     : NoDataComponent()
          ],
        ));
  }
}
