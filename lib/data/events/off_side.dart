import 'package:flutter/material.dart';
import 'package:hockey/data/events/face_off.dart';
import 'package:hockey/data/events/match.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/events/period_over.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/localization.dart';

class OffSide extends MatchEvent{
  OffSide(BuildContext context, Team at, Team df, GameMatch match, [bool start = false]){
    comment = AppLocalizations.of(context, 'off_side').replaceAll("TEAM", at.teamName!);
    if(!match.ifPeriodEnd){
      match.events.add(FaceOff(context, at, df, match, false));
    }
    else{
      match.events.add(PeriodOver(context, at, df, match));
    }
  }
}