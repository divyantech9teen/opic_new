import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pictiknew/Common/AppService.dart';
import 'package:pictiknew/Common/Constants.dart';
import 'package:pictiknew/Common/Services.dart';
import 'package:pictiknew/Components/LoadinComponent.dart';
import 'package:pictiknew/Components/NoDataComponent.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:pictiknew/Common/Constants.dart' as cnst;
import 'package:shared_preferences/shared_preferences.dart';

import 'AlbumAllImages.dart';
import 'PendingList.dart';
import 'SelectedList.dart';

class SelectedAlbum extends StatefulWidget {
  String albumId, albumName, totalImg;

  SelectedAlbum({this.albumId, this.albumName, this.totalImg});

  @override
  _SelectedAlbumState createState() => _SelectedAlbumState();
}

class _SelectedAlbumState extends State<SelectedAlbum> {
  List<MenuClassOne> _allServices = MenuClassOne.allServiceslist("0", "0", "0");
  List albumData = new List();
  ProgressDialog pr;
  String allCount = "", selectedCount = "", pendingCount = "";
  bool isLoading = true;
  bool isULoading = false;

  void initState() {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(
        message: "Please Wait",
        borderRadius: 10.0,
        progressWidget: Container(
          padding: EdgeInsets.all(15),
          child: CircularProgressIndicator(),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w600));
    //pr.setMessage('Please Wait');
    // TODO: implement initState
    super.initState();
    getAlbumData();
  }

  showMsg(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Close",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  getAlbumData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        Future res = Services.GetAlbumData(widget.albumId);
        res.then((data) async {
          if (data != null && data.length > 0) {
            setState(() {
              isLoading = false;
            });
            setState(() {
              albumData = data;
              //final String allCount="",selectedCount="",pendingCount="";
              selectedCount = data[0]["SelectedPhotoCount"].toString();

              allCount = data[0]["NoOfPhoto"].toString();

              pendingCount = (int.parse(data[0]["NoOfPhoto"].toString()) -
                      int.parse(data[0]["SelectedPhotoCount"].toString()))
                  .toString();

              final List<MenuClassOne> _allServices1 =
                  MenuClassOne.allServiceslist(
                      allCount, selectedCount, pendingCount);
              _allServices = _allServices1;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            showMsg("Try Again.");
            setState(() {
              albumData.clear();
            });
          }
        }, onError: (e) {
          setState(() {
            isLoading = false;
          });
          print("Error : on Login Call $e");
          //showMsg("$e");
          setState(() {
            albumData.clear();
          });
        });
      } else {
        pr.hide();
        showMsg("No Internet Connection.");
      }
    } on SocketException catch (_) {
      showMsg("No Internet Connection.");
    }
  }

