import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hockey/data/events/interception.dart';
import 'package:hockey/data/events/match.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/events/passing_zone.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/localization.dart';

class MissedShot extends MatchEvent{
  final BuildContext context;
  final Team attTeam;
  final Team defTeam;
  final GameMatch match;

  MissedShot(this.context, this.attTeam, this.defTeam, this.match){
    comment = AppLocalizations.of(context, 'shot_missed');
    GameMatch.kp++;
    if(GameMatch.kp <= GameMatch.maxMoments){
      int poss = 0 + Random().nextInt(100);
      if(poss > 50){
        match.events.add(Interception(context, attTeam, defTeam, match));
      }
      else{
        match.events.add(PassingInZone(context, attTeam, defTeam, match));
      }
    }
  }
}