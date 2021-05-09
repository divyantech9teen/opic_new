import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pictiknew/Common/AppService.dart';
import 'package:pictiknew/Common/Constants.dart';
import 'package:pictiknew/Components/LoadinComponent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FruitsList {
  String name;
  int index;

  FruitsList({this.name, this.index});
}

class ChangeStudio extends StatefulWidget {
  @override
  _ChangeStudioState createState() => _ChangeStudioState();
}

class _ChangeStudioState extends State<ChangeStudio> {
  String radioItem;

  bool isLoading = true;
  bool isULoading = false;
  String val = "male";

  // Group Value for Radio Button.
  int id;

  List studioList = [];

  // a puro taro code che

  @override
  void initState() {
    _getStudio();
  }

  _getStudio() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //pr.show();
        setState(() {
          isLoading = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var studId = prefs.getString(Session.opicxoStudioId);
        Future res = AppServices.getStudioList();
        res.then((data) async {
          //pr.hide();
          setState(() {
            isLoading = false;
          });

          if (data != null && data.length > 0) {
            setState(() {
              studioList = data;
              // val = studioList[0]["Opicxo_StudioBLId"];
            });
            for (int i = 0; i < data.length; i++) {
              if (data[i]["Opicxo_StudioBLId"] == studId) {
                setState(() {
                  val = studioList[i]["Opicxo_StudioBLId"];
                });
              }
            }
            print("studiooo ${studioList}");
          } else {
            Fluttertoast.showToast(msg: "Invalid login Detail");
          }
        }, onError: (e) {
          // setState(() {
          //   pr.hide();
          // });
          setState(() {
            isLoading = false;
          });

          print("Error : on Login Call $e");
          Fluttertoast.showToast(msg: "$e");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  updateStudio() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isULoading = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String OpicxoCustomerId = prefs.getString(Session.opicxoCustomerId);

        AppServices.updateStudio(OpicxoCustomerId, val).then((data) async {
          setState(() {
            isULoading = false;
          });
          if (data.Data == "1") {
            setState(() {
              prefs.setString(Session.opicxoStudioId, val);
            });

            print("data1");

            Fluttertoast.showToast(
                msg: "Studio Updated Successfully",
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
                appPrimaryMaterialColorPink,
                appPrimaryMaterialColorYellow
              ],
            ),
          ),
        ),
        title: Text("Change Studio"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Select Studio to load data",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: studioList
                    .map((data) => RadioListTile(
                        title: Text("${data["Name"]}"),
                        value: data["Opicxo_StudioBLId"],
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {
                            val = value;
                          });
                          print(val);
                          print(value);
                        }))
                    .toList(),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                width: 150,
                height: 40,
                child: FlatButton(
                    color: appPrimaryMaterialColorYellow,
                    onPressed: () {
                      updateStudio();
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
