import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/model/team.dart';

class FaceOff extends MatchEvent{
  static FaceOff generateEvent(Team home, Team away, [bool startOfGame = false]){
    return FaceOff();
  }
}