import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hockey/data/events/match.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/events/period_over.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/localization.dart';

class AttackZone extends MatchEvent{
  AttackZone(BuildContext context, Team attTeam, Team defTeam, GameMatch match){
    comment = AppLocalizations.of(context, 'attack_zone').replaceAll("TEAM", attTeam.teamName!);
    if(!match.ifPeriodEnd){
      final val = 0 + Random().nextInt(100);
      if(val > 50){

      }
    }
    else{
      match.events.add(PeriodOver(context, attTeam, defTeam, match));
    }
  }
}