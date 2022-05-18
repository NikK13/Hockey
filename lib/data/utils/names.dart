import 'package:hockey/data/model/player.dart';

class PlayerNames{
  static List<String> getNamesByNation(Nationality nation){
    switch(nation){
      case Nationality.austria:
        return ausNames;
      case Nationality.belarus:
        return blrNames;
      case Nationality.canada:
        return canNames;
      case Nationality.czech:
        return czeNames;
      case Nationality.denmark:
        return denNames;
      case Nationality.finland:
        return finNames;
      case Nationality.france:
        return fraNames;
      case Nationality.germany:
        return gerNames;
      case Nationality.latvia:
        return ltvNames;
      case Nationality.norway:
        return nrwNames;
      case Nationality.russia:
        return rusNames;
      case Nationality.slovakia:
        return slvNames;
      case Nationality.slovenia:
        return sloNames;
      case Nationality.sweden:
        return sweNames;
      case Nationality.switzerland:
        return swiNames;
      case Nationality.usa:
        return usaNames;
    }
  }

  static List<String> getSurnamesByNation(Nationality nation){
    switch(nation){
      case Nationality.austria:
        return ausSurnames;
      case Nationality.belarus:
        return blrSurnames;
      case Nationality.canada:
        return canSurnames;
      case Nationality.czech:
        return czeSurnames;
      case Nationality.denmark:
        return denSurnames;
      case Nationality.finland:
        return finSurnames;
      case Nationality.france:
        return fraSurnames;
      case Nationality.germany:
        return gerSurnames;
      case Nationality.latvia:
        return ltvSurnames;
      case Nationality.norway:
        return nrwSurnames;
      case Nationality.russia:
        return rusSurnames;
      case Nationality.slovakia:
        return slvSurnames;
      case Nationality.slovenia:
        return sloSurnames;
      case Nationality.sweden:
        return sweSurnames;
      case Nationality.switzerland:
        return swiSurnames;
      case Nationality.usa:
        return usaSurnames;
    }
  }

  static List<String> ausNames = [
    "Gregor", "Andreas",
    "Thomas", "Martin",
    "Michael", "Marco",
    "Dominic", "David",
    "Kilian", "Bernhard",
    "Lukas", "Bernd"
  ];

  static List<String> ausSurnames = [
    "Morgen", "Kofler",
    "Raffl", "Rossi",
    "Schwab", "Loitzl",
    "Moritz", "Fiedler",
    "Reymer", "Zaidler",
    "Brunner", "Zieler",
    "Madler", "Wolf",
    "Huber", "Heinrich"
  ];

  static List<String> blrNames = [
    "Andrei", "Sergei",
    "Vladimir", "Egor",
    "Kirill", "Pavel",
    "Nikita", "Dmitriy",
    "Vladislav", "Igor",
    "Vyacheslav", "Alexandr",
    "Alexei", "Yuri", "Artyom"
  ];

  static List<String> blrSurnames = [
    "Makarov", "Kolosov",
    "Lisov", "Leonov",
    "Sushkin", "Nikolaev",
    "Aleksandrov", "Volodkov",
    "Andreev", "Makarov",
    "Potapov", "Demkov",
    "Demchenko", "Morozov",
    "Zemkov", "Zemchenko",
    "Yerovets", "Timofeev",
    "Volkov", "Volkovets",
    "Pavlovets", "Terovets"
  ];

  static List<String> canNames = [
    "Justin", "Connor",
    "Joe", "Brent",
    "Eric", "Ryan",
    "Jason", "Corey",
    "Brad", "Jamie",
    "Tyler", "Taylor",
    "Kristopher", "David",
    "Nathan", "Duncan",
    "Logan", "Jordan",
    "Wayne", "Jeff",
    "Brayden", "Derick",
    "Alex", "Mark",
    "Sean", "Andrew",
    "Reilly", "Mitchell",
    "Tyson", "Jaden",
    "Zach", "Adam",
    "Damon", "Cole"
  ];

  static List<String> canSurnames = [
    "McCabe", "Keith",
    "Burns", "McKegg",
    "McDonald", "Foligno",
    "Jackson", "Gaudreau",
    "Goodrow", "Benn",
    "Lemieux", "Stone",
    "Brassard", "Kane",
    "Toews", "Giordano",
    "Neal", "Eberle",
    "Mohan", "Yohan",
    "Letang", "Yzerman",
    "Legace", "Hall",
    "McCormick", "McDavid",
    "Jones", "Murphy",
    "Hopkins", "Nugent",
    "Davidson", "Roloson",
    "Couture", "Toffie",
    "Hoffman", "Gallagher",
    "Strome", "Dach",
    "Perreault", "Tylers",
    "Comeau", "Myers",
    "Helmy", "Schultz",
    "Dubois", "Duclair",
    "Jenner", "Ellis",
    "Graves", "Thompson",
    "Anderson", "Johnson"
  ];

