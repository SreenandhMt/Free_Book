import 'package:ebooks_free/core/auth/auth_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthRoute extends StatefulWidget {
  const AuthRoute({super.key});

  @override
  State<AuthRoute> createState() => _AuthRouteState();
}

class _AuthRouteState extends State<AuthRoute> {
  bool isLoginPage=true;

  void onTap(){
    setState(() {
      isLoginPage=!isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getCurrentData(), builder: (context, snapshot) {
      if(snapshot.hasData)
      {
       return snapshot.data!;
      }else{
        return const CupertinoActivityIndicator();
      }
    },);
  }
  Future<Widget> getCurrentData()async
  {
    await Future.delayed(const Duration(seconds: 1));
    if(isLoginPage)
    {
      return LoginPage(onTap: onTap);
    }else{
      return SignInPage(onTap: onTap);
    }
  }
}