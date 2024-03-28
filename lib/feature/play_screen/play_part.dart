import 'dart:developer';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '/core/miniplayer_config.dart';
import 'play_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';

FlutterTts tts = FlutterTts();
  int? endpoint, startpoint, tempend, temstart;
  ScrollController _scroll = ScrollController();
  String? ctext;
  bool isPlaying = true, isPause = false;
  String runingText = text;
  List<double> values = [];
  int CurrentIndex = 1;
  int point = 0;

class ScreenPlayPart extends StatefulWidget {
  const ScreenPlayPart({super.key});

  @override
  State<ScreenPlayPart> createState() => _ScreenPlayPartState();
}

class _ScreenPlayPartState extends State<ScreenPlayPart> with TickerProviderStateMixin{
  late TabController _controller;
  @override
  void initState() {
    _controller = TabController(length: 3,vsync: this);
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
                const Color.fromARGB(255, 38, 26, 59).withOpacity(0.8),
                const Color.fromARGB(255, 27, 48, 66).withOpacity(0.8),
              ])
              // backgroundBlendMode: BlendMode.multiply,
              ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: GestureDetector(
              onTap: () => context
                  .read<MiniplayerProvider>()
                  .miniPlayerController
                  .animateToHeight(state: PanelState.MAX),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 22,
                  right: 22,
                ),
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: size.width * 0.1,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                                onPressed: () => context
                                    .read<MiniplayerProvider>()
                                    .miniPlayerController
                                    .animateToHeight(state: PanelState.MIN),
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_rounded)))
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: size.width * 1.3,
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      "https://m.media-amazon.com/images/I/71eoUH2EngL._AC_UF1000,1000_QL80_.jpg"),
                                  fit: BoxFit.fill)),
                        ),
                        SizedBox(
                          height: size.width * 0.07,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Tha Power Of habits",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontStyle: FontStyle.values[1]),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.add_circle_outline,
                          size: 40,
                          color: Colors.grey[700],
                        )
                      ],
                    ),
                     TabBar(
                      onTap: (value) {
                        setState(() {});
                      },
                          controller: _controller,
                          tabs: const [
                          Tab(text: "Audio",),
                          Tab(text: "Ai Audio",),
                          Tab(text: "More",)
                        ]),
                        LimitedBox(
                               maxHeight: _controller.index==0?size.width*1.8:_controller.index==1?(size.width*1.8):(size.width*0.8),
                               maxWidth: size.width,
                                              child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _controller,
                            children: const[
                            AudioWidgets(),
                            TtsAudio(),
                            MoreScreens(),
                          ]),
                                            ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    tts.stop();
    startpoint = 0;
    endpoint = 0;
    super.dispose();
  }
  
}

class TtsAudio extends StatefulWidget {
  const TtsAudio({super.key});

  @override
  State<TtsAudio> createState() => _TtsAudioState();
}

