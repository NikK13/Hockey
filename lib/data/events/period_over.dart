import 'package:flutter/material.dart';
import 'package:hockey/data/events/match.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/localization.dart';

class PeriodOver extends MatchEvent{
  PeriodOver(BuildContext context, Team at, Team df, GameMatch match, [bool start = false]){
    comment = AppLocalizations.of(context, 'period_end');
  }
}