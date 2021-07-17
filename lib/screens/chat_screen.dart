import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Here'),
      ),
      body: StreamBuilder(
        builder: (ctx, streamSnapShot) {
          if(streamSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: streamSnapShot.data.docs.length,
            itemBuilder: (ctx, idx) => Container(
              padding: EdgeInsets.all(8),
              child: Text('This Works'),
            ),
          );
        },
        stream: FirebaseFirestore.instance
            .collection('Chat/zfT2ApG2Y5WBm3OftcXm/messages')
            .snapshots(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