  static List<String> czeNames = [
    "Libor", "Patrik",
    "Dominik", "Zbynek",
    "Filip", "Pavel",
    "Jaromir", "Petr",
    "Tomas", "Marek",
    "David", "Martin",
    "Ondrej", "Lukas",
    "Roman", "Jakub",
    "Michal", "Jiri",
    "Matej", "Radim"
  ];

  static List<String> czeSurnames = [
    "Lasek", "Horny",
    "Krejci", "Hajko",
    "Chytil", "Zacha",
    "Rosicky", "Voracek",
    "Kase", "Necas",
    "Kubalik", "Hronek",
    "Kampf", "Nosek",
    "Sustr", "Pastrik",
    "Hajek", "Simek",
    "Mrazek", "Novak",
    "Simon", "Simek",
    "Spacek", "Posek",
    "Vesic", "Jiricek"
  ];

  static List<String> denNames = [
    "Nikolaj", "Lars",
    "Oliver", "Jonas",
    "Mads", "Frederik",
    "Matias", "Matthias",
    "Emil", "Jesper"
  ];

  static List<String> denSurnames = [
    "Ehlers", "Eriksen",
    "Kjaer", "Hojberg",
    "Andersen", "Bjorkstrand",
    "Jensen", "Meyer",
    "Nielsen", "Kristensen",
    "Lauridsen", "Lassen"
  ];

  static List<String> finNames = [
    "Juhamatti", "Marko",
    "Antti", "Marcus",
    "Mikael", "Sebastian",
    "Erik", "Joonas",
    "Artturi", "Juuse",
    "Janne", "Kaapo",
    "Esa", "Henri",
    "Eeli", "Eetu",
    "Juho", "Tuukka",
    "Niko", "Rasmus",
    "Sami", "Saku",
    "Ville", "Jere",
    "Toni", "Harri",
    "Jussi", "Atte"
  ];

  static List<String> finSurnames = [
    "Kakko", "Kapanen",
    "Saros", "Rask",
    "Aaltonen", "Anttila",
    "Koiviranta", "Koivu",
    "Mikkola", "Jaakola",
    "Raanta", "Nutivaara",
    "Kuparinen", "Maatta",
    "Aho", "Rantanen",
    "Riikola", "Jukkola",
    "Velainen", "Makarainen",
    "Seppala", "Riekkala",
    "Maenalanen", "Vehanen",
    "Tuikkonen"
  ];

  static List<String> fraNames = [
    "Alexandre", "Pierre",
    "Luc", "Antoine",
    "Loic", "Antoni",
    "Edouard", "Florian",
    "Teddy", "Johann",
    "Fabien", "Romain"
  ];

  static List<String> fraSurnames = [
    "Thuavin", "Dubois",
    "Texier", "Roussel",
    "Lavien", "Fabien",
    "Fleury", "Cleraux",
    "Menier", "Laperierre",
    "Bault", "Perret",
    "Therrier"
  ];

  static List<String> gerNames = [
    "Leon", "Marco",
    "Tim", "Philipp",
    "Thomas", "Lukas",
    "Dominik", "Maximilian",
    "Daniel", "Fabio"
  ];

  static List<String> gerSurnames = [
    "Sturm", "Muller",
    "Kimmich", "Seider",
    "Reichel", "Stutzle",
    "Meyer", "Suiler",
    "Schulz", "Schmolz",
    "Noebels", "Wiermann"
  ];

  static List<String> ltvNames = [
    "Laurins", "Sandis",
    "Zemgus", "Rudolfs",
    "Elvis", "Kristians",
    "Arvils", "Roberts",
    "Janis", "Kristaps",
    "Oskars", "Rihards",
    "Martins", "Renars"
  ];

  static List<String> ltvSurnames = [
    "Rubins", "Darzins",
    "Martins", "Ginsons",
    "Balcers", "Merlikins",
    "Kalvins", "Jerins",
    "Bukarts", "Sapouers",
    "Dzierkals", "Silovs",
    "Gusevs", "Kudals",
    "Jaks", "Smirnovs",
    "Volkovs", "Crigals",
    "Kenins", "Vilens"
  ];

  static List<String> nrwNames = [
    "Alexander", "Mats",
    "Emil", "Mads",
    "Oliver", "Matthias"
  ];

  static List<String> nrwSurnames = [
    "Johansson", "Jonassen",
    "Martensson", "Paulsson",
    "Gunnarsson", "Sorensen",
  ];

  static List<String> rusNames = [
    "Andrei", "Sergei",
    "Vladimir", "Egor",
    "Kirill", "Pavel",
    "Nikita", "Dmitriy",
    "Vladislav", "Igor",
    "Vyacheslav", "Alexandr",
    "Evgeni", "Artem",
    "Artemi", "Valeri",
    "Denis", "Ivan",
    "Arseni", "Mark",
    "Daniil", "Danila",
    "Vasily", "Boris"
  ];

