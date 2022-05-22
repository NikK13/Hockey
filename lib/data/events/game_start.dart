import 'package:flutter/material.dart';
import 'package:hockey/data/events/face_off.dart';
import 'package:hockey/data/events/match.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/localization.dart';

class GameStart extends MatchEvent{
  final BuildContext context;
  final Team attTeam;
  final Team defTeam;
  final GameMatch match;

  GameStart(this.context, this.attTeam, this.defTeam, this.match){
    comment = AppLocalizations.of(context, 'game_start').replaceAll("HOME", attTeam.teamName!).replaceAll("AWAY", defTeam.teamName!);
    match.events.add(FaceOff(context, attTeam, defTeam, match, true));
  }
}