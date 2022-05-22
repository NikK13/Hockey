import 'package:flutter/material.dart';
import 'package:hockey/data/events/face_off.dart';
import 'package:hockey/data/events/match.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/events/pass_center.dart';
import 'package:hockey/data/events/period_over.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/localization.dart';

class Interception extends MatchEvent{
  final BuildContext context;
  final Team attTeam;
  final Team defTeam;
  final GameMatch match;

  Interception(this.context, this.attTeam, this.defTeam, this.match){
    comment = AppLocalizations.of(context, 'interception').replaceAll("TEAM", defTeam.teamName!);
    GameMatch.kp++;
    if(GameMatch.kp <= GameMatch.maxMoments){
      match.events.add(PassFromCenter(context, defTeam, attTeam, match));
    }
  }
}