
import 'package:fivec_notes/main.dart';
import 'package:fivec_notes/screens/home_screen.dart';
import 'package:flutter/material.dart';

/// creates instance of an email verification page.
class EmailVerificationScreen extends StatefulWidget {
  // override createState method by making it instantiate an 
  // _Email VerificationState instance.
  @override
  State<EmailVerificationScreen> createState() => EmailVerificationState();
}

/// Creates the email verification page layout/features
class EmailVerificationState extends State<EmailVerificationScreen> {

  // Instantiate text editing controller for the email verification text box. 
  TextEditingController verificationController = TextEditingController();

  /// Creates the structure/layout fo the Email verification page.
  /// It should create a text box that will take the verification code.
  /// as input.
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Enter the 6-digit code sent to your email address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 15.0),
              child: TextField(
                key: const Key("enter code field"),
                controller: verificationController,
                decoration: const InputDecoration(labelText: 'Enter the 6-digit code'),
              ),
            ),
            const SizedBox(height: 16.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      color: Theme.of(context).appColors.backgroundDefault,
                      ),
                    ),
                TextButton(
                  key: const Key("verify code button"),
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                      foregroundColor: Theme.of(context).appColors.backgroundRow,
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20)
                      ),
                onPressed: () {
                  // Add signup logic here
                  String code = verificationController.text;
                  String correctCode = "123"; // dummy value, will change later
                  if (code == correctCode) { 
                    Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName("/home"));
                    // Implement signup logic here
                  } else {
                    // Passwords don't match, show an error message
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        key: const Key("incorrect code entered"),
                        title: const Text('Error'),
                        content: const Text('Code is incorrect'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
              child: const Text('Sign Up'),
            ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }

  /// Removes controller for each verification code text box.
  @override
  void dispose() {   
    verificationController.dispose();
    super.dispose();
  }
  
}