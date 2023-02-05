import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:the_dog_project_admin/auth_service.dart';
import 'package:the_dog_project_admin/login_splash.dart';
import 'package:the_dog_project_admin/theme.dart';
import 'package:the_dog_project_admin/view_request.dart';

class AdoptionScreen extends StatefulWidget {
  const AdoptionScreen({Key key}) : super(key: key);

  @override
  State<AdoptionScreen> createState() => _AdoptionScreenState();
}

class _AdoptionScreenState extends State<AdoptionScreen> {
  String name = "";
  String mobileNumber = "";
  File imageFile;
  XFile imagePath;
  File imagepicked;
  String number = "";
  var uploadPath = '';
  final ImagePicker picker = ImagePicker();
  FirebaseStorage storageRef = FirebaseStorage.instance;

  String phoneNumber = "";

  var reqID = "";

  var location;

  var landmark;
  var comment;
  var issue;
  var imageurl;

  var status;

  var note;

  var statusImage;

  var userID;
  Future<void> retrieveData() async {
    number = context.watch<TemporaryData>().phoneNumber;
  }

  CollectionReference ref = FirebaseFirestore.instance.collection('requests');

  @override
  Widget build(BuildContext context) {
    // retrieveData(FirebaseAuth.instance.currentUser.uid);
    return (context.watch<TemporaryData>().phoneNumber == "")
        ? Scaffold(
            backgroundColor: Colors.grey[200],
            body: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 35.0,
                      bottom: 50,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => {Navigator.pop(context)},
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 50,
                          ),
                        ),
                        const Text(
                          'FILL ME',
                          style:
                              TextStyle(fontFamily: "BebasNeue", fontSize: 50),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    autofocus: false,
                    keyboardType: TextInputType.name,
                    maxLength: 15,
                    autocorrect: false,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "BebasNeue",
                    ),
                    cursorColor: Colors.black,
                    onChanged: (_name) {
                      name = _name;
                    },
                    decoration: InputDecoration(
                        counterText: '',
                        hintText: 'name',
                        hintStyle: const TextStyle(
                            fontFamily: "BebasNeue",
                            fontSize: 20,
                            color: Colors.black45),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    autofocus: false,
                    autocorrect: false,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "BebasNeue",
                    ),
                    cursorColor: Colors.black,
                    maxLength: 10,
                    onChanged: (_mobileNumber) {
                      mobileNumber = _mobileNumber;
                    },
                    decoration: InputDecoration(
                        hintText: 'Phone number',
                        counterText: '',
                        hintStyle: const TextStyle(
                            fontFamily: "BebasNeue",
                            fontSize: 20,
                            color: Colors.black45),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () => {
                      if (name == null && mobileNumber == null)
                        {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            isDismissible: false,
                            isScrollControlled: false,
                            builder: (context) {
                              return Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50.0, left: 20, right: 20),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'enter name and mobile number',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontFamily: "BebasNeue",
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 20.0),
                                          child: GestureDetector(
                                            onTap: () =>
                                                {Navigator.pop(context)},
                                            child: Container(
                                              height: 65,
                                              decoration: BoxDecoration(
                                                  color: Colors.pink,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: const Center(
                                                child: Text(
                                                  "ok",
                                                  style: TextStyle(
                                                      fontFamily: "BebasNeue",
                                                      fontSize: 25,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            },
                          ),
                        }
                      else if (name != null && mobileNumber == null)
                        {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            isDismissible: false,
                            isScrollControlled: false,
                            builder: (context) {
                              return Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50.0, left: 20, right: 20),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'enter mobile number',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontFamily: "BebasNeue",
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 20.0),
                                          child: GestureDetector(
                                            onTap: () =>
                                                {Navigator.pop(context)},
                                            child: Container(
                                              height: 65,
                                              decoration: BoxDecoration(
                                                  color: Colors.pink,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: const Center(
                                                child: Text(
                                                  "ok",
                                                  style: TextStyle(
                                                      fontFamily: "BebasNeue",
                                                      fontSize: 25,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            },
                          ),
                        }
                      else if (name == null && mobileNumber != null)
                        {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            isDismissible: false,
                            isScrollControlled: false,
                            builder: (context) {
                              return Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50.0, left: 20, right: 20),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'enter name',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontFamily: "BebasNeue",
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 20.0),
                                          child: GestureDetector(
                                            onTap: () =>
                                                {Navigator.pop(context)},
                                            child: Container(
                                              height: 65,
                                              decoration: BoxDecoration(
                                                  color: Colors.pink,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: const Center(
                                                child: Text(
                                                  "ok",
                                                  style: TextStyle(
                                                      fontFamily: "BebasNeue",
                                                      fontSize: 25,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            },
                          ),
                        }
                      else if (mobileNumber.length < 10)
                        {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            isDismissible: false,
                            isScrollControlled: false,
                            builder: (context) {
                              return Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50.0, left: 20, right: 20),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'enter 10 dight mobile number',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontFamily: "BebasNeue",
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 20.0),
                                          child: GestureDetector(
                                            onTap: () =>
                                                {Navigator.pop(context)},
                                            child: Container(
                                              height: 65,
                                              decoration: BoxDecoration(
                                                  color: Colors.pink,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: const Center(
                                                child: Text(
                                                  "ok",
                                                  style: TextStyle(
                                                      fontFamily: "BebasNeue",
                                                      fontSize: 25,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            },
                          ),
                        }
                      else
                        {
                          FirebaseFirestore.instance
                              .collection("admin-login")
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .update({
                            "phoneNumber": mobileNumber,
                            "name": name,
                          }),
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const AdoptionScreen(),
                            ),
                            (route) => false,
                          )
                        }
                    },
                    child: Container(
                      height: 65,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontFamily: "BebasNeue",
                              fontSize: 25,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.grey[200],
            body: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 35.0,
                      bottom: 30,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'my requests',
                          style:
                              TextStyle(fontFamily: "BebasNeue", fontSize: 50),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => {
                            AuthService().signOut(),

                            // context.read<TemporaryData>().cleanData(),
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginSplashScreen(),
                              ),
                              (route) => false,
                            )
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                "assets/images/shutdown.png",
                                height: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: StreamBuilder(
                        stream: ref.snapshots(),
                        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data?.docs?.length != 0) {
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.all(10),
                                itemCount: snapshot.data?.docs?.length,
                                itemBuilder: ((context, index) {
                                  dynamic doc =
                                      snapshot.data?.docs[index].data();
                                  return (doc['status'] == "pending") ||
                                          (doc['status'] == "active" &&
                                              doc['handledby'] ==
                                                  context
                                                      .watch<TemporaryData>()
                                                      .name) ||
                                          (doc['status'] == "secured" &&
                                              doc['handledby'] ==
                                                  context
                                                      .watch<TemporaryData>()
                                                      .name)
                                      ? Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20),
                                              child: Container(
                                                // height: 200,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            22),
                                                    color: doc['status'] ==
                                                            "secured"
                                                        ? Colors.green
                                                        : doc['status'] ==
                                                                "active"
                                                            ? Colors.orange
                                                            : Colors.white),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0,
                                                          top: 20,
                                                          bottom: 20,
                                                          right: 140),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Card(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            color: doc['status'] ==
                                                                    "secured"
                                                                ? Colors.white
                                                                : doc['status'] ==
                                                                        "active"
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .blueGrey
                                                                        .shade50,
                                                            child:
                                                                Image.network(
                                                              doc['image'],
                                                              width: 125,
                                                              height: 125,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                    "issue:  " +
                                                                        doc['issue'],
                                                                    style: TextStyle(
                                                                        color: doc['status'] == "secured"
                                                                            ? Colors.white
                                                                            : doc['status'] == "active"
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                        fontFamily: "BebasNeue",
                                                                        fontSize: 20)),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0,
                                                                        right:
                                                                            8.0,
                                                                        bottom:
                                                                            8.0),
                                                                child: RichText(
                                                                    text: TextSpan(
                                                                        children: [
                                                                      TextSpan(
                                                                        text: "note: \n" +
                                                                            doc["comment"],
                                                                        style:
                                                                            TextStyle(
                                                                          color: doc['status'] == "secured"
                                                                              ? Colors.white
                                                                              : doc['status'] == "active"
                                                                                  ? Colors.white
                                                                                  : Colors.black,
                                                                          fontSize:
                                                                              20,
                                                                          fontFamily:
                                                                              "BebasNeue",
                                                                        ),
                                                                      ),
                                                                    ])),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0,
                                                                        right:
                                                                            8.0,
                                                                        bottom:
                                                                            8.0),
                                                                child: RichText(
                                                                    text: TextSpan(
                                                                        children: [
                                                                      TextSpan(
                                                                        text: "location:  \n" +
                                                                            doc["location"],
                                                                        style:
                                                                            TextStyle(
                                                                          color: doc['status'] == "secured"
                                                                              ? Colors.white
                                                                              : doc['status'] == "active"
                                                                                  ? Colors.white
                                                                                  : Colors.black,
                                                                          fontSize:
                                                                              20,
                                                                          fontFamily:
                                                                              "BebasNeue",
                                                                        ),
                                                                      ),
                                                                    ])),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      GestureDetector(
                                                        onTap: () => {
                                                          userID = doc['uid'],
                                                          reqID =
                                                              doc['request-id'],
                                                          location =
                                                              doc['location'],
                                                          landmark =
                                                              doc['landmark'],
                                                          comment =
                                                              doc['comment'],
                                                          imageurl =
                                                              doc['image'],
                                                          issue = doc['issue'],
                                                          status =
                                                              doc['status'],
                                                          note = doc['note'],
                                                          statusImage = doc[
                                                              'status_image'],
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => Viewrequest(
                                                                      phoneNumber: context
                                                                          .watch<
                                                                              TemporaryData>()
                                                                          .phoneNumber,
                                                                      userID:
                                                                          userID,
                                                                      name: context
                                                                          .watch<
                                                                              TemporaryData>()
                                                                          .name,
                                                                      status:
                                                                          status,
                                                                      reqID:
                                                                          reqID,
                                                                      location:
                                                                          location,
                                                                      landmark:
                                                                          landmark,
                                                                      comment:
                                                                          comment,
                                                                      imageurl:
                                                                          imageurl,
                                                                      issue:
                                                                          issue,
                                                                      note:
                                                                          note,
                                                                      statusImage:
                                                                          statusImage)))
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            // height: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                12),
                                                                    color: doc['status'] ==
                                                                            "secured"
                                                                        ? const Color.fromARGB(
                                                                                255,
                                                                                31,
                                                                                110,
                                                                                34)
                                                                            .withOpacity(
                                                                                0.5)
                                                                        : doc['status'] ==
                                                                                "active"
                                                                            ? const Color.fromARGB(
                                                                                255,
                                                                                214,
                                                                                135,
                                                                                25)
                                                                            : Colors.grey.withOpacity(0.2)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10.0,
                                                                      top: 10,
                                                                      bottom:
                                                                          10),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                      'click here',
                                                                      style: TextStyle(
                                                                          color: doc['status'] == "secured"
                                                                              ? Colors.white
                                                                              : doc['status'] == "active"
                                                                                  ? Colors.white
                                                                                  : Colors.black,
                                                                          fontFamily: "BebasNeue",
                                                                          fontSize: 25)),
                                                                  Icon(
                                                                      Icons
                                                                          .keyboard_arrow_right_outlined,
                                                                      color: doc['status'] ==
                                                                              "secured"
                                                                          ? Colors
                                                                              .white
                                                                          : doc['status'] == "active"
                                                                              ? Colors.white
                                                                              : Colors.black,
                                                                      size: 40),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : const Center(
                                          child: Text(""),
                                        );
                                }),
                              );
                            } else {
                              return const Center(
                                  child: Text("No request's submitted",
                                      style: TextStyle(
                                          color: Colors.black38,
                                          fontFamily: "BebasNeue",
                                          fontSize: 25)));
                            }
                          } else {
                            return const Center(
                              child: Text("No request's submitted",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontFamily: "BebasNeue",
                                      fontSize: 25)),
                            );
                          }
                        }),
                    // child: StreamBuilder<QuerySnapshot>(
                    //     stream: FirebaseFirestore.instance
                    //         .collection('users').doc(id).collection()
                    //         .snapshots(),
                    //     builder: (context, snapshots) {
                    //       return ListView.builder(
                    //         physics: const BouncingScrollPhysics(),
                    //         itemCount: snapshots.data.docs.length,
                    //         itemBuilder: ((context, index) {
                    //           int a = snapshots.data.docs.length;
                    //           var data = snapshots.data.docs[index].data()
                    //               as Map<String, dynamic>;
                    //           return Text(
                    //             data['name'],

                    //             style: TextStyle(color: Colors.black),
                    //           );
                    //         }),
                    //       );
                    //     }),
                  )
                ],
              ),
            ),
          );
  }
}
