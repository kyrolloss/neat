import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData{

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {

  Reference ref =  _storage.ref().child(childName).child('id');
  UploadTask uploadTask = ref.putData(file);
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
  }

  Future <String> saveData({

  required Uint8List file,
}) async {
    String resp = " Some Error Occurred ";
    try {

    String imageUrl =  await uploadImageToStorage('profileImage', file);
    await _firestore.collection('Users').add({
      'image link' : imageUrl,
    });

    }
        catch (err){
      resp = err.toString();
        }
        return resp;
}

}