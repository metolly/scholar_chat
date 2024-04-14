import 'package:flutter/material.dart';
import 'package:scholar_chat/constant.dart';
import 'package:scholar_chat/models/message.dart';

class ChatBubbet extends StatelessWidget {
  ChatBubbet({Key? key, required this.message}) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            color: kPrimaryColor),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ChatBubbetForAFriend extends StatelessWidget {
  ChatBubbetForAFriend({Key? key, required this.message}) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            ),
            color: Color(0xff006D84)),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
