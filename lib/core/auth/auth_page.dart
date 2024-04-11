import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

TextEditingController _loginPass = TextEditingController();
TextEditingController _loginEmail = TextEditingController();
TextEditingController _signInPass = TextEditingController();
// TextEditingController _signInConfomPass = TextEditingController();
TextEditingController _signInEmail = TextEditingController();

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.onTap,
  });
  final void Function()? onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                  const Color.fromARGB(255, 38, 26, 59).withOpacity(0.8),
                  const Color.fromARGB(255, 27, 48, 66).withOpacity(0.8),
                ])
                // backgroundBlendMode: BlendMode.multiply,
                ),
          child: Form(
            key: _form,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock_outline_rounded,size: 50,),
                    const SizedBox(height: 40,),
                    TextFormField(
                      controller: _loginEmail,
                      validator: (value) {
                        if(value!.isEmpty)
                        {
                          return "Enter a email";
                        }else if(!value.contains("@"))
                        {
                          return "invalid email";
                        }else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),hintText: "Email"),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: _loginPass,
                      validator: (value) {
                        if(value!.isEmpty)
                        {
                          return "Enter a Password";
                        }else if(value.length<=6){
                          return "Password Minimum 6 Characters";
                        }else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),hintText: "Password"),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("your not a member,"),
                        const SizedBox(width: 4,),
                        GestureDetector(onTap: widget.onTap,child: const Text("SignIn")),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    GestureDetector(onTap: ()async{
                        try {
                          _form.currentState!.validate();
                          if(_loginPass.text.length < 6 )
                      {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter a minimum 6 cherachtor in password")));
                      }
                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: _loginEmail.text, password: _loginPass.text);
                        } on FirebaseException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
                        }
                    },child: Container(height: 60,decoration: BoxDecoration(color: Colors.black26,borderRadius: BorderRadius.circular(10)),child: const Center(child: Text("Sign In"),)),)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({
    super.key,
    required this.onTap,
  });
  final void Function() onTap;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                  const Color.fromARGB(255, 38, 26, 59).withOpacity(0.8),
                  const Color.fromARGB(255, 27, 48, 66).withOpacity(0.8),
                ])
                // backgroundBlendMode: BlendMode.multiply,
                ),
          child: Form(
            key: _form,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock_outline_rounded,size: 50,),
                    const SizedBox(height: 30,),
                    TextFormField(
                      controller: _signInEmail,
                      validator: (value) {
                        if(value!.isEmpty)
                          {
                            return "Enter a email";
                          }else if(!value.contains("@"))
                          {
                            return "invalid email";
                          }else{
                            return null;
                          }
                      },
                      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),hintText: "Email"),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: _signInPass,
                      validator: (value) {
                          if(value!.isEmpty)
                          {
                            return "Enter a Password";
                          }else if(value.length<=6){
                            return "Password Minimum 6 Characters";
                          }else{
                            return null;
                          }
                        },
                      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),hintText: "Password"),
                    ),
                    
                    
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("your alrady a member,"),
                        const SizedBox(width: 4,),
                        GestureDetector(onTap: widget.onTap,child: const Text("Login")),
                      ],
                    ),
                    const SizedBox(height: 25,),
                    GestureDetector(onTap: ()async{
                      _form.currentState!.validate();
                      if(_signInPass.text.length < 6 )
                      {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter a minimum 6 cherachtor in password")));
                      }
                      else{
                        try {
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _signInEmail.text, password: _signInPass.text);
                        } on FirebaseException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!),backgroundColor: Colors.red,
                  
                  ));
                        }
                      }
                    },child: Container(height: 60,decoration: BoxDecoration(color: Colors.black26,borderRadius: BorderRadius.circular(10)),child: const Center(child: Text("Sign In"),)))
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
