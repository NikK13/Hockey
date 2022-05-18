class League{
  int? id;
  String? leagueName;
  String? defDrawable;

  League({this.id, this.leagueName, this.defDrawable});

  static List<League> get leagues => List.from([
    League(id: 1, leagueName: "NHL", defDrawable: "black"),
    League(id: 2, leagueName: "AHL", defDrawable: "blue")
  ]);
}