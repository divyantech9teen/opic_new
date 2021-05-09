import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pictiknew/Common/Constants.dart' as cnst;
import 'package:url_launcher/url_launcher.dart';

class StudioNameOnTap extends StatefulWidget {
  var NewList;

  StudioNameOnTap(this.NewList);

  @override
  _StudioNameOnTapState createState() => _StudioNameOnTapState();
}

class _StudioNameOnTapState extends State<StudioNameOnTap> {
  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        title: Text("${widget.NewList["MainStudioName"]}",
            style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Colors.white))),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        cnst.appPrimaryMaterialColorYellow,
                        cnst.appPrimaryMaterialColorPink
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/person.png"),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      widget.NewList["MainStudioName"] != null
                          ? Text(
                              "${widget.NewList["MainStudioName"]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 23),
                            )
                          : Text(
                              "",
                              style: TextStyle(
                                  //fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 23),
                            ),
                      SizedBox(
                        height: 3,
                      ),
                      widget.NewList["Mobile"] != null
                          ? Text(
                              "${widget.NewList["Mobile"]}",
                              style: TextStyle(
                                  //fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 20),
                            )
                          : Text(
                              "",
                              style: TextStyle(
                                  //fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                      SizedBox(
                        height: 3,
                      ),
                      widget.NewList["Email"] != null
                          ? Text(
                              "${widget.NewList["Email"]}",
                              style: TextStyle(
                                  //fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 20),
                            )
                          : Text(
                              "",
                              style: TextStyle(
                                //fontWeight: FontWeight.w700,
                                color: Colors.white,

                                fontSize: 20,
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // Row(
                        //   children: <Widget>[
                        //     // Expanded(
                        //     //   flex: 5,
                        //     //   child: Padding(
                        //     //     padding: const EdgeInsets.all(8.0),
                        //     //     child: Text(
                        //     //       "Studio Name",
                        //     //       style: TextStyle(
                        //     //           fontSize: 15, fontWeight: FontWeight.w700),
                        //     //     ),
                        //     //   ),
                        //     // ),
                        //     // Expanded(
                        //     //   flex: 1,
                        //     //   child: Padding(
                        //     //     padding: const EdgeInsets.all(8.0),
                        //     //     child: Text(
                        //     //       ":",
                        //     //       style: TextStyle(
                        //     //           fontSize: 15, fontWeight: FontWeight.w700),
                        //     //     ),
                        //     //   ),
                        //     // ),
                        //     Expanded(
                        //       flex: 7,
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Text(
                        //           "${widget.NewList["MainStudioName"]}",
                        //           style: TextStyle(
                        //             fontSize: 20,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Mobile",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  ":",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.NewList["Mobile"] != null
                                      ? "${widget.NewList["Mobile"]}"
                                      : "",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Alternate Mobile",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  ":",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.NewList["AlternateMobile"] != null
                                      ? "${widget.NewList["AlternateMobile"]}"
                                      : "",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Email",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  ":",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.NewList["Email"] != null
                                      ? "${widget.NewList["Email"]}"
                                      : "",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "State",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  ":",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.NewList["StateName"] != null
                                      ? "${widget.NewList["StateName"]}"
                                      : "",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "City",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  ":",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.NewList["CityName"] != null
                                      ? "${widget.NewList["CityName"]}"
                                      : "",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Address",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  ":",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.NewList["Address"] != null
                                      ? "${widget.NewList["Address"]}"
                                      : "",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "PinCode",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  ":",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.NewList["Pincode"] != null
                                      ? "${widget.NewList["Pincode"]}"
                                      : "",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /*Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                      onTap: (){
                        var latlong = widget.NewList["LatLong"]
                            .toString()
                            .split(",");
                        openMap(
                            double.parse(latlong[0]),
                            double.parse(latlong[1]));
                      },
                      child: Image.asset("images/location1.png",height: 30,width: 30,)),
                ],
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
