import 'dart:developer';

import 'package:ebooks_free/core/miniplayer_config.dart';
import 'package:ebooks_free/feature/home/presentaion/home_page.dart';
import 'package:ebooks_free/feature/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';

import 'feature/my_pdf/my_pdf.dart';
import 'feature/play_screen/play_part.dart';

ValueNotifier currentScreen = ValueNotifier(0);
double _currentpos=0.0;
List<Widget> _page = [
  const ScreenHome(),
  const ScreenSearch(),
  const MyPdfToAudioPage(),
];

class BottomNavigationScreenConfig extends StatelessWidget {
  const BottomNavigationScreenConfig({super.key});

  @override
  Widget build(BuildContext context) {
    final size =  MediaQuery.of(context).size;
    return ValueListenableBuilder(
      valueListenable: currentScreen,
      builder: (context,value,_) {
        return Scaffold(
          extendBody: true,
          body: Stack(
            children: [
              _page[currentScreen.value],
              Consumer<MiniplayerProvider>(
                  builder: (context,provider,_) {
                    return Offstage(
                        offstage: !provider.miniPlayerIsRunning,
                        child: Miniplayer(
                          controller: provider.miniPlayerController,
                            minHeight: 150,
                            maxHeight: size.height,
                            builder: (hight, widgrt) {
                              _currentpos = hight;
                              if(!provider.miniPlayerIsRunning)
                              {
                                return const SizedBox();
                              }else{
                                if(hight <= 180)
                                {
                                  log("Ss");
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(color: Color.fromARGB(255, 23, 14, 38),borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                           Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               Padding(
                                                 padding: const EdgeInsets.only(left: 10,bottom: 10),
                                                 child: Image.network(provider.data["url"],width: 70,height: hight-60,fit: BoxFit.fill,),
                                               ),
                                               Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(padding: const EdgeInsets.only(left: 10,top: 5),
                                               child: Text(provider.data["name"],overflow: TextOverflow.clip,maxLines: 1,),
                                               ),
                                               const Padding(padding: EdgeInsets.only(left: 10,bottom: 20),
                                               child: Text("Subtitle",overflow: TextOverflow.clip,maxLines: 1,style: TextStyle(fontSize: 10),),
                                               ),
                                                ],
                                               )
                                             ],
                                           ),
                                           Padding(
                                             padding: const EdgeInsets.only(bottom: 15),
                                             child: Row(
                                               children: [
                                                 IconButton(onPressed: (){}, icon: const Icon(Icons.play_arrow_outlined,size: 30,)),
                                                 IconButton(onPressed: (){
                                                  context.read<MiniplayerProvider>().cloce();
                                                 }, icon: const Icon(Icons.close,size: 30,)),
                                               ],
                                             ),
                                           )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                                }else{
                                  return const ScreenPlayPart();
                                }
                              }
                            }));
                  }
                )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: false,
            showSelectedLabels: false,
            backgroundColor: Color.fromARGB(255, 23, 14, 38),
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.white,
            mouseCursor: MouseCursor.defer,
            useLegacyColorScheme: false,
            items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search),label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined),label: "Account"),
          ],
          type: BottomNavigationBarType.fixed,
          landscapeLayout: BottomNavigationBarLandscapeLayout.values[0],
          currentIndex: currentScreen.value,
          onTap: (value) => currentScreen.value = value,
          elevation: 25,
          ),
        );
      }
    );
  }
}