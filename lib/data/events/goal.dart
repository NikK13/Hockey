import 'package:flutter/material.dart';
import 'package:hockey/data/events/face_off.dart';
import 'package:hockey/data/events/match.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/model/player.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/localization.dart';

class Goal extends MatchEvent{
  Team? scoredTeam;
  Player? scorer;
  Player? passer;

  Goal(BuildContext context, Team attTeam, Team defTeam, GameMatch match, Player scored, Player passed){
    comment = "GOAL by ${scored.firstName} ${scored.lastName}";
    scoredTeam = attTeam;
    scorer = scored;
    passer = passed;
    match.events.add(FaceOff(context, attTeam, defTeam, match, true));
  }
}