class Teilnehmer {
  String vorname;
  String nachname;
  String? geschlecht;
  DateTime geburtsdatum;
  int? abschlussnote;

  Teilnehmer({
    required this.vorname,
    required this.nachname,
    this.geschlecht,
    required this.geburtsdatum,
    this.abschlussnote
    });
}
