import 'package:flutter/material.dart';
import 'package:hockey/data/events/face_off.dart';
import 'package:hockey/data/events/match.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/localization.dart';

class GameStart extends MatchEvent{
  GameStart(BuildContext context, Team t1, Team t2, GameMatch match){
    comment = AppLocalizations.of(context, 'game_start').replaceAll("HOME", t1.teamName!).replaceAll("AWAY", t2.teamName!);
    match.events.add(FaceOff(context, t1, t2, match, true));
  }
}