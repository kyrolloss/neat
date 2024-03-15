import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageCountWidget extends StatefulWidget {
  final Stream<QuerySnapshot> taskStreamStream;

  const MessageCountWidget({required this.taskStreamStream});

  @override
  State<MessageCountWidget> createState() => _MessageCountWidgetState();
}

class _MessageCountWidgetState extends State<MessageCountWidget> {
  int _messageCount = 0;

  @override
  void initState() {
    super.initState();
    widget.taskStreamStream.listen((snapshot) {
      setState(() {
        _messageCount = snapshot.docs.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_messageCount Messages',
      style: TextStyle(fontSize: 16.0),
    );
  }
}