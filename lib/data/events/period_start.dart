import 'package:flutter/material.dart';
import 'package:hockey/data/events/face_off.dart';
import 'package:hockey/data/events/match.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/localization.dart';

class PeriodStart extends MatchEvent{
  PeriodStart(BuildContext context, Team at, Team df, GameMatch match, [bool start = false]){
    comment = AppLocalizations.of(context, 'period_start');
    match.events.add(FaceOff(context, at, df, match, true));
  }
}