  Widget _getServiceMenu(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        if (_allServices[index].title.toString() == "All Images") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AlbumAllImages(
                      albumId: widget.albumId,
                      albumName: widget.albumName,
                      totalImg: widget.totalImg)));
        } else if (_allServices[index].title.toString() == "Selected List") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectedList(
                      albumId: widget.albumId,
                      albumName: widget.albumName,
                      totalImg: widget.totalImg)));
        } else if (_allServices[index].title.toString() == "Unselected List") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => PendingList(
                      albumId: widget.albumId,
                      albumName: widget.albumName,
                      totalImg: widget.totalImg)));
        }
      },
      child: Card(
        elevation: 3,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 4, right: 4),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "images/" + _allServices[index].Iconpath,
                    width: 37,
                    height: 37,
                    color: cnst.appPrimaryMaterialColorPink,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      _allServices[index].title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "${_allServices[index].label}${_allServices[index].allCount}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
          // setState(() {
          //   isLoading = false;
          // });
          //  if (data.value == "true") {
          print("Message : " + data.access_token);
          Sms(data.access_token);
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

  Sms(String token) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isULoading = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String customerName = prefs.getString(Session.Name);
        String studioPhone = prefs.getString(Session.opicxoStudiophone);
        var body = {
          "country_id": "101",
          "mobile_number": "${studioPhone}",
          "type": "160",
          "token": [
            {"Customer.FullName": "${customerName}"}
          ]
        };
        print(body);
        AppServices.sendSms(body, token).then((data) async {
          setState(() {
            isULoading = false;
          });
          if (data.Data == "1") {
            // setState(() {
            //   prefs.setString(Session.opicxoStudioId, val);
            // });
            print("data1111");

            Fluttertoast.showToast(
                msg: "Sms send Successfully",
                backgroundColor: appPrimaryMaterialColorYellow,
                textColor: Colors.white,
                gravity: ToastGravity.TOP,
                toastLength: Toast.LENGTH_SHORT);
            Navigator.of(context).pop();
          } else {
            setState(() {
              isULoading = false;
            });
          }
        }, onError: (e) {
          setState(() {
            isULoading = false;
          });
          Fluttertoast.showToast(msg: "Try Again");
        });
      } else {
        setState(() {
          isULoading = false;
        });
        Fluttertoast.showToast(msg: "No Internet Connection.");
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  finalizeSelection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String galleryId = prefs.getString(Session.galleryId);
        AppServices.finalizeSelection(galleryId).then((data) async {
          setState(() {
            isLoading = false;
          });
          if (data.Data == "1") {
            Fluttertoast.showToast(
                msg: "Selection Finalized Successfully",
                backgroundColor: appPrimaryMaterialColorYellow,
                textColor: Colors.white,
                gravity: ToastGravity.TOP,
                toastLength: Toast.LENGTH_SHORT);
            // Navigator.of(context).pop();
          } else {
            setState(() {
              isLoading = false;
            });
          }
        }, onError: (e) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: "Try Again");
        });
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "No Internet Connection.");
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

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
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actionsIconTheme: IconThemeData.fallback(),
        title: Text("${widget.albumName}",
            style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Colors.white))),
        centerTitle: true,
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          finalizeSelection();
          accessToken();
        },
        child: Container(
          height: 60,
          color: cnst.appPrimaryMaterialColorYellow,
          child: Center(
              child: Text(
            "Finalize Selection",
            style: TextStyle(fontSize: 18, color: Colors.white),
          )),
        ),
      ),
      body: isLoading
          ? LoadinComponent()
          : WillPopScope(
              onWillPop: () {
                Navigator.pop(context);
              },
              child: Card(
                elevation: 10,
                child: Stack(
                  children: <Widget>[
                    /*     Container(
                      child: Opacity(
                        opacity: 0.2,
                        child: Image.asset(
                          "images/back12.png",
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),*/
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: albumData.length > 0
                          ? SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AlbumAllImages(
                                                      albumId: widget.albumId,
                                                      albumName:
                                                          widget.albumName,
                                                      totalImg:
                                                          widget.totalImg)));
                                    },
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          height: 220,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          /*child: Image.network(
                                    'https://upload.wikimedia.org/wikipedia/commons/9/9c/Hrithik_at_Rado_launch.jpg',
                                    //height: 150,
                                    fit: BoxFit.fill,
                                  ),*/
                                          child: albumData[0]["Photo"] != null
                                              ? FadeInImage.assetNetwork(
                                                  placeholder:
                                                      'images/No_photo.png',
                                                  image:
                                                      "${cnst.ImgUrl}${albumData[0]["Photo"]}",
                                                  fit: BoxFit.cover,
                                                )
                                              : Container(
                                                  color: Colors.grey[100],
                                                ),
                                        ),
                                        Container(
                                          height: 220,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color.fromRGBO(0, 0, 0, 0.5),
                                                Color.fromRGBO(0, 0, 0, 0.5),
                                                Color.fromRGBO(0, 0, 0, 0.5),
                                                Color.fromRGBO(0, 0, 0, 0.5)
                                              ],
                                            ),
                                            borderRadius: new BorderRadius.all(
                                                Radius.circular(0)),
                                          ),
                                        ),
                                        Container(
                                          height: 220,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    bottom: 5,
                                                    top: 5),
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      '${albumData[0]["Name"]}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    /*Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: Text(
                                                '${albumData[0]["SelectedPhotoCount"]}/${albumData[0]["NoOfPhoto"]}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),*/
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        /*Container(
                                  height: 220,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          'Expiry Date : ${albumData[0]["ExpDate"].substring(8, 10)} - '
                                          "${(((albumData[0]["ExpDate"].substring(5, 7)).toString()))} - ${albumData[0]["ExpDate"].substring(0, 4)}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                )*/
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 6.0,
                                        left: 6.0,
                                        right: 6.0,
                                        bottom: 10),
                                    child: GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: _allServices.length,
                                        itemBuilder: _getServiceMenu,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio:
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  //(370),
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      1.5),
                                        )),
                                  ),
                                ],
                              ),
                            )
                          : NoDataComponent(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class MenuClassOne {
  final String Iconpath;
  final String title;
  final String allCount;
  final String label;

  MenuClassOne({this.Iconpath, this.title, this.allCount, this.label});

  static List<MenuClassOne> allServiceslist(final String allcount,
      final String selectedCount, final String pendingCount) {
    var Vendorlist = new List<MenuClassOne>();

    Vendorlist.add(new MenuClassOne(
        Iconpath: "icon_allimages.png",
        title: "All Images",
        allCount: allcount,
        label: "Total = "));
    Vendorlist.add(new MenuClassOne(
        Iconpath: "icon_selected.png",
        title: "Selected List",
        allCount: selectedCount,
        label: "Selected = "));
    Vendorlist.add(new MenuClassOne(
        Iconpath: "icon_pending.png",
        title: "Unselected List",
        allCount: pendingCount,
        label: "Unselected = "));

    return Vendorlist;
  }
}
