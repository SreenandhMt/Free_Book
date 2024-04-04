import 'package:ebooks_free/core/auth/auth_route.dart';
import 'package:ebooks_free/feature/my_pdf/presentaion/page/account_page/my_pdf.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

FirebaseAuth _auth =FirebaseAuth.instance;

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: _auth.authStateChanges(), builder: (context, snapshot) {
      if(snapshot.hasData)
      {
        return const MyPdfToAudioPage();
      }else{
        return const AuthRoute();
      }
    },);
  }
}