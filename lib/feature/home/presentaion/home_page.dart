import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../play_screen/play_page.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
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
              appBar: AppBar(title: const Text("Free Books"),backgroundColor: Colors.transparent,elevation: 0,scrolledUnderElevation: 0,),
              body: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 10,bottom: 25),
                    child: Wrap(
                      runSpacing: 10,
                      spacing: 16,
                      children: List.generate(8, (index) => CircleAvatar(radius: size.width*0.1,backgroundColor: Colors.black12,child: CircleAvatar(radius: size.width*0.095,backgroundColor: Colors.black26,),)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8,top: 10,bottom: 6),
                    child: Text("Motivation - (10)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                  ),
                  LimitedBox(
                    maxHeight: size.width * 0.48,
                    maxWidth: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:List.generate(10, (index) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: BookCart(),
                      )),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8,top: 10,bottom: 6),
                    child: Text("Comady - (10)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                  ),
                  LimitedBox(
                    maxHeight: size.width * 0.48,
                    maxWidth: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:List.generate(10, (index) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: BookCart(),
                      )),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8,top: 10,bottom: 6),
                    child: Text("Top 10",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                  ),
                  LimitedBox(
                    maxHeight: size.width * 0.48,
                    maxWidth: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:List.generate(10, (index) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: BookCart(),
                      )),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8,top: 10,bottom: 6),
                    child: Text("comics - (10)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                  ),
                  LimitedBox(
                    maxHeight: size.width * 0.48,
                    maxWidth: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:List.generate(10, (index) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: BookCart(),
                      )),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8,top: 10,bottom: 6),
                    child: Text("General Knowlage - (10)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                  ),
                  LimitedBox(
                    maxHeight: size.width * 0.48,
                    maxWidth: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:List.generate(10, (index) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: BookCart(),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookCart extends StatelessWidget {
  const BookCart({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ScreenPlay(
          eBook: ["heeee njan annne a", "ddddddddddd", "mmmmmmmmmm"]))),
          child: Container(
            width: size.width * 0.31,
            height: size.width * 0.43,
            decoration: BoxDecoration(
              color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://m.media-amazon.com/images/I/71eoUH2EngL._AC_UF1000,1000_QL80_.jpg"),
                    fit: BoxFit.cover)
                    ),
          ),
        ),
      ],
    );
  }
}