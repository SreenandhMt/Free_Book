import 'package:ebooks_free/core/theme.dart';
import 'package:ebooks_free/feature/home/presentaion/widget/home_loading_page.dart';
import 'package:flutter/material.dart';

import '../../provider/home_provider.dart';
// import '../../widget/book_card.dart';
import '../../widget/mobile_widgets/category.dart';

class TabHomeScreen extends StatelessWidget {
  const TabHomeScreen({
    super.key,
    required this.provider,
  });
  final HomeDataProvider provider;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    if(provider.isLoding)
    {
      return const HomeLoadingScreenMobile();
    }
    return Scaffold(
    body: Stack(
      children: [
        Container(
        decoration: BoxDecoration(
          gradient: theme,
          // backgroundBlendMode: BlendMode.multiply,
          ),
          child: Scaffold(
            drawer: const Drawer(child: Column(
              children: [
                Center(child: Text("Free Books"),),
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
                // Padding(
                //   padding: const EdgeInsets.only(left: 20,top: 10,bottom: 25),
                //   child: Wrap(
                //     runSpacing: 10,
                //     spacing: 16,
                //     children: List.generate(8, (index) => CircleAvatar(radius: size.width*0.1,backgroundColor: Colors.black12,child: CircleAvatar(radius: size.width*0.095,backgroundColor: Colors.black26,),)),
                //   ),
                // ),
                
            // story
            if(provider.story!=null)
            CategoryForMobile(content: provider.story!, title: "Story"),
            const SizedBox(height: 15,),

            //motivation
            if(provider.motivational!=null)
            CategoryForMobile(content: provider.motivational!, title: "Motivational"),
            const SizedBox(height: 15,),

            // Horror
            if(provider.horror!=null)
            CategoryForMobile(content: provider.horror!, title: "Horror"),
            const SizedBox(height: 15,),

            // comedy
            if(provider.comady!=null)
            CategoryForMobile(content: provider.comady!, title: "Comedy"),
            const SizedBox(height: 15,),
            
            // classic
            if(provider.classics!=null)
            CategoryForMobile(content: provider.classics!, title: "Classic"),
            const SizedBox(height: 15,),

            // general
            if(provider.general!=null)
            CategoryForMobile(content: provider.general!, title: "General"),
            const SizedBox(height: 15,),

            //History
            if(provider.history!=null)
            CategoryForMobile(content: provider.history!, title: "History"),
            const SizedBox(height: 15,),
              ],
            ),
          ),
        ),
      ],
    ),
        );
  }
}