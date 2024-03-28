
import 'package:ebooks_free/core/miniplayer_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';

final text = "There's never been a better time to set new habits. This book will change your life. In The Power of Habit, award-winning journalist Charles Duhigg takes us into the thrilling and surprising world of the scientific study of habits. He examines why some people and companies struggle to change, despite years of trying, while others seem to remake themselves overnight. He visits laboratories where neuroscientists explore how habits work and where, exactly, they reside in our brains. And he uncovers how the right habits were crucial to the success of Olympic swimmer Michael Phelps, Starbucks CEO Howard Schultz, and civil-rights hero Martin Luther King, Jr. The result is a compelling argument and an empowering discovery: the key to exercising regularly, losing weight, raising exceptional children, becoming more productive or even building revolutionary companies is understanding how habits work. By harnessing this new science, we can transform our businesses, our communities, and our lives. ______________________________ '[An] essential manual for business and living.' Andrew Hill, Financial Times 'Once you read this book, you'll never look at yourself, your organisation, or your world quite the same way.' Daniel H. Pink 'This is a first-rate book - based on an impressive mass of research, written in a lively style and providing just the right balance of intellectual seriousness with practical advice on how to break our bad habits.";
final MiniplayerProvider _provider = MiniplayerProvider();
int maxLines = 11;

class ScreenPlay extends StatefulWidget {
  const ScreenPlay({
    Key? key,
    required this.eBook,
  }) : super(key: key);
  final List<String> eBook;

  @override
  State<ScreenPlay> createState() => _ScreenPlayState();
}

class _ScreenPlayState extends State<ScreenPlay> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      
      decoration: BoxDecoration(
        gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                 Color.fromARGB(255, 38, 26, 59).withOpacity(0.8),
               const Color.fromARGB(255, 27, 48, 66).withOpacity(0.8),
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: Colors.transparent,),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              // name and image
              Column(
                children: [
                  GestureDetector(
            onTap: (){},
            child: Container(
              margin: EdgeInsets.all(3),
              width: size.width*1.2,
              height: size.width*1.4,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),image: const DecorationImage(image: NetworkImage("https://m.media-amazon.com/images/I/71eoUH2EngL._AC_UF1000,1000_QL80_.jpg"),fit: BoxFit.fill)),
            ),
          ),
                  const SizedBox(height: 10,),
                  const Text("Book Name",style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w700),)
                ],
              ),
              // about
              Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.only(left:  17,right: 17,top: 17,bottom: 9),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: Colors.black12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("About",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    Column(
                      children: [
                         Text(text,style: const TextStyle(overflow: TextOverflow.ellipsis,fontWeight: FontWeight.w500,fontSize: 14),maxLines: maxLines,),
                      ],
                    ),
                    GestureDetector(onTap: (){
                      if(maxLines==20)
                      {
                        maxLines=11;
                      }else{
                        maxLines=20;
                      }
                      setState(() {
                        
                      });
                    },child: Text(maxLines==11? "Show More..":"Show Less",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple),))
                  ],
                ),
              ),
              // parts
              const SizedBox(height: 10,),
              Column(
                  children: List.generate(6, (index) => GestureDetector(
                     onTap: () {
                      context.read<MiniplayerProvider>().addMiniPlayer({"text":text,"name":"Tha Power of Habit","url":"https://m.media-amazon.com/images/I/71eoUH2EngL._AC_UF1000,1000_QL80_.jpg"}, true);
                      context.read<MiniplayerProvider>().miniPlayerController.animateToHeight(state: PanelState.MAX);
                      Navigator.of(context).pop();//push(MaterialPageRoute(builder: (context)=>const ScreenPlayPart()));
                     },
                    child: Container(
                      margin: const EdgeInsets.all(3.0),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Align(alignment: Alignment.centerLeft,child: CircleAvatar(radius: 19,child: Center(child: Text(index.toString()),),backgroundColor: Colors.black38,)),const Align(alignment: Alignment.centerLeft,child: Padding(
                                padding: EdgeInsets.only(left: 70,top: 1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Part name",softWrap: true,style: TextStyle(fontWeight: FontWeight.bold),),
                                    Text("Book Name",softWrap: true,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 10),),
                                  ],
                                ),
                              )),
                              
                            ],
                          ),
                          SizedBox(height: 10,),
                          Divider()
                        ],
                      ),
                    ),
                  )),
                ),
              
            ],
          ),
        ),
      ),
    );
  }
}

