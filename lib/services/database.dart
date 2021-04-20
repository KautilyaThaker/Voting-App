import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import 'package:flutter/material.dart';

class UserProfile {
  final String uid;
  final String name;
  final String email;
  final String occupation;
  final String photoURL;

  UserProfile(
      {this.uid, this.name, this.email, this.occupation, this.photoURL});
}

class Candi {
  final String name;
  final String slogan;
  final int uniquekey;

  Candi({this.name, this.slogan,this.uniquekey});
  factory Candi.fromFireStore(DocumentSnapshot doc)
  {
    Map data = doc.data() ;
    return Candi(
        name: data['name'],
        slogan: data['slogan']
        // course_name: data['course_name'],
        // master_name: data['master_name'],
        // master_email: data['master_email'],
        // course_uid: doc.documentID,
        // pic_url: data['pic_url'],
        // details: data['details'],
        // price: data['price']
    );
  }
}

class DatabaseService {
  DatabaseService({this.uid,this.Vkey});

  //collection reference
  String uid;
  String CreatorName;
  String Vkey;
  int UniqueKey=50;//Random().nextInt(999999);


  // String getRandomString(int len) {
  //   var r = Random();
  //   const _chars =
  //       'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  //   return (List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
  //           .join())
  //       .toString();
  // }

  Void show() {
    print('Unique in Database : $UniqueKey ');
  }

  final CollectionReference profileCollection =
      FirebaseFirestore.instance.collection('profile');

  //Create user for profile page
  Future updateUserData(
      String name, String occupation, String email, String photo) async {
    return await profileCollection.doc(uid).set({
      "name": name,
      "occupation": occupation,
      "email": email,
      "photoURL": photo,
    });
  }

  UserProfile _userProfileFromSnapshot(DocumentSnapshot snapshot) {
    //created for userData
    return UserProfile(
      uid: uid,
      name: snapshot.data()['name'],
      occupation: snapshot.data()['occupation'],
      email: snapshot.data()['email'],
      photoURL: snapshot.data()['photoURL'],
    );
  }

  Stream<UserProfile> get userData {
    //user in profile page
    return profileCollection.doc(uid).snapshots().map(_userProfileFromSnapshot);
  }

  //For Candidate

  // int rand =Random().nextInt(999999);



  static List<Candi> FinalCandidateList = [] ;
  CandidateList() async{
    List listOfCandidates = await FirebaseFirestore.instance.collection("Candidate_collection").get().then((value) => value.docs) ;
    // Stream<DocumentSnapshot> snapshot = listOfCandidates.snapshots();
    for (int i=0; i<listOfCandidates.length; i++)
    {
      print('${listOfCandidates[i].CreatorName}');
      FirebaseFirestore.instance.collection("masters").doc('${listOfCandidates[i].CreatorName}').collection("courses").snapshots().listen(CreateListofCandidates);
    }
  }
  void CreateListofCandidates(QuerySnapshot snapshot) {
    var docs = snapshot.docs;

    for (var doc in docs)
    {
      FinalCandidateList.add(Candi.fromFireStore(doc));
    }
  }

  String hi = 'hello';
  //Create candidate for Enter Candidate
  CollectionReference candidate =  FirebaseFirestore.instance.collection("Candidate_collection");
  String documentIdFromCurrentDate() => DateTime.now().toIso8601String();


  Future AddVotingDetails(  String V_name, String post, String host, String VotingKey ){
    return candidate.doc('$VotingKey').set({
      'votingname':V_name,
      'post':post,
      'host':host,
      'votingkey':VotingKey,
    });
  }

  Future AddCandidate(
      {String Candidatename, String Slogan, String creatorName}) {
    this.CreatorName = creatorName;
    print('Candidate Added by:${this.CreatorName}  UniqueKey: ${this.Vkey}');
    show();
    return candidate
        .doc('$Vkey') //name : creator of voting
        .collection('$creatorName')
        .doc('$Candidatename')
        .set({
          'CandidateName': Candidatename, // null
          'slogan': Slogan, // null
          'uniquekey': this.UniqueKey,
        })
        .then((value) => print("Candidate Added"))
        .catchError((error) => print("Failed to add Candidate: $error"));
  }



  List<Candi> _CandidateListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Candi(
        name: doc.data()['CandidateName'] ?? '',
        slogan: doc.data()['slogan']??'',
        uniquekey: doc.data()['uniquekey'],
      );
    }).toList();
  }

  Stream<List<Candi>> get Candidate {
    return candidate
        .doc('$CreatorName')//change to creator name
        .collection('$Vkey')
        // .orderBy('CandidateName',descending: true)
        .snapshots().map(_CandidateListFromSnapshot);
  }


}
