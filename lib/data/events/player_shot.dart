import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hockey/data/events/goal.dart';
import 'package:hockey/data/events/goalie_save.dart';
import 'package:hockey/data/events/interception.dart';
import 'package:hockey/data/events/match.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/events/missed_shot.dart';
import 'package:hockey/data/events/passing_zone.dart';
import 'package:hockey/data/model/player.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/extensions.dart';
import 'package:hockey/data/utils/localization.dart';

class PlayerShot extends MatchEvent{
  final BuildContext context;
  final Team attTeam;
  final Team defTeam;
  final GameMatch match;

  PlayerShot(this.context, this.attTeam, this.defTeam, this.match, Player plToShoot, Player passedTo){
    comment = AppLocalizations.of(context, 'shot_from').replaceAll("PLAYER", "${plToShoot.firstName} ${plToShoot.lastName}");
    if(GameMatch.kp <= GameMatch.maxMoments){
      final val = 0 + Random().nextInt(100);
      if(val > 45){
        final goalPoss = 0 + Random().nextInt(100);
        if(goalPoss.isBetween(0, 50)){
          final goalie = defTeam.roster![17];
          final poss = (((plToShoot.skill! / goalie.skill!) / 1.2) * 100).toInt();
          final val = 0 + Random().nextInt(100);
          if(val < poss){
            match.events.add(Goal(context, attTeam, defTeam, match, plToShoot, passedTo));
          }
          else{
            match.events.add(MissedShot(context, attTeam, defTeam, match));
          }
        }
        if(goalPoss.isBetween(51, 80)){
          match.events.add(GoalieSave(context, attTeam, defTeam, match));
        }
        else{
          match.events.add(PassingInZone(context, attTeam, defTeam, match));
        }
      }
      else{
        match.events.add(Interception(context, attTeam, defTeam, match));
      }
    }
  }
}