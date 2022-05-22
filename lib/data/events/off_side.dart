import 'package:flutter/material.dart';
import 'package:hockey/data/events/face_off.dart';
import 'package:hockey/data/events/match.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/events/period_over.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/localization.dart';

class OffSide extends MatchEvent{
  final BuildContext context;
  final Team attTeam;
  final Team defTeam;
  final GameMatch match;

  OffSide(this.context, this.attTeam, this.defTeam, this.match, [bool start = false]){
    comment = AppLocalizations.of(context, 'off_side').replaceAll("TEAM", attTeam.teamName!);
    GameMatch.kp++;
    if(GameMatch.kp <= GameMatch.maxMoments){
      match.events.add(FaceOff(context, attTeam, defTeam, match, false));
    }
  }
}