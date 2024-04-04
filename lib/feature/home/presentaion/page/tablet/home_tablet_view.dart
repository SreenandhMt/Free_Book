import 'package:flutter/material.dart';

import '../../provider/home_provider.dart';
import '../../widget/book_card.dart';

class TabHomeScreen extends StatelessWidget {
  const TabHomeScreen({
    super.key,
    required this.provider,
  });
  final HomeDataProvider provider;

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
               const Color.fromARGB(255, 38, 26, 59).withOpacity(0.8),
             const Color.fromARGB(255, 27, 48, 66).withOpacity(0.8),
          ])
          // backgroundBlendMode: BlendMode.multiply,
          ),
          child: Scaffold(
            drawer: const Drawer(child: Column(
              children: [
                ListTile(leading: Icon(Icons.home_rounded),title: Text("Home"),),
                ListTile(leading: Icon(Icons.search),title: Text("Search"),),
                ListTile(leading: Icon(Icons.account_circle_outlined),title: Text("Account"),)
              ],
            ),),
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
                const SizedBox(height: 15,),
                const Padding(
                  padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                  child: Text("Story",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                ),
                LimitedBox(
                  maxHeight: size.width * 0.48,
                  maxWidth: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:List.generate(provider.story!.length, (index) => Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: BookCart(book: provider.story![index],),
                    )),
                  ),
                ),
                const SizedBox(height: 15,),
                const Padding(
                  padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                  child: Text("Motivation - (10)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                ),
                LimitedBox(
                  maxHeight: size.width * 0.48,
                  maxWidth: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:List.generate(provider.motivational!.length, (index) => Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: BookCart(book: provider.motivational![index],),
                    )),
                  ),
                ),
                const SizedBox(height: 15,),
                const Padding(
                  padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                  child: Text("Horror",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                ),
                LimitedBox(
                  maxHeight: size.width * 0.48,
                  maxWidth: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:List.generate(provider.horror!.length, (index) => Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: BookCart(book: provider.horror![index],),
                    )),
                  ),
                ),
                const SizedBox(height: 15,),
                const Padding(
                  padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                  child: Text("Comady - (10)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                ),
                LimitedBox(
                  maxHeight: size.width * 0.48,
                  maxWidth: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:List.generate(provider.comady!.length, (index) => Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: BookCart(book: provider.comady![index],),
                    )),
                  ),
                ),
                const SizedBox(height: 15,),
                // const Padding(
                //   padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                //   child: Text("Top 10",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                // ),
                // LimitedBox(
                //   maxHeight: size.width * 0.48,
                //   maxWidth: double.infinity,
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     children:List.generate(10, (index) => const Padding(
                //       padding: EdgeInsets.all(6.0),
                //       child: BookCart(book: provider.comady!.length,),
                //     )),
                //   ),
                // ),
                // const SizedBox(height: 15,),
                const Padding(
                  padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                  child: Text("Classic - (10)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                ),
                LimitedBox(
                  maxHeight: size.width * 0.48,
                  maxWidth: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:List.generate(provider.classics!.length, (index) => Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: BookCart(book: provider.classics![index],),
                    )),
                  ),
                ),
                const SizedBox(height: 15,),
                const Padding(
                  padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                  child: Text("General - (10)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                ),
                LimitedBox(
                  maxHeight: size.width * 0.48,
                  maxWidth: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:List.generate(provider.general!.length, (index) => Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: BookCart(book: provider.general![index],),
                    )),
                  ),
                ),
                const SizedBox(height: 15,),
                const Padding(
                  padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                  child: Text("History - (10)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                ),
                LimitedBox(
                  maxHeight: size.width * 0.48,
                  maxWidth: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:List.generate(provider.history!.length, (index) => Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: BookCart(book: provider.history![index],),
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