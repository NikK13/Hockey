import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hockey/data/events/interception.dart';
import 'package:hockey/data/events/match.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/events/player_shot.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/extensions.dart';
import 'package:hockey/data/utils/localization.dart';

class PassingInZone extends MatchEvent{
  final BuildContext context;
  final Team attTeam;
  final Team defTeam;
  final GameMatch match;

  PassingInZone(this.context, this.attTeam, this.defTeam, this.match){
    int passerPlId = 0 + Random().nextInt(4);
    int toPlId = 0 + Random().nextInt(4);
    while(passerPlId == toPlId) {
      toPlId = 0 + Random().nextInt(4);
    }
    final passerPl = attTeam.getLineUp(attTeam.roster!, attTeam.curLine!)[passerPlId];
    final toPassPl = attTeam.getLineUp(attTeam.roster!, attTeam.curLine!)[toPlId];
    comment = AppLocalizations.of(context, 'pass')
      .replaceAll("P1", "${passerPl.firstName} ${passerPl.lastName}")
      .replaceAll("P2", "${toPassPl.firstName} ${toPassPl.lastName}");
    if(GameMatch.kp <= GameMatch.maxMoments){
      final val = 0 + Random().nextInt(100);
      if(val.isBetween(0, 40)){
        match.events.add(PlayerShot(context, attTeam, defTeam, match, toPassPl, passerPl));
      }
      if(val.isBetween(41, 70)){
        match.events.add(PassingInZone(context, attTeam, defTeam, match));
      }
      else{
        match.events.add(Interception(context, attTeam, defTeam, match));
      }
    }
  }
}