import 'package:flutter/material.dart';

import '../../provider/home_provider.dart';
import '../../widget/book_card.dart';

class PcHomeScreen extends StatelessWidget {
  const PcHomeScreen({
    super.key,
    required this.provider,
  });
  final HomeDataProvider provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15,top: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
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
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.transparent,
              // appBar: AppBar(title: const Text("Free Books"),backgroundColor: Colors.transparent,elevation: 0,scrolledUnderElevation: 0,),
              body: SafeArea(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20,top: 10,bottom: 25),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 10,
                        spacing: 16,
                        children: List.generate(8, (index) => const CircleAvatar(radius: 50,backgroundColor: Colors.black12,child: CircleAvatar(radius: 49,backgroundColor: Colors.black26,),)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                      child: Text("Story - (10)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    ),
                    provider.story!=null?
                    Wrap(
                      // scrollDirection: Axis.horizontal,
                      children:List.generate(provider.story!.length, (index) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: BookCart(book: provider.story![index],),
                      )),
                    ):const SizedBox(),
                    const SizedBox(height: 15,),
                    const Padding(
                      padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                      child: Text("Motivation",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    ),
                    provider.motivational!=null?
                    Wrap(
                      
                      children:List.generate(provider.motivational!.length, (index) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: BookCart(book: provider.motivational![index],),
                      )),
                    ):const SizedBox(),
                    const SizedBox(height: 15,),
                    const Padding(
                      padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                      child: Text("Horror",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    ),
                    provider.horror!=null?
                    Wrap(
                      // scrollDirection: Axis.horizontal,
                      children:List.generate(provider.horror!.length, (index) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: BookCart(book: provider.horror![index],),
                      )),
                    ):const SizedBox(),
                    const SizedBox(height: 15,),
                    const Padding(
                      padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                      child: Text("Comedy - (10)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    ),
                    provider.comady!=null?
                    Wrap(
                      // scrollDirection: Axis.horizontal,
                      children:List.generate(provider.comady!.length, (index) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: BookCart(book: provider.comady![index],),
                      )),
                    ):const SizedBox(),
                    const SizedBox(height: 15,),
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                    //   child: Text("Top 10",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    // ),
                    // Wrap(
                    //   // scrollDirection: Axis.horizontal,
                    //   children:List.generate(10, (index) => const Padding(
                    //     padding: EdgeInsets.all(6.0),
                    //     child: BookCart(),
                    //   )),
                    // ),
                    const SizedBox(height: 15,),
                    const Padding(
                      padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                      child: Text("Classic - (10)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    ),
                    provider.classics!=null?
                    Wrap(
                      // scrollDirection: Axis.horizontal,
                      children:List.generate(provider.classics!.length, (index) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: BookCart(book: provider.classics![index],),
                      )),
                    ):const SizedBox(),
                    const SizedBox(height: 15,),
                    const Padding(
                      padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                      child: Text("General - (10)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    ),
                    provider.general!=null?
                    Wrap(
                      // scrollDirection: Axis.horizontal,
                      children:List.generate(provider.general!.length, (index) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: BookCart(book: provider.general![index],),
                      )),
                    ):const SizedBox(),
                    const SizedBox(height: 15,),
                    const Padding(
                      padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                      child: Text("History - (10)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    ),
                    provider.history!=null?
                    Wrap(
                      // scrollDirection: Axis.horizontal,
                      children:List.generate(provider.history!.length, (index) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: BookCart(book: provider.history![index],),
                      )),
                    ):const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}