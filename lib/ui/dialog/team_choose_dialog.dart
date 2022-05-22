import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/constants.dart';
import 'package:hockey/data/utils/extensions.dart';
import 'package:hockey/main.dart';
import 'package:hockey/ui/editor/edit_team.dart';

class TeamChooseDialog extends StatelessWidget {
  final ScrollController? scrollController;
  final Function? changeTeam;
  final List<Team>? teams;
  final bool? isHome;

  const TeamChooseDialog({
    Key? key, this.changeTeam,
    this.scrollController,
    this.teams, this.isHome
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
                  "All teams",
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
              itemCount: Constants.teamsCount,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return TeamItem(
                  team: teams![index],
                  onTap: (){
                    if(isHome != null){
                      changeTeam!(isHome!, teams![index]);
                    }
                    else{
                      changeTeam!(teams![index].id);
                    }
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

class TeamItem extends StatelessWidget {
  final Team? team;
  final Function? onTap;

  const TeamItem({Key? key, this.team, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(team!.id! == 1 || team!.id! == 33)
        Column(
          children: [
            const SizedBox(height: 16),
            Text(
              "  ${getLeagueNameByPos(team!.id!)}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600
              ),
            ),
          ],
        ),
        GestureDetector(
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
                  child: TeamLogo(
                    team: team,
                    imageFile: File("$filesPath/team${team!.id}.png"),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  team!.teamName!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                  ),
                )
              ],
            ),
          ),
        ),
      ],
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

