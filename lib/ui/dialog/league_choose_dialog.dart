import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hockey/data/model/league.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/constants.dart';
import 'package:hockey/data/utils/extensions.dart';
import 'package:hockey/main.dart';
import 'package:hockey/ui/editor/edit_league.dart';
import 'package:hockey/ui/editor/edit_team.dart';

class LeagueChooseDialog extends StatelessWidget {
  final ScrollController? scrollController;
  final Function? changeLeague;

  const LeagueChooseDialog({
    Key? key, this.changeLeague,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Wrap(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 8.0, bottom: 5.0),
                height: 4.0,
                width: 24.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.grey.withOpacity(0.9)
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 40),
                const Text(
                  "Leagues",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
                getIconButton(
                  child: const Icon(
                    Icons.close,
                    size: 24,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  context: context
                ),
              ],
            ),
            const SizedBox(height: 48),
            ListView.builder(
              shrinkWrap: true,
              itemCount: League.leagues.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return LeagueItem(
                  league: League.leagues[index],
                  onTap: (){
                    changeLeague!(index);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LeagueItem extends StatelessWidget {
  final League? league;
  final Function? onTap;

  const LeagueItem({Key? key, this.league, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white
          ),
          borderRadius: BorderRadius.circular(16)
        ),
        child: Row(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: LeagueLogo(
                league: league,
                imageFile: File("$filesPath/${league!.leagueName}.png"),
                isExists: File("$filesPath/${league!.leagueName}.png").existsSync(),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              league!.leagueName!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }

  String getLeagueNameByPos(int id){
    if(id == 1){
      return "NHL";
    }
    else if(id == 33){
      return "AHL";
    }
    return "NHL";
  }
}

