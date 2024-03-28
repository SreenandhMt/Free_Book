
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'createing/create_books.dart';

class MyPdfToAudioPage extends StatefulWidget {
  const MyPdfToAudioPage({super.key});

  @override
  State<MyPdfToAudioPage> createState() => _MyPdfToAudioPageState();
}

class _MyPdfToAudioPageState extends State<MyPdfToAudioPage> {
  final HiveInterface hive = Hive;
  FlutterTts tts = FlutterTts();
  List<String> text=["emty","Ss"];
  int? startpoint,endpoint;
  String ctext="";

  @override
  void initState() {
    Permission.storage.request();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                 Color.fromARGB(255, 38, 26, 59).withOpacity(0.8),
               const Color.fromARGB(255, 27, 48, 66).withOpacity(0.8),
            ])
            // backgroundBlendMode: BlendMode.multiply,
            ),
          child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(title: const Text("Account"),backgroundColor: Colors.transparent,scrolledUnderElevation: 0,),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 10),
                  child: Text("Publice",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                ),
                LimitedBox(
                  maxHeight: (size.width/2)*1.2,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(10, (index) => ProfilePageCart()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 10),
                  child: Text("Private",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                ),
                LimitedBox(
                  maxHeight: (size.width/2)*1.2,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(10, (index) => ProfilePageCart()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 10),
                  child: Text("Favarate",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                ),
                LimitedBox(
                  maxHeight: (size.width/2)*1.2,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(10, (index) => ProfilePageCart()),
                  ),
                ),
          
              ],
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 55,left: 10),
              child: FloatingActionButton(
                child: Center(child: const Icon(Icons.add),),
                backgroundColor: Colors.black,
                onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ScreenCreatebooks()));
              },),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    tts.stop();
    super.dispose();
  }
}

class ProfilePageCart extends StatelessWidget {
  const ProfilePageCart({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all((size.width/2)*0.03),
          height: (size.width/2)*1,
          width: (size.width/2)*0.6,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black26),
        )
      ],
    );
  }
}