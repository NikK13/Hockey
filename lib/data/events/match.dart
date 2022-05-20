import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hockey/data/events/match_event.dart';

class GameMatch{
  final int homeScore = 0;
  final int awayScore = 0;
  final BuildContext? context;
  final List<MatchEvent> events = [];

  int? firstPeriodL;
  int? secondPeriodL;
  int? thirdPeriodL;
  int? otPlayOffL;
  int? otSeasonL;

  GameMatch({this.context}){
    firstPeriodL = 20 + Random().nextInt(20);
    secondPeriodL = 20 + Random().nextInt(20);
    thirdPeriodL = 20 + Random().nextInt(20);
    otPlayOffL = 20 + Random().nextInt(20);
    otSeasonL = 5 + Random().nextInt(10);
    debugPrint("1: $firstPeriodL, 2: $secondPeriodL, 3: $thirdPeriodL");
  }

  bool get ifPeriodEnd{
    if(events.length == firstPeriodL || events.length == secondPeriodL || events.length == thirdPeriodL){
      return true;
    }
    return false;
  }
}