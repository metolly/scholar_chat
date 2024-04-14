import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constant.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/register_screen.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  static String id = 'LoginScreen';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController Email = TextEditingController();

  TextEditingController Password = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey();

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                SizedBox(
                  height: 75,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 75,
                ),
                Row(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  textEditingController: Email,
                  hinttext: 'Email',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  obscureText: true,
                  textEditingController: Password,
                  hinttext: 'password',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'LogIn',
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      isloading = true;
                      setState(() {});
                      try {
                        UserCredential user = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: Email.text, password: Password.text);
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: Email.text);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('sucsess')));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('user-not-found')));
                        } else if (e.code == 'wrong-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('wrong-password')));
                        }
                      } catch (ex) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('there was an error')));
                      }
                      isloading = false;
                      setState(() {});
                    } else {}
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'don\'t have an account ?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: (() {
                        Navigator.pushNamed(context, RegisterScreen.id);
                      }),
                      child: Text(
                        ' Register',
                        style: TextStyle(
                          color: Color(0xffC7EDE6),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
