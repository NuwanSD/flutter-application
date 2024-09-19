import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FogotPasswordPage extends StatefulWidget {
  const FogotPasswordPage({super.key});

  @override
  State<FogotPasswordPage> createState() => _FogotPasswordPageState();
}

class _FogotPasswordPageState extends State<FogotPasswordPage> {

    final _emailController=TextEditingController();

    @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text('Password Reset Link Sent! Check Your email'),
        );
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text('Enter Your Email and We will send you a password reset link',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
          ),
        ),

            SizedBox(height: 10),
            // Email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                      ),
                    ),

                  ),
                ),

                SizedBox(height: 10),
                MaterialButton(onPressed: passwordReset,
                color: Colors.deepPurple[200],
                child: Text('Reset Password'),
                )
      ],),
    );
  }
}