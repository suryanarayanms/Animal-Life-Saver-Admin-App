import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:the_dog_project_admin/close.dart';
import 'package:the_dog_project_admin/map.dart';
import 'package:the_dog_project_admin/reject.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Viewrequest extends StatefulWidget {
  final String reqID;
  final String userID;
  final String name;
  final String comment;
  final String location;
  final String landmark;
  final String issue;
  final String imageurl;
  final String status;
  final String note;
  final String phoneNumber;
  final double lat;
  final double long;
  final String userPhoneNumber;
  const Viewrequest({
    Key key,
    this.reqID,
    this.comment,
    this.location,
    this.landmark,
    this.issue,
    this.imageurl,
    this.status,
    this.note,
    this.name,
    this.userID,
    this.phoneNumber,
    this.lat,
    this.long,
    this.userPhoneNumber,
  }) : super(key: key);

  @override
  State<Viewrequest> createState() => _ViewrequestState();
}

class _ViewrequestState extends State<Viewrequest> {
  String location = '';
  String address = 'click here to locate';

  Position position;

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    setState(() {
      address = "locating please wait....";
    });

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // ignore: non_constant_identifier_names
  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }

  String latitude;
  String longitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 75.0,
              left: 30,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => {
                      // print(DateTime.now().millisecondsSinceEpoch.toString()),
                      Navigator.pop(context)
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                  const Text(
                    'your request',
                    style: TextStyle(fontFamily: "BebasNeue", fontSize: 50),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 30),
            child: Center(child: gallery()),
          ),
          widget.status == "secured"
              ? Padding(
                  padding: const EdgeInsets.only(
                    // top: 30,
                    left: 30,
                    right: 30.0,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          autofocus: false,
                          autocorrect: false,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "BebasNeue",
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              hintMaxLines: 5,
                              enabled: false,
                              counterText: '',
                              hintText: widget.status,
                              hintStyle: const TextStyle(
                                  fontFamily: "BebasNeue",
                                  fontSize: 20,
                                  color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          autofocus: false,
                          autocorrect: false,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "BebasNeue",
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              enabled: false,
                              counterText: '',
                              hintText: widget.note,
                              hintStyle: const TextStyle(
                                  fontFamily: "BebasNeue",
                                  fontSize: 20,
                                  color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ]))
              : Padding(
                  padding: const EdgeInsets.only(
                    // top: 30,
                    left: 30,
                    right: 30.0,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => {
                            _getGeoLocationPosition(),
                            latitude = widget.lat.toString(),
                            longitude = widget.lat.toString(),
                            MapUtils.openMap(widget.lat, widget.long),
                          },
                          child: TextField(
                            autofocus: false,
                            autocorrect: false,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: "BebasNeue",
                            ),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                hintMaxLines: 5,
                                enabled: false,
                                counterText: '',
                                hintText: widget.location,
                                hintStyle: const TextStyle(
                                    fontFamily: "BebasNeue",
                                    fontSize: 20,
                                    color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          autofocus: false,
                          autocorrect: false,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "BebasNeue",
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              enabled: false,
                              counterText: '',
                              hintText: "issue: ${widget.issue}",
                              hintStyle: const TextStyle(
                                  fontFamily: "BebasNeue",
                                  fontSize: 20,
                                  color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          autofocus: false,
                          autocorrect: false,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "BebasNeue",
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              enabled: false,
                              counterText: '',
                              hintText: widget.comment,
                              hintStyle: const TextStyle(
                                  fontFamily: "BebasNeue",
                                  fontSize: 20,
                                  color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          autofocus: false,
                          autocorrect: false,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "BebasNeue",
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              enabled: false,
                              counterText: '',
                              hintText: widget.landmark,
                              hintStyle: const TextStyle(
                                  fontFamily: "BebasNeue",
                                  fontSize: 20,
                                  color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          autofocus: false,
                          autocorrect: false,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "BebasNeue",
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              enabled: false,
                              counterText: '',
                              hintText: "status: ${widget.status}",
                              hintStyle: const TextStyle(
                                  fontFamily: "BebasNeue",
                                  fontSize: 20,
                                  color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () => {
                            _callNumber(widget.userPhoneNumber),
                          },
                          child: TextField(
                            autofocus: false,
                            autocorrect: false,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: "BebasNeue",
                            ),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                hintMaxLines: 5,
                                enabled: false,
                                counterText: '',
                                hintText: widget.userPhoneNumber,
                                hintStyle: const TextStyle(
                                    fontFamily: "BebasNeue",
                                    fontSize: 20,
                                    color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ])),
          widget.status == "pending"
              ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () => {
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(widget.userID)
                                .collection("my-request")
                                .doc(widget.reqID)
                                .update({
                              "status": "active",
                              "handledby": widget.name,
                              "handlerID":
                                  FirebaseAuth.instance.currentUser.uid,
                              "handlerphoneNumber": widget.phoneNumber
                            }),
                            FirebaseFirestore.instance
                                .collection("requests")
                                .doc(widget.reqID)
                                .update({
                              "status": "active",
                              "handledby": widget.name,
                              "handlerID":
                                  FirebaseAuth.instance.currentUser.uid,
                              "handlerphoneNumber": widget.phoneNumber
                            }),
                            Navigator.pop(context),
                          },
                          child: Container(
                            height: 65,
                            width: 150,
                            // width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(12)),
                            child: const Center(
                              child: Text(
                                "accept request",
                                style: TextStyle(
                                    fontFamily: "BebasNeue",
                                    fontSize: 25,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Center(
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RejectRequest(
                                        widget.reqID,
                                        widget.userID,
                                        widget.name,
                                        widget.phoneNumber))),
                          },
                          child: Container(
                            height: 65,
                            width: 150,
                            // width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12)),
                            child: const Center(
                              child: Text(
                                "reject request",
                                style: TextStyle(
                                    fontFamily: "BebasNeue",
                                    fontSize: 25,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : widget.status == "active"
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Center(
                            child: GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RejectRequest(
                                            widget.reqID,
                                            widget.userID,
                                            widget.name,
                                            widget.phoneNumber))),
                              },
                              child: Container(
                                height: 65,
                                width: 150,
                                // width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12)),
                                child: const Center(
                                  child: Text(
                                    "reject request",
                                    style: TextStyle(
                                        fontFamily: "BebasNeue",
                                        fontSize: 25,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Center(
                            child: GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CloseRequest(
                                            widget.reqID,
                                            widget.userID,
                                            widget.name,
                                            widget.phoneNumber))),
                              },
                              child: Container(
                                height: 65,
                                width: 150,
                                // width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(12)),
                                child: const Center(
                                  child: Text(
                                    "close request",
                                    style: TextStyle(
                                        fontFamily: "BebasNeue",
                                        fontSize: 25,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Center(),
        ]),
      ),
    );
  }

  gallery() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Card(
                color: const Color(0xff181A28),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.antiAlias,
                // child: Text(
                // widget.note != null ? widget.imageurl : widget.note,
                // ),
                child: Image.network(
                  widget.imageurl,
                  width: 215,
                  height: 170,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _callNumber(a) async {
    bool res = await FlutterPhoneDirectCaller.callNumber(a);
  }

  // Future<void> _openMap(String lat, String long) async {
  //   String googleURL =
  //       'https://www.google.com/maps/search/?api=1&query=${lat},${long}';
  //   await canLaunchUrlString(googleURL)
  //       ? await launchUrlString(googleURL)
  //       : throw 'Could not launch $googleURL';
  // }
}
