import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:miniplayer/miniplayer.dart';

class MiniplayerProvider extends ChangeNotifier{
  bool miniPlayerIsRunning=false;
  bool isPlaying=false;
  final miniPlayerController = MiniplayerController();
   String? audioUrl;
   String text="";
   String pdfUrl="";
   String partName="";
   String bookname="";
   String bookUrl="";


  Future<void>addMiniPlayer({String? audioUrl,required String text,required String pdfUrl,required String partName,required String bookname,required String bookUrl,required bool isPlayingL})async
  {
    log("message");
    miniPlayerController.animateToHeight(state: PanelState.MAX);
    notifyListeners();
    miniPlayerIsRunning = true;
    isPlaying = isPlayingL;
    this.audioUrl=audioUrl;
    this.text=text;
    this.pdfUrl=pdfUrl;
    this.partName=partName;
    this.bookname=bookname;
    this.bookUrl=bookUrl;
    notifyListeners();
    return;
  }
  Future<void>clear()async
  {
    miniPlayerIsRunning = false;
    isPlaying = false;
    notifyListeners();
    return;
  }
  Future<void>cloce()async
  {
    miniPlayerController.animateToHeight(state: PanelState.MIN);
    miniPlayerIsRunning = false;
    isPlaying = false;
    notifyListeners();
    return;
  }
}