class _TtsAudioState extends State<TtsAudio> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(
                      height: 20,
                    ),
                    Container(
                        alignment: Alignment.topCenter,
                        padding:
                            const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.grey,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.white),
                          value: tempend!=null?tempend!/text.length:startpoint!=null?startpoint!/text.length:0,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.shuffle)),
                        const Icon(
                          Icons.skip_previous_rounded,
                          size: 40,
                        ),
                        IconButton(
                          onPressed: () {
                            // log("${text.length/tempend!+startpoint!} --");
                            if (!isPlaying) {
                              tts.stop();
                              if (tempend != null) {
                                tempend = endpoint! + tempend!;
                              } else {
                                tempend = endpoint;
                              }
                              runingText =
                                  text.substring(tempend!, text.length);
                              isPause = true;
                              isPlaying = true;
                            } else {
                              play();
                              setState(() {
                                isPause = false;
                              });
                              
                            }
                          },
                          icon: Icon(
                            isPlaying ? Icons.play_arrow_rounded : Icons.pause,
                            size: 40,
                          ),
                        ),
                        const Icon(
                          Icons.skip_next_rounded,
                          size: 40,
                        ),
                        const Icon(Icons.timer_sharp)
                      ],
                    ),
                    const SizedBox(
                      height: 27,
                    ),
                    Container(
                      margin: const EdgeInsets.all(1),
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(5)),
                      child: LimitedBox(
                        maxHeight: size.width * 1.4,
                        maxWidth: size.width * 1,
                        child: ListView(
                          shrinkWrap: true,
                          controller: _scroll,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                        color: Colors.black),
                                    children: [
                                      if (tempend != null)
                                        TextSpan(
                                            text: text.substring(0, tempend)),

                                      // if(tempend!=null)
                                      // TextSpan(
                                      //   text: text.substring(tempend!,startpoint!+tempend!)
                                      // ),

                                      TextSpan(
                                          text: runingText.substring(
                                              0, startpoint)),
                                      if (startpoint != null)
                                        TextSpan(
                                          text: runingText.substring(
                                              startpoint!, endpoint!),
                                          style: const TextStyle(
                                              backgroundColor: Colors.purple,
                                              color: Colors.white),
                                        ),
                                      if (endpoint != null)
                                        TextSpan(
                                          text: runingText.substring(endpoint!),
                                        ),
                                      // if(text!=ctext)
                                      // TextSpan(
                                      //   text: text
                                      // ),
                                    ])),
                            // Text(text,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w300),)
                          ],
                        ),
                      ),
                    ),
      ],
    );
  }

  Future<void> play() async {
    isPlaying = false;
    int currentPoint = 0, tpoint = 0;
    await tts.setLanguage("en-US");
    await tts.setPitch(5.0);
    await tts.setSpeechRate(0.67);
    await tts.setVolume(5);
    _scroll.animateTo(1,
        duration: const Duration(seconds: 1), curve: Curves.easeOut);
    if (tempend != null) {
      tts.speak(text.substring(tempend!, text.length));

      tts.setProgressHandler((text, start, end, word) {
        setState(() {
          startpoint = start;
          endpoint = end;
          ctext = word;
          tpoint = start - tpoint;
          isPause = false;
          log("${(tempend!+startpoint!)}");
          log("${((tempend!+startpoint!) * text.length!)}");
          point = ((tempend!+startpoint!) * text.length!) ~/ text.length;
          log("${Duration(minutes: text.length)}");
          log("${text.length}");
          log(point.toString());
          if(startpoint! >=text.length)
          {
            startpoint=null;
          tempend=null;
          isPause=true;
          isPlaying=true;
          
          }
        });
        if (tpoint > 20) {
          if (tpoint <= _scroll.position.maxScrollExtent) {
            tpoint = 0;
            currentPoint = currentPoint + 3;
            _scroll.animateTo((currentPoint).toDouble(),
                duration: const Duration(seconds: 6), curve: Curves.easeOut);
            setState(() {});
          } else {
            _scroll.animateTo(_scroll.position.maxScrollExtent,
                duration: const Duration(seconds: 6), curve: Curves.easeOut);
            tpoint = 50;
          }
        }
      });

      return;
    }
    
    final d = tts.speak(text);
    tts.setProgressHandler((text, start, end, word) {
      setState(() {
        startpoint = start;
        endpoint = end;

        ctext = word;
        tpoint = start - tpoint;
        point = (startpoint!*text.length) ~/ text.length ;
        if(startpoint! >=text.length)
          {
            startpoint=null;
          tempend=null;
          isPause=true;
          isPlaying=true;
          
          }
      });


      if (tpoint > 20) {
        if (tpoint <= _scroll.position.maxScrollExtent) {
          tpoint = 0;
          currentPoint = currentPoint + 3;
          _scroll.animateTo((currentPoint).toDouble(),
              duration: const Duration(seconds: 6), curve: Curves.easeOut);
          setState(() {});
        } else {
          _scroll.animateTo(_scroll.position.maxScrollExtent,
              duration: const Duration(seconds: 6), curve: Curves.easeOut);
          tpoint = 50;
        }
      }
    });
    // log(d.toString());
    return;
  }
}

class AudioWidgets extends StatelessWidget {
  const AudioWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(
                      height: 20,
                    ),
                    const ProgressBar(progress: Duration(seconds: 1), total: Duration(seconds: 2)),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.shuffle)),
                        const Icon(
                          Icons.skip_previous_rounded,
                          size: 40,
                        ),
                        IconButton(
                          onPressed: () {
                            
                          },
                          icon: Icon(
                            isPlaying ? Icons.play_arrow_rounded : Icons.pause,
                            size: 40,
                          ),
                        ),
                        const Icon(
                          Icons.skip_next_rounded,
                          size: 40,
                        ),
                        const Icon(Icons.timer_sharp)
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                      margin: const EdgeInsets.all(1),
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(5)),
                      child: LimitedBox(
                        maxHeight: size.width * 1.4,
                        maxWidth: size.width * 1,
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Text(text,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w300),)
                          ],
                        ),
                      ),
                    ),
      ],
    );
  }
}

class MoreScreens extends StatelessWidget {
  const MoreScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Wrap(
      children: [
        MoreWidgets(size,"Book View",Icons.menu_book_rounded),
        MoreWidgets(size,"Pdf View",Icons.picture_as_pdf_rounded),
        MoreWidgets(size,"Add Favarate",Icons.favorite_border_sharp),
        MoreWidgets(size,"More",Icons.read_more_rounded)
      ],
    );
  }
  Widget MoreWidgets(Size size,String text,IconData icon)
  {
    return Container(
        margin: EdgeInsets.all(10),
          height: size.width*0.2,
          width: size.width*0.26,
          decoration: BoxDecoration(color: Colors.black26,borderRadius: BorderRadius.circular(10)),
          child: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,color: Colors.grey,size: 30,),
              Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
            ],
          ),),
        );
  }
}
