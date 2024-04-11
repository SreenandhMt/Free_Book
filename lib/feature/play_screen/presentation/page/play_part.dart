
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:ebooks_free/core/theme.dart';
import 'package:ebooks_free/feature/play_screen/presentation/page/book_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '/core/miniplayer_config.dart';

FlutterTts tts = FlutterTts();
int? endpoint, startpoint, tempend, temstart;
ScrollController _scroll = ScrollController();
bool? isPlaying ;
List<double> values = [];
int point = 0;

ValueNotifier playWidgetWidth= ValueNotifier(400);

class ScreenPlayPart extends StatefulWidget {
  const ScreenPlayPart({
    super.key,
    required this.isHaveAudio,
  });
  final bool isHaveAudio;

  @override
  State<ScreenPlayPart> createState() => _ScreenPlayPartState();
}

class _ScreenPlayPartState extends State<ScreenPlayPart>
    with TickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    if(widget.isHaveAudio)
    {
      _controller = TabController(length: 3, vsync: this);
    }else{
      _controller = TabController(length: 2, vsync: this);
    }
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<MiniplayerProvider>(
      builder: (context, state,_) {
        if(size.width<=600)
        {
          return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: theme
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
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: NetworkImage(state.bookUrl),
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
                                  state.bookname,
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
                            tabs: [
                              if (state.audioUrl != null)
                                const Tab(
                                  text: "Audio",
                                ),
                              const Tab(
                                text: "Ai Audio",
                              ),
                              const Tab(
                                text: "More",
                              )
                            ]),
                        LimitedBox(
                          maxHeight: _controller.index == 0
                              ? size.width * 1.8
                              : _controller.index == 1
                                  ? (size.width * 1.8)
                                  : (size.width * 0.8),
                          maxWidth: size.width,
                          child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _controller,
                              children: [
                                if (state.audioUrl != null)
                                  AudioWidgets(
                                    audioUrl: state.audioUrl!,
                                    text: state.text,
                                  ),
                                TtsAudio(text: state.text,),
                                MoreScreens(pdfurl: state.pdfUrl,),
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
        }else{
          return ValueListenableBuilder(
            valueListenable: playWidgetWidth,
            builder: (context,value,_) {
              return Stack(
              children: [
                Container(
                  width: playWidgetWidth.value,
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
                    backgroundColor: Colors.transparent,
                    body: ListView(
                      children: [
                        GestureDetector(
                          onTap: () => context
                              .read<MiniplayerProvider>()
                              .miniPlayerController
                              .animateToHeight(state: PanelState.MAX),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 22,
                              right: 22,
                            ),
                            child: Column(
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
                                                .clear(),
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down_rounded)))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 440,
                                      width: 300,
                                      decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius: BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: NetworkImage(state.bookUrl),
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
                                          state.bookname,
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
                                    tabs: [
                                      if (state.audioUrl != null)
                                        const Tab(
                                          text: "Audio",
                                        ),
                                      const Tab(
                                        text: "Ai Audio",
                                      ),
                                      const Tab(
                                        text: "More",
                                      )
                                    ]),
                                LimitedBox(
                                  maxHeight: _controller.index == 0
                                      ? size.width * 1.6
                                      : _controller.index == 1
                                          ? (size.width * 1.6)
                                          : (size.width * 0.1),
                                  maxWidth: size.width,
                                  child: TabBarView(
                                      physics: const NeverScrollableScrollPhysics(),
                                      controller: _controller,
                                      children: [
                                        if (state.audioUrl != null)
                                          AudioWidgets(
                                            audioUrl: state.audioUrl!,
                                            text: state.text,
                                          ),
                                        TtsAudio(text: state.text,),
                                        MoreScreens(pdfurl: state.pdfUrl,),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
                      );
            }
          );
        }
      },
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

// add data
class TtsAudio extends StatefulWidget {
  const TtsAudio({
    super.key,
    required this.text,
  });
  final String text;

  @override
  State<TtsAudio> createState() => _TtsAudioState();
}

class _TtsAudioState extends State<TtsAudio> {
  late String runingText;
  @override
  void initState() {
    
    super.initState();
  }
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
            padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              value: tempend != null
                  ? tempend! / widget.text.length
                  : startpoint != null
                      ? startpoint! / widget.text.length
                      : 0,
            )),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.shuffle)),
            const Icon(
              Icons.skip_previous_rounded,
              size: 40,
            ),
            IconButton(
              onPressed: () {
                if(isPlaying==null)
                {
                  play();
                  setState(() {
                    isPlaying = true;
                  });
                }
                // log("${text.length/tempend!+startpoint!} --");
                else if (!isPlaying!) {
                  play();
                  setState(() {
                    isPlaying = true;
                  });
                } else {
                  tts.stop();
                  setState(() {
                    isPlaying = false;
                  });
                }
              },
              icon: Icon(
                isPlaying==null||!isPlaying! ? Icons.play_arrow_rounded : Icons.pause,
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
              color: Colors.grey[400], borderRadius: BorderRadius.circular(5)),
          child: LimitedBox(
            maxHeight: size.width * 1.4,
            maxWidth: size.width * 1,
            child: ListView(
              shrinkWrap: true,
              controller: _scroll,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Text.rich(
                TextSpan(
                        style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                            color: Colors.black),
                        children: [
                          TextSpan(text: widget.text),
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
    await tts.setLanguage("en-IN");
    await tts.setPitch(5.0);
    await tts.setSpeechRate(0.67);
    await tts.setVolume(5);
    tts.speak(widget.text);
    tts.setCompletionHandler(() {
      isPlaying=null;
      _scroll.animateTo(1,
        duration: const Duration(seconds: 1), curve: Curves.easeOut);
    });
  }
}
// if (tempend != null) {
//       await tts.speak(widget.text.substring(tempend!, widget.text.length));
//       log("mmm oumbi");
//       tts.setProgressHandler((text, start, end, word) {
//         log("dddd");
//           startpoint = start;
//           endpoint = end;
//           tpoint = start - tpoint;
//           isPause = false;
//           point = ((tempend! + startpoint!) * widget.text.length) ~/ widget.text.length;

//           if (end >= widget.text.length) {
//             startpoint = null;
//             tempend = null;
//             isPause = true;
//             isPlaying = true;
//           }
//         log("sss -1");
//         setState(() {
          
//         });
//         if (tpoint > 20) {
//           if (tpoint <= _scroll.position.maxScrollExtent) {
//             tpoint = 0;
//             currentPoint = currentPoint + 3;
//             _scroll.animateTo((currentPoint).toDouble(),
//                 duration: const Duration(seconds: 6), curve: Curves.easeOut);
//             setState(() {});
//           } else {
//             _scroll.animateTo(_scroll.position.maxScrollExtent,
//                 duration: const Duration(seconds: 6), curve: Curves.easeOut);
//             setState(() {});
//             tpoint = 50;
//           }
//         }
//       });

//       return;
//     }

//     await tts.speak(widget.text);
//     log("mm -1");
//     tts.setProgressHandler((text, start, end, word) {
//         startpoint = start;
//         endpoint = end;
//         log("dddd -1");
//         tpoint = start - tpoint;
//         point = (startpoint! * widget.text.length) ~/ widget.text.length;
//         if (startpoint! >= widget.text.length) {
//           startpoint = null;
//           tempend = null;
//           isPause = true;
//           isPlaying = true;
//         }
//     setState(() {});
//     log("sss -1");
//       if (tpoint > 20) {
//         if (tpoint <= _scroll.position.maxScrollExtent) {
//           tpoint = 0;
//           currentPoint = currentPoint + 3;
//           _scroll.animateTo((currentPoint).toDouble(),
//               duration: const Duration(seconds: 6), curve: Curves.easeOut);
//           setState(() {});
//         } else {
//           _scroll.animateTo(_scroll.position.maxScrollExtent,
//               duration: const Duration(seconds: 6), curve: Curves.easeOut);
//           tpoint = 50;
//         }
//       }
//     });
//     log("ggg -1");
//     // log(d.toString());
//     return;
bool audioPlay=false;

class AudioWidgets extends StatefulWidget {
  const AudioWidgets({
    super.key,
    required this.audioUrl,
    required this.text,
  });
  final String audioUrl;
  final String text;

  @override
  State<AudioWidgets> createState() => _AudioWidgetsState();
}

class _AudioWidgetsState extends State<AudioWidgets> {
  AudioPlayer audioPlayer =AudioPlayer();
  Duration position=Duration.zero;

  Stream<PositionData> get _position => Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(audioPlayer.positionStream,audioPlayer.bufferedPositionStream,audioPlayer.durationStream,(position,bufferedPosition,duration)=>PositionData(position, bufferedPosition, duration??Duration.zero));

  @override
  void initState() {
    audioPlayer.setUrl(widget.audioUrl);
    audioPlayer.pause();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        StreamBuilder(
          stream: _position,
          builder: (context, snapshot){
            final position = snapshot.data;
            if(position!=null)
            {
              return ProgressBar(
              
              onSeek: (value) => audioPlayer.seek(value),
                progress:position.position,buffered: position.bufferedPosition, total: position.duration);
            }else{
              return const ProgressBar(progress: Duration.zero, total: Duration.zero);
            }
          }
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.shuffle)),
            const Icon(
              Icons.skip_previous_rounded,
              size: 40,
            ),
            IconButton(
              onPressed: () {
                if(!audioPlay)
                {
                 audioPlayer.play(); 
                 audioPlay=true;
                 setState((){});
                }else{
                  audioPlay=false;
                  audioPlayer.pause();
                  setState((){});
                }
                
              },
              icon: Icon(
                !audioPlay ? Icons.play_arrow_rounded : Icons.pause,
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
              color: Colors.grey[400], borderRadius: BorderRadius.circular(5)),
          child: LimitedBox(
            maxHeight: size.width * 1.4,
            maxWidth: size.width * 1,
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Text(
                  widget.text,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}



class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

class MoreScreens extends StatelessWidget {
  const MoreScreens({super.key,required this.pdfurl});
  final String pdfurl;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Wrap(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookView(url: pdfurl,),)),
          child: moreWidgets(size, "Book View", Icons.menu_book_rounded)),
        moreWidgets(size, "Pdf View", Icons.picture_as_pdf_rounded),
        moreWidgets(size, "Add Favarate", Icons.favorite_border_sharp),
        moreWidgets(size, "More", Icons.read_more_rounded)
      ],
    );
  }

  Widget moreWidgets(Size size, String text, IconData icon) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: size.width * 0.2,
      width: size.width * 0.26,
      decoration: BoxDecoration(
          color: Colors.black26, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.grey,
              size: 30,
            ),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
