import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hockey/data/events/face_off.dart';
import 'package:hockey/data/events/interception.dart';
import 'package:hockey/data/events/match.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/localization.dart';

class GoalieSave extends MatchEvent{
  final BuildContext context;
  final Team attTeam;
  final Team defTeam;
  final GameMatch match;

  GoalieSave(this.context, this.attTeam, this.defTeam, this.match){
    final goalie = defTeam.roster![17];
    comment = AppLocalizations.of(context, 'goalie_save').replaceAll("GOALIE", "${goalie.firstName} ${goalie.lastName}");
    GameMatch.kp++;
    if(GameMatch.kp <= GameMatch.maxMoments){
      int poss = 0 + Random().nextInt(100);
      if(poss > 50){
        match.events.add(FaceOff(context, attTeam, defTeam, match));
      }
      else{
        match.events.add(Interception(context, attTeam, defTeam, match));
      }
    }
  }
}