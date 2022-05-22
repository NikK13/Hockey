import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hockey/data/events/match_event.dart';

class GameMatch{
  int homeScore = 0;
  int awayScore = 0;
  final List<MatchEvent> events = [];

  static int maxMoments = 50;
  static int kp = 0;

  int? firstPeriodL;
  int? secondPeriodL;
  int? thirdPeriodL;
  int? otPlayOffL;
  int? otSeasonL;

  GameMatch(){
    firstPeriodL = 20 + Random().nextInt(20);
    secondPeriodL = 20 + Random().nextInt(20);
    thirdPeriodL = 20 + Random().nextInt(20);
    otPlayOffL = 20 + Random().nextInt(20);
    otSeasonL = 5 + Random().nextInt(10);
    //debugPrint("1: $firstPeriodL, 2: $secondPeriodL, 3: $thirdPeriodL");
  }
}