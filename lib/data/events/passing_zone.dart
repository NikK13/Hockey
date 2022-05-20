import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hockey/data/events/attack_zone.dart';
import 'package:hockey/data/events/interception.dart';
import 'package:hockey/data/events/match.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/events/off_side.dart';
import 'package:hockey/data/events/period_over.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/extensions.dart';
import 'package:hockey/data/utils/localization.dart';

class PassingZone extends MatchEvent{
  PassingZone(BuildContext context, Team attTeam, Team defTeam, GameMatch match){
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
    if(!match.ifPeriodEnd){
      final val = 0 + Random().nextInt(100);
      /*if(val.isBetween(0, 32)){
        match.events.add(OffSide(context, attTeam, defTeam, match));
      }
      if(val.isBetween(33, 67)){
        match.events.add(AttackZone(context, attTeam, defTeam, match));
      }
      else{
        match.events.add(Interception(context, attTeam, defTeam, match));
      }*/
    }
    else{
      match.events.add(PeriodOver(context, attTeam, defTeam, match));
    }
  }
}