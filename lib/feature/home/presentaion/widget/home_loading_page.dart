import 'package:ebooks_free/feature/home/presentaion/widget/book_card.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme.dart';

class HomeLoadingScreenMobile extends StatelessWidget {
  const HomeLoadingScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
    body: Stack(
      children: [
        Container(
        decoration: BoxDecoration(
          gradient: theme,
          // backgroundBlendMode: BlendMode.multiply,
          ),
          child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(title: const Text("Free Books"),backgroundColor: Colors.transparent,elevation: 0,scrolledUnderElevation: 0,),
            body: ListView(
          children: const [
            // Padding(
            //   padding: const EdgeInsets.only(left: 20,top: 10,bottom: 25),
            //   child: Wrap(
            //     runSpacing: 10,
            //     spacing: 16,
            //     children: List.generate(8, (index) => CircleAvatar(radius: size.width*0.1,backgroundColor: Colors.black12,child: CircleAvatar(radius: size.width*0.095,backgroundColor: Colors.black26,),)),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
              child: Text("Story",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
            ),
            HomeMobileListWidget(),
            SizedBox(height: 15,),
            Padding(
              padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
              child: Text("Motivation",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
            ),
            HomeMobileListWidget(),
            SizedBox(height: 15,),
            Padding(
              padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
              child: Text("Horror",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
            ),
           HomeMobileListWidget(),
            SizedBox(height: 15,),
            Padding(
              padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
              child: Text("Comady",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
            ),
            HomeMobileListWidget(),
            SizedBox(height: 15,),
            
            Padding(
              padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
              child: Text("Classic",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
            ),
            HomeMobileListWidget(),
            SizedBox(height: 15,),
            Padding(
              padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
              child: Text("General",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
            ),
            HomeMobileListWidget(),
            Padding(
              padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
              child: Text("History",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
            ),
           HomeMobileListWidget(),
            SizedBox(height: 15,),
          ],
            ),
          ),
        ),
      ],
    ),
        );
  }
}

class HomeLoadingScreenDesktop extends StatelessWidget {
  const HomeLoadingScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15,top: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            gradient: theme,
            // backgroundBlendMode: BlendMode.multiply,
            ),
            child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.transparent,
              // appBar: AppBar(title: const Text("Free Books"),backgroundColor: Colors.transparent,elevation: 0,scrolledUnderElevation: 0,),
              body: SafeArea(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: const [
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20,top: 10,bottom: 25),
                    //   child: Wrap(
                    //     alignment: WrapAlignment.center,
                    //     runSpacing: 10,
                    //     spacing: 16,
                    //     children: List.generate(8, (index) => const CircleAvatar(radius: 50,backgroundColor: Colors.black12,child: CircleAvatar(radius: 49,backgroundColor: Colors.black26,),)),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                      child: Text("Story",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    ),
                    HomeDesktopListWidget(),
                    SizedBox(height: 15,),
                    Padding(
                      padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                      child: Text("Motivation",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    ),
                    
                    SizedBox(height: 15,),
                    Padding(
                      padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                      child: Text("Horror",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    ),
                    HomeDesktopListWidget(),
                    SizedBox(height: 15,),
                    Padding(
                      padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                      child: Text("Comedy",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    ),
                    HomeDesktopListWidget(),
                    SizedBox(height: 15,),
                    
                    Padding(
                      padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                      child: Text("Classic",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    ),
                    HomeDesktopListWidget(),
                    SizedBox(height: 15,),
                    Padding(
                      padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                      child: Text("General",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    ),
                    HomeDesktopListWidget(),
                    SizedBox(height: 15,),
                    Padding(
                      padding: EdgeInsets.only(left: 8,top: 10,bottom: 6),
                      child: Text("History",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    ),
                   HomeDesktopListWidget(),
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


class HomeMobileListWidget extends StatelessWidget {
  const HomeMobileListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LimitedBox(
      maxHeight: size.width * 0.48,
      maxWidth: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
            10,
            (index) => const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: BookCartForLoading(),
                )),
      ),
    );
  }
}

class HomeDesktopListWidget extends StatelessWidget {
  const HomeDesktopListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
          10,
          (index) => const Padding(
              padding: EdgeInsets.all(6.0), child: BookCartForLoading())),
    );
  }
}