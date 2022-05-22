import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hockey/data/events/match.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/events/pass_center.dart';
import 'package:hockey/data/events/period_over.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/localization.dart';

class FaceOff extends MatchEvent{
  final BuildContext context;
  final Team attTeam;
  final Team defTeam;
  final GameMatch match;

  FaceOff(this.context, this.attTeam, this.defTeam, this.match, [bool start = false]){
    final val = 0 + Random().nextInt(100);
    attTeam.curLine = 1 + Random().nextInt(3);
    defTeam.curLine = 1 + Random().nextInt(3);
    Team attackingTeam, defendingTeam;
    final attPl = attTeam.getLineUp(attTeam.roster!, attTeam.curLine!)[1];
    final defPl = defTeam.getLineUp(defTeam.roster!, defTeam.curLine!)[1];
    int poss;
    if(attPl.skill! < defPl.skill!){
      poss = 50 - (defPl.skill! - attPl.skill!);
    }
    else{
      poss = 50 + (attPl.skill! - defPl.skill!);
    }
    if(val < poss){
      attackingTeam = attTeam;
      defendingTeam = defTeam;
    }
    else{
      attackingTeam = defTeam;
      defendingTeam = attTeam;
    }
    comment = AppLocalizations.of(context, 'face_off').replaceAll("_", attackingTeam.teamName!);
    if(GameMatch.kp <= GameMatch.maxMoments){
      match.events.add(PassFromCenter(context, attackingTeam, defendingTeam, match));
    }
  }
}