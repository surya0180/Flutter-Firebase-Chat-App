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
          final documents = streamSnapShot.data.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, idx) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[idx]['text']),
            ),
          );
        },
        stream: FirebaseFirestore.instance
            .collection('Chat/40HFqgeO3CaPNpq94mW4/messages')
            .snapshots(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance.collection('Chat/40HFqgeO3CaPNpq94mW4/messages').add({
            'text': 'This was added by clicking the button'
          });
        },
      ),
    );
  }
}
