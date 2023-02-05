import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_dog_project_admin/adoptionscreen.dart';

class RejectRequest extends StatefulWidget {
  final String reqID;
  final String userID;
  final String name;
  final String phoneNumber;
  const RejectRequest(this.reqID, this.userID, this.name, this.phoneNumber,
      {Key key})
      : super(key: key);

  @override
  State<RejectRequest> createState() => RrejectStateRequest();
}

class RrejectStateRequest extends State<RejectRequest> {
  String reason;

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
                'reject request',
                style: TextStyle(fontFamily: "BebasNeue", fontSize: 50),
              ),
            ],
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(left: 30.0, right: 30, bottom: 30),
        child: Center(),
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
                  hintText: "reason for rejecting",
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
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(widget.userID)
                            .collection("my-request")
                            .doc(widget.reqID)
                            .update({
                          "status": "rejected",
                          "handledby": widget.name,
                          "handlerID": FirebaseAuth.instance.currentUser.uid,
                          "reason": reason,
                          "handlerphoneNumber": widget.phoneNumber,
                        }),
                        FirebaseFirestore.instance
                            .collection("requests")
                            .doc(widget.reqID)
                            .update({
                          "status": "rejected",
                          "handledby": widget.name,
                          "handlerID": FirebaseAuth.instance.currentUser.uid,
                          "handlerphoneNumber": widget.phoneNumber,
                          "reason": reason,
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
          ])),
    ])));
  }
}