  static List<String> rusSurnames = [
    "Makarov", "Bucharov",
    "Frolov", "Komarov",
    "Malov", "Nikolaev",
    "Aleksandrov", "Volodkov",
    "Andreev", "Popov",
    "Potapov", "Mironov",
    "Provorov", "Morozov",
    "Zaitsev", "Volkov",
    "Marchenko", "Nesterov",
    "Nesterenko", "Ponomarenko",
    "Zadornov", "Dadonov", "Gusev",
    "Voynov", "Kuznetsov", "Kucherov",
    "Samsonov", "Vasilevski",
    "Kostin", "Borisov", "Malakhov",
    "Bobrovski", "Georgiev", "Timofeev",
    "Alexeyev", "Pavlov", "Taymudzinov",
    "Menshov", "Romkin", "Zinoviev",
    "Malinin", "Zemlyanikin"
  ];

  static List<String> slvNames = [
    "Zdeno", "Andrej",
    "Richard", "Erik",
    "Martin", "Adam",
    "Marian", "Tomas",
    "Marek", "Branislav",
    "Adam", "Juraj",
    "Mario", "Simon",
    "Milos", "Pavol"
  ];

  static List<String> slvSurnames = [
    "Hudacek", "Lubocek",
    "Zedacek", "Cernik",
    "Ruzicka", "Huska",
    "Jaros", "Sekera",
    "Bucko", "Kristof",
    "Liska", "Romasek",
    "Lunter", "Tomek",
    "Radek", "Panchek",
    "Vernak", "Vostrik"
  ];

  static List<String> sloNames = [
    "Anze", "Rok", "Marek",
    "Richard", "Patrik",
    "Gasper", "Luka",
    "Blaz", "Jan"
  ];

  static List<String> sloSurnames = [
    "Ticar", "Libor",
    "Hajer", "Kavar",
    "Kovacevic", "Matej",
    "Halep", "Music",
    "Tabolic", "Savucevic",
    "Grajner", "Verlic"
  ];

  static List<String> sweNames = [
    "Andreas", "Patrik",
    "Bjorn", "Nicklas",
    "Patric", "Mikael",
    "Oliver", "Gustav",
    "William", "Andre",
    "Filip", "Elias",
    "Mika", "Jesper",
    "Victor", "Hampus",
    "Joel", "Joakim"
  ];

  static List<String> sweSurnames = [
    "Andersson", "Johansson",
    "Pettersson", "Naslund",
    "Arvidsson", "Karlsson",
    "Bukarsson", "Larsson",
    "Backlund", "Forsberg",
    "Rask", "Matiasson",
    "Olofsson", "Johnsson",
    "Sundqvist", "Nuqvist",
    "Hagg", "Tonasson",
    "Kellman", "Fortsson",
    "Bemsson", "Gustafsson"
  ];

  static List<String> swiNames = [
    "Philipp", "Kevin",
    "Roman", "Timo",
    "Nico", "Pius",
    "Sven", "Gregory"
  ];

  static List<String> swiSurnames = [
    "Meier", "Hischier",
    "Fischer", "Ammann",
    "Suter", "Josi",
    "Fiala", "Niederreiter",
    "Sieghentaler", "Leiter",
    "Mueller", "Bailer"
  ];

  static List<String> usaNames = [
    "Justin", "Joe", "Brent",
    "Eric", "Ryan", "Jake",
    "Brad", "Jamie",
    "Tyler", "Taylor",
    "Kristopher", "David",
    "Nathan", "Jordan",
    "Wayne", "Jeff",
    "Brayden", "Derick",
    "Alex", "Mark",
    "Sean", "Andrew",
    "Reilly", "Mitchell",
    "Tyson", "Jaden",
    "Patrick", "James",
    "Kyle", "Nick", "Sam",
    "Cam", "Dustin",
    "Chris", "Anders", "Kevin",
    "Adam", "Nolan"
  ];

  static List<String> usaSurnames = [
    "McCabe", "Hayes",
    "Lee", "Connor",
    "Johns", "Johnson",
    "Coyle", "Rooney",
    "Matthews", "Kreider",
    "Atkinson", "Stepan",
    "Foligno", "Yandle",
    "Hull", "Suter",
    "Stastny", "Wheeler",
    "Kane", "Nelson",
    "Miller", "Larkin",
    "McDonagh", "Keller",
    "Boyle", "Green",
    "Greene", "Rust",
    "Sheary", "Braun",
    "Martinez", "Thompson",
    "Ryan", "Cole", "Fox",
    "Tkachuk", "Lewis",
    "Coleman", "Vatrano",
    "Vesey", "Robertson",
    "Murphy", "Wood",
    "Moore", "Watson",
    "White", "Terry",
    "Reilly", "Merrill",
    "Boyd", "Gaudette",
    "Motte", "Noesen"
  ];
}