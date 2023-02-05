import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_dog_project_admin/close.dart';
import 'package:the_dog_project_admin/reject.dart';

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
  final String statusImage;
  final String phoneNumber;
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
    this.statusImage,
    this.name,
    this.userID,
    this.phoneNumber,
  }) : super(key: key);

  @override
  State<Viewrequest> createState() => _ViewrequestState();
}

class _ViewrequestState extends State<Viewrequest> {
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
                              hintText: "issue: " + widget.issue,
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
                              hintText: "status: " + widget.status,
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
                  widget.status == "secured"
                      ? widget.statusImage
                      : widget.imageurl,
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
}
