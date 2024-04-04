import 'dart:developer';

import 'package:ebooks_free/core/auth/auth_gate.dart';
import 'package:ebooks_free/core/miniplayer_config.dart';
import 'package:ebooks_free/feature/search/presentaion/page/search_page.dart';
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';

import 'feature/home/presentaion/page/home_page.dart';
import 'feature/play_screen/play_part.dart';

ValueNotifier currentScreen = ValueNotifier(0);
double currentpos=0.0;
List<Widget> _page = [
  const ScreenHome(),
  const ScreenSearch(),
  const AuthGate()
];

class BottomNavigationScreenConfig extends StatelessWidget {
  const BottomNavigationScreenConfig({super.key});

  @override
  Widget build(BuildContext context) {
    final size =  MediaQuery.of(context).size;
    if(size.width<=600)
    {
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
                              currentpos = hight;
                              if(!provider.miniPlayerIsRunning)
                              {
                                return const SizedBox();
                              }else{
                                if(hight <= 180)
                                {
                                  log("Ss");
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    decoration: const BoxDecoration(color: Color.fromARGB(255, 23, 14, 38),borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
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
                                                 child: Image.network(provider.bookUrl,width: 70,height: hight-60,fit: BoxFit.fill,),
                                               ),
                                               Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(padding: const EdgeInsets.only(left: 10,top: 5),
                                               child: Text(provider.bookname,overflow: TextOverflow.clip,maxLines: 1,),
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
                                  if(provider.audioUrl==null)
                                  {
                                    return  const ScreenPlayPart(isHaveAudio: false,);
                                  }
                                  if(provider.audioUrl!.isEmpty)
                                  {
                                    return  const ScreenPlayPart(isHaveAudio: false,);
                                  }else{
                                    return  const ScreenPlayPart(isHaveAudio: true,);
                                  }
                                  
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
            backgroundColor: const Color.fromARGB(255, 23, 14, 38),
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
    }else if(size.width>=600)
    {
      return ValueListenableBuilder(
      valueListenable: currentScreen,
      builder: (context,value,_) {
        return Scaffold(
          // drawer:Drawer(),
          // appBar: AppBar(backgroundColor: Colors.transparent,),
          extendBody: true,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,child: Padding(
                padding: EdgeInsets.only(left: 10,top: 5),
                child: Text("Free Books"),
              ),),
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      // backgroundColor: Colors.transparent,
                      width: 90,
                      // elevation: 0,
                      // shadowColor: Colors.transparent,
                      // shape: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero)
                      // ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
                            decoration: BoxDecoration(color: Colors.black38,borderRadius: BorderRadius.circular(10)),
                            width: 80,height: 200,child: Column(
                            children: [
                              const SizedBox(height: 20,),
                              IconButton(onPressed: ()=>currentScreen.value=0,icon: const Icon(Icons.home_rounded)),
                              const SizedBox(height: 20,),
                              IconButton(onPressed: ()=>currentScreen.value=1,icon: const Icon(Icons.search_rounded)),
                              const SizedBox(height: 20,),
                              IconButton(onPressed: ()=>currentScreen.value=2,icon: const Icon(Icons.add)),
                            ],
                          ),),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 8,right: 8),
                              decoration: BoxDecoration(color: Colors.black38,borderRadius: BorderRadius.circular(10)),
                              width: 80,child: const Column(
                              children: [
                                
                              ],
                            ),),
                          )
                        ],
                      ),
                    ),
                    Expanded(child: _page[currentScreen.value]),
                    Draggable(
                      rootOverlay: true,
                       feedback: Container(width: 5,height: 700,color: Colors.transparent,),onDraggableCanceled: (velocity, offset) {},onDragUpdate: (details) {
                      if(playWidgetWidth.value<=400)
                      {
                        if(details.delta.dx<0)
                      {
                        playWidgetWidth.value=playWidgetWidth.value+details.delta.distance;
                      }
                      }
                      else if(playWidgetWidth.value<=700)
                      {
                        
                        if(details.delta.dx>0)
                      {
                        playWidgetWidth.value=playWidgetWidth.value-details.delta.distance;
                      }else{
                        playWidgetWidth.value=playWidgetWidth.value+details.delta.distance;
                      }
                      }
                      else{
                        if(details.delta.dx>0)
                      {
                        playWidgetWidth.value=playWidgetWidth.value-details.delta.distance;
                      }
                      }
                      
                    },
                    child: Container(width: 10,height: 700,color: Colors.transparent,),
                    ),
                    // const SizedBox(width: 4,),
                    Consumer<MiniplayerProvider>(
                    builder: (context,provider,_) {
                      if (provider.miniPlayerIsRunning) {
                            if (provider.audioUrl == null) {
                              return Offstage(
                                  offstage: !provider.miniPlayerIsRunning,
                                child: const ScreenPlayPart(
                                  isHaveAudio: false,
                                ),
                              );
                            }
                            if (provider.audioUrl!.isEmpty) {
                              return Offstage(
                                  offstage: !provider.miniPlayerIsRunning,
                                child: const ScreenPlayPart(
                                  isHaveAudio: false,
                                ),);
                            } else {
                              return Offstage(
                                  offstage: !provider.miniPlayerIsRunning,
                                  child: const ScreenPlayPart(
                                isHaveAudio: true,
                              ));
                            }
                          }else{
                            return const SizedBox();
                          }
                      }),
                      const SizedBox(width: 3,),
                  ],
                ),
              ),
              const SizedBox(height: 6,),
              // Consumer<MiniplayerProvider>(
              //     builder: (context,provider,_) {
              //       return Offstage(
              //           offstage: !provider.miniPlayerIsRunning,
              //           child: Miniplayer(
              //             controller: provider.miniPlayerController,
              //               minHeight: 150,
              //               maxHeight: size.height,
              //               builder: (hight, widgrt) {
              //                 _currentpos = hight;
              //                 if(!provider.miniPlayerIsRunning)
              //                 {
              //                   return const SizedBox();
              //                 }else{
              //                   if(hight <= 180)
              //                   {
              //                     log("Ss");
              //                     return Container(
              //                       margin: const EdgeInsets.only(bottom: 20),
              //                       decoration: const BoxDecoration(color: Color.fromARGB(255, 23, 14, 38),borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
              //                     child: Column(
              //                       children: [
              //                         const SizedBox(height: 10,),
              //                         Row(
              //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                           children: [
              //                              Row(
              //                               mainAxisAlignment: MainAxisAlignment.start,
              //                                children: [
              //                                  Padding(
              //                                    padding: const EdgeInsets.only(left: 10,bottom: 10),
              //                                    child: Image.network(provider.bookUrl,width: 70,height: hight-60,fit: BoxFit.fill,),
              //                                  ),
              //                                  Column(
              //                                   crossAxisAlignment: CrossAxisAlignment.start,
              //                                   children: [
              //                                     Padding(padding: const EdgeInsets.only(left: 10,top: 5),
              //                                  child: Text(provider.bookname,overflow: TextOverflow.clip,maxLines: 1,),
              //                                  ),
              //                                  const Padding(padding: EdgeInsets.only(left: 10,bottom: 20),
              //                                  child: Text("Subtitle",overflow: TextOverflow.clip,maxLines: 1,style: TextStyle(fontSize: 10),),
              //                                  ),
              //                                   ],
              //                                  )
              //                                ],
              //                              ),
              //                              Padding(
              //                                padding: const EdgeInsets.only(bottom: 15),
              //                                child: Row(
              //                                  children: [
              //                                    IconButton(onPressed: (){}, icon: const Icon(Icons.play_arrow_outlined,size: 30,)),
              //                                    IconButton(onPressed: (){
              //                                     context.read<MiniplayerProvider>().cloce();
              //                                    }, icon: const Icon(Icons.close,size: 30,)),
              //                                  ],
              //                                ),
              //                              )
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   );
              //                   }
              //                   else{
              //                     if(provider.audioUrl==null)
              //                     {
              //                       return  ScreenPlayPart(isHaveAudio: false,);
              //                     }
              //                     if(provider.audioUrl!.isEmpty)
              //                     {
              //                       return  ScreenPlayPart(isHaveAudio: false,);
              //                     }else{
              //                       return  ScreenPlayPart(isHaveAudio: true,);
              //                     }
              //                   }
              //                 }
              //               }));
              //     }
              //   )
            ],
          ),
          
        );
      }
    );
    }else{
      return const SizedBox();
    }
  }
}