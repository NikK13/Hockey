import 'package:flutter/material.dart';
import 'package:hockey/data/events/face_off.dart';
import 'package:hockey/data/events/match.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/events/pass_center.dart';
import 'package:hockey/data/events/period_over.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/localization.dart';

class Interception extends MatchEvent{
  Interception(BuildContext context, Team at, Team df, GameMatch match){
    comment = AppLocalizations.of(context, 'interception').replaceAll("TEAM", df.teamName!);
    if(!match.ifPeriodEnd){
      match.events.add(PassFromCenter(context, df, at, match));
    }
    else{
      match.events.add(PeriodOver(context, at, df, match));
    }
  }
}