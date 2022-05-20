import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hockey/data/events/match.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/events/pass_center.dart';
import 'package:hockey/data/events/period_over.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/localization.dart';

class FaceOff extends MatchEvent{
  FaceOff(BuildContext context, Team t1, Team t2, GameMatch match, [bool start = false]){
    final val = 0 + Random().nextInt(100);
    Team attackingTeam, defendingTeam;
    if(val < 50){
      attackingTeam = t1;
      defendingTeam = t2;
    }
    else{
      attackingTeam = t2;
      defendingTeam = t1;
    }
    comment = AppLocalizations.of(context, 'face_off').replaceAll("_", attackingTeam.teamName!);
    if(!match.ifPeriodEnd){
      match.events.add(PassFromCenter(context, attackingTeam, defendingTeam, match));
    }
    else{
      match.events.add(PeriodOver(context, attackingTeam, defendingTeam, match));
    }
  }
}