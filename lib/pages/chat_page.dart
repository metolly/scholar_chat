import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constant.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/widgets/custom_chat_bubble.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  final _controller = ScrollController();
  static String id = 'ChatPage';
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt', descending: true).snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (snapshot.hasData) {
            List<Message> messageList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 50,
                    ),
                    Text(
                      'Chat',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                backgroundColor: kPrimaryColor,
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return messageList[index].id == email
                              ? ChatBubbet(
                                  message: messageList[index],
                                )
                              : ChatBubbetForAFriend(
                                  message: messageList[index]);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (value) {
                        messages.add({
                          'message': value,
                          'createdAt': DateTime.now(),
                          'id': email
                        });
                        controller.clear();
                        _controller.animateTo(0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        hintText: 'Send Message',
                        suffixIcon: Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Text('Loading...');
          }
        });
  }
}
