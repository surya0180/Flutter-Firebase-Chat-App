import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  bool getIsMyUid(String uid) {
    final myuid = FirebaseAuth.instance.currentUser.uid;
    return uid == myuid;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapShot) {
        if (chatSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapShot.data.docs;
        return ListView.builder(
          reverse: true,
          itemBuilder: (ctx, idx) => MessageBubble(
            chatDocs[idx]['text'],
            getIsMyUid(chatDocs[idx]['userId']),
            chatDocs[idx]['username'],
            key: ValueKey(chatDocs[idx].id),
          ),
          itemCount: chatDocs.length,
        );
      },
    );
  }
}
