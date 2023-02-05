import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TemporaryData extends ChangeNotifier {
  // Theme Changer

  String _uid = "";
  String get uid => _uid;
  String _phoneNumber = "";
  String get phoneNumber => _phoneNumber;
  String _name = "";
  String get name => _name;
  String _email = "";
  String get email => _email;
  int _followers = 0;
  int get followers => _followers;
  int _following = 0;
  int get following => _following;
  String _profilepic = "";
  String get profilepic => _profilepic;
  String _accountName = "";
  String get accountName => _accountName;
  String _bio = "";
  String get bio => _bio;
  bool _theme = true;
  bool get theme => _theme;

  Future<void> retrieveData(id) async {
    var _doc = await FirebaseFirestore.instance
        .collection("admin-login")
        .doc(id)
        .get();

    _uid = _doc.data()['uid'];
    _name = _doc.data()['name'];
    _email = _doc.data()['email'];
    _phoneNumber = _doc.data()['phoneNumber'];
    _followers = _doc.data()['followers'];
    _accountName = _doc.data()['accountName'];
    _following = _doc.data()['following'];
    _profilepic = _doc.data()['profilepic'];
    _bio = _doc.data()['bio'];
    _theme = _doc.data()['theme'];

    notifyListeners();
  }

  Future<void> cleanData() async {
    _phoneNumber = "";
    notifyListeners();
  }
// Search user follow unfollow
  // String? _followsuid = "";
  // String? get followsuid => _followsuid;
  // String? _followsname = "";
  // String? get followsname => _followsname;
  // String? _followsbio = "";
  // String? get followsbio => _followsbio;
  // String? _followsprofilepic = "";
  // String? get followsprofilepic => _followsprofilepic;

  // Future<void> follows(tof) async {
  //   _uid = FirebaseAuth.instance.currentUser!.uid;

  //   var _followsdocs = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(_uid)
  //       .collection("following")
  //       .doc(tof)
  //       .get();

  //   _followsuid = _followsdocs.data()?['uid'];
  //   var _followsdetails =
  //       await FirebaseFirestore.instance.collection("users").doc(tof).get();

  //   _followsname = _followsdetails.data()?['accountName'];
  //   _followsbio = _followsdetails.data()?['bio'];
  //   _followsprofilepic = _followsdetails.data()?['profilepic'];

  //   notifyListeners();
  // }

// Following
  // String _myfollowingsuid = "";
  // String? get myfollowingsuid => _myfollowingsuid;
  // String? _myfollowingaccountName = "";
  // String? get myfollowingaccountName => _myfollowingaccountName;
  // String? _myfollowingbio = "";
  // String? get myfollowingbio => _myfollowingbio;
  // String _myfollowingprofilepic = "";
  // String? get myfollowingprofilepic => _myfollowingprofilepic;

  // Future<void> myfollowing(user) async {
  //   _uid = FirebaseAuth.instance.currentUser!.uid;

  //   var _followsdocs = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(_uid)
  //       .collection("following")
  //       .doc(user)
  //       .get();

  //   _myfollowingsuid = _followsdocs.data()?['uid'];
  //   var _followingdetails = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(_myfollowingsuid)
  //       .get();

  //   _myfollowingaccountName = _followingdetails.data()?['accountName'];
  //   _myfollowingbio = _followingdetails.data()?['bio'];
  //   _myfollowingprofilepic = _followingdetails.data()?['profilepic'];
  //   notifyListeners();
  // }

// Follower
  // String? _myfollowersuid = "";
  // String? get myfollowersuid => _myfollowersuid;
  // String _myfollowername = "";
  // String? get myfollowername => _myfollowername;
  // String _myfollowerbio = "";
  // String? get myfollowerbio => _myfollowerbio;
  // String _myfollowerprofilepic = "";
  // String? get myfollowerprofilepic => _myfollowerprofilepic;
  // Future<void> myfollowers(follower) async {
  //   _uid = FirebaseAuth.instance.currentUser!.uid;

  //   var _followersdocs = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(_uid)
  //       .collection("followers")
  //       .doc(follower)
  //       .get();
  //   _myfollowersuid = _followersdocs.data()?['uid'];
  //   var _followerdetails = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(_myfollowersuid)
  //       .get();
  //   _myfollowername = _followerdetails.data()?['accountName'];
  //   _myfollowerbio = _followerdetails.data()?['bio'];
  //   _myfollowerprofilepic = _followerdetails.data()?['profilepic'];

  //   notifyListeners();
  // }

  // Future<void> fun() async {
  //    var _data = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(_uid)
  //       .collection("followers")
  //       .doc()
  //       .get();
  //        _data =_data.data()?['uid'];
  // }
}
