import 'package:flutter/material.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/login_screen.dart';
import 'package:scholar_chat/pages/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ChatPage.id: (context) => ChatPage(),
      },
      initialRoute: LoginPage.id,
    );
  }
}
