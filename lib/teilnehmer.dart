import 'dart:math';

enum Geschlecht {
  w,
  m,
  d
}

class Teilnehmer {
  String vorname;
  String nachname;
  Geschlecht geschlecht;
  DateTime geburtsdatum;
  int? abschlussnote;
  Zutrittsberechtigung zutrittsberechtigung;

  Teilnehmer({
    required this.vorname,
    required this.nachname,
    required this.geschlecht,
    required this.geburtsdatum,
    this.abschlussnote,
  }) : zutrittsberechtigung = Zutrittsberechtigung();
}

class Zutrittsberechtigung {
  int zutrittsberechtigungsId;

  Zutrittsberechtigung() : zutrittsberechtigungsId = Random().nextInt(999999999);
}
