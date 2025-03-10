  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Models/message_model/message.dart';
class ChatService extends ChangeNotifier{
  /// get instance of auth and firestore
  final  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  /// get user stream
  /*
  [
  {
    'email' : test@gmail.com,
    'id' : ...
  },
  {
    'email' : user@gmail.com,
    'id' : ...
  },
  ]
   */
  /// get user stream
  Stream<List<Map<String, dynamic>>> getUserStream(){
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        /// go through each individual user
        final user = doc.data();
        /// return user
        return user;
      }).toList();
    });
  }




  /// SEND MESSAGE
  Future<void> sendMessage(String receiverId, String message) async {
    /// get current user info
    String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    /// create a new message
    Message newMessage = Message(
      
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    /// construct chat room id from current user id and receiver id (sorted to insure uniqueness)
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // sort the ids (this ensures the chat room id is always the same for any pair of people
    String chatRoomId = ids.join(
        "_"); // combine the ids into a single string to use as a chatroomID

    /// add new message to database
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  /// GET MESSAGES
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId , ) {
    /// construct chat room id from user ids (sorted to ensure it matches the id used when sending messages
    List<String> ids = [userId, otherUserId] ;
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}