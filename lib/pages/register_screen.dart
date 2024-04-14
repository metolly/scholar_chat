import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constant.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/login_screen.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);
  static String id = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                      'Register',
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
                  textEditingController: Password,
                  hinttext: 'password',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'Register',
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      isloading = true;
                      setState(() {});
                      try {
                        UserCredential user = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: Email.text, password: Password.text);
                        Navigator.pushNamed(context, ChatPage.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Weak Password',
                              ),
                            ),
                          );
                        } else if (e.code == 'email-already-in-use') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'email-already-in-use',
                              ),
                            ),
                          );
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
                      'aleady have an account ?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        ' LogIn',
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
