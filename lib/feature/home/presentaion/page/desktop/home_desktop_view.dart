import 'package:ebooks_free/feature/home/presentaion/widget/desktop_widget/category.dart';
import 'package:ebooks_free/feature/home/presentaion/widget/home_loading_page.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme.dart';
import '../../provider/home_provider.dart';

class PcHomeScreen extends StatelessWidget {
  const PcHomeScreen({
    super.key,
    required this.provider,
  });
  final HomeDataProvider provider;

  @override
  Widget build(BuildContext context) {
    if(provider.isLoding)
    {
      return const HomeLoadingScreenDesktop();
    }
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

              body: SafeArea(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20,top: 10,bottom: 25),
                    //   child: Wrap(
                    //     alignment: WrapAlignment.center,
                    //     runSpacing: 10,
                    //     spacing: 16,
                    //     children: List.generate(8, (index) => const CircleAvatar(radius: 50,backgroundColor: Colors.black12,child: CircleAvatar(radius: 49,backgroundColor: Colors.black26,),)),
                    //   ),
                    // ),
                    const SizedBox(height: 15,),
                    
                    //story
                    if(provider.story!=null)
                    CategoryForDesktop(content: provider.story!, title: "Story"),
                    const SizedBox(height: 15,),

                    // motivation
                    if(provider.motivational!=null)
                    CategoryForDesktop(content: provider.motivational!, title: "Motivation"),
                    const SizedBox(height: 15,),

                    // horror
                    if(provider.horror!=null)
                    CategoryForDesktop(content: provider.horror!, title: "Horror"),
                    const SizedBox(height: 15,),
                    
                    //comedy
                    if(provider.comady!=null)
                    CategoryForDesktop(content: provider.comady!, title: "Comedy"),
                    const SizedBox(height: 15,),

                    //classic
                    if(provider.classics!=null)
                    CategoryForDesktop(content: provider.classics!, title: "Classic"),
                    const SizedBox(height: 15,),

                    //general
                    if(provider.general!=null)
                    CategoryForDesktop(content: provider.general!, title: "General"),
                    const SizedBox(height: 15,),

                    //history
                    if(provider.history!=null)
                    CategoryForDesktop(content: provider.history!, title: "History"),
                    const SizedBox(height: 15,),
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