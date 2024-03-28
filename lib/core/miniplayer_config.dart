import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:miniplayer/miniplayer.dart';

class MiniplayerProvider extends ChangeNotifier{
  bool miniPlayerIsRunning=false;
  bool isPlaying=false;
  final miniPlayerController = MiniplayerController();
  Map<String,dynamic> data={};

  Future<Map<String,dynamic>>addMiniPlayer(Map<String,dynamic> data,bool isPlayingL)async
  {
    log("message");
    miniPlayerIsRunning = true;
    isPlaying = isPlayingL;
    this.data=data;
    notifyListeners();
    return data;
  }
  Future<Map<String,dynamic>>cloce()async
  {
    miniPlayerController.animateToHeight(state: PanelState.MIN);
    miniPlayerIsRunning = false;
    isPlaying = false;
    notifyListeners();
    return data;
  }
}