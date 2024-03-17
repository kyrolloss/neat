import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neat/Models/message.dart';

class ChatService extends ChangeNotifier {
  /// get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// SEND MESSAGE
  Future<void> sendMessage(String receiverId, String message) async {
    /// get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    /// create a new message
    Message newMessage = Message(senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    /// construct chat room id from current user id and reciever id (sorted to insure uniqueness)
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // sort the ids (this ensures the chat room id is always the same for any pair of people
    String chatRoomId = ids.join("_"); // combine the ids into a single string to use as a chatroomID


    /// add new message to database

  }

/// GET MESSAGES

}