import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_dog_project_admin/adoptionscreen.dart';

class CloseRequest extends StatefulWidget {
  final String reqID;
  final String userID;
  final String name;
  final String handlerphoneNumber;
  const CloseRequest(
      this.reqID, this.userID, this.name, this.handlerphoneNumber,
      {Key key})
      : super(key: key);

  @override
  State<CloseRequest> createState() => CloseStateRequest();
}

class CloseStateRequest extends State<CloseRequest> {
  String reason;
  File imageFile;
  XFile imagePath;
  File imagepicked;
  var uploadPath = '';
  final ImagePicker _picker = ImagePicker();

  FirebaseStorage storageRef = FirebaseStorage.instance;

  String collectionName = "issueImages";

  String uploadFileName = "";

  Reference reference;

  UploadTask uploadTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                onTap: () => {Navigator.pop(context)},
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 50,
                ),
              ),
              const Text(
                'close request',
                style: TextStyle(fontFamily: "BebasNeue", fontSize: 50),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 30),
        child: Center(
          child: gallery(),
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(
            // top: 30,
            left: 30,
            right: 30.0,
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              maxLines: null,
              autofocus: false,
              autocorrect: false,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: "BebasNeue",
              ),
              cursorColor: Colors.black,
              onChanged: (_reason) {
                reason = _reason;
              },
              decoration: InputDecoration(
                  hintMaxLines: 5,
                  counterText: '',
                  hintText: "reason for closing",
                  hintStyle: const TextStyle(
                      fontFamily: "BebasNeue",
                      fontSize: 20,
                      color: Colors.black),
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
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () => {
                        uploadFileName =
                            DateTime.now().millisecondsSinceEpoch.toString() +
                                '.jpg',
                        reference = storageRef
                            .ref()
                            .child(collectionName)
                            .child(uploadFileName),
                        uploadTask = reference.putFile(File(imagePath.path)),
                        setState(() {
                          imageFile = File(imagePath.path);
                        }),
                        uploadTask.whenComplete(() async {
                          uploadPath =
                              await uploadTask.snapshot.ref.getDownloadURL();
                          // print('uploaded');

                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(widget.userID)
                              .collection("my-request")
                              .doc(widget.reqID)
                              .update({
                            "status": "secured",
                            "handledby": widget.name,
                            "handlerID": FirebaseAuth.instance.currentUser.uid,
                            "reason": reason,
                            "image": uploadPath,
                            "handlerphoneNumber": widget.handlerphoneNumber,
                          });
                          FirebaseFirestore.instance
                              .collection("requests")
                              .doc(widget.reqID)
                              .update({
                            "status": "secured",
                            "handledby": widget.name,
                            "handlerID": FirebaseAuth.instance.currentUser.uid,
                            "reason": reason,
                            "image": uploadPath,
                            "handlerphoneNumber": widget.handlerphoneNumber,
                          });
                        }),
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const AdoptionScreen(),
                          ),
                          (route) => false,
                        )
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
          ])),
    ])));
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
                child: imagepicked != null
                    ? GestureDetector(
                        onTap: (() => {imagepicker()}),
                        child: Image.file(
                          imagepicked,
                          width: 215,
                          height: 170,
                          fit: BoxFit.cover,
                        ),
                      )
                    : GestureDetector(
                        onTap: (() => {imagepicker()}),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 150,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xff181A28),
                          ),
                          child: const Center(
                            child: Text(
                              'open camera',
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
        ],
      ),
    );
  }

  imagedeleter() {
    setState(() {
      imagepicked = null;
      uploadPath = '';
    });
  }

  imagepicker() async {
    final XFile image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      try {
        final imageFile = File(image.path);
        setState(() {
          imagepicked = imageFile;
        });
      } finally {}

      setState(() {
        imagePath = image;
        imgname = image.name.toString();
      });
    }
  }

  String imgname = '';
}
