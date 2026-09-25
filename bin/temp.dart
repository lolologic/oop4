import 'dart:io';

import 'package:oop4/cdemy.dart';
import 'package:oop4/kurs.dart';
import 'package:oop4/teilnehmer.dart';

void main() {
  final cdemy = Cdemy();

  final kurs = Kurs(
    kursArt: KursArt.fiae,
    startTermin: DateTime(2026, 7, 10),
    kursDauerMonate: 24,
  );

  cdemy.kursHinzufuegen(kurs);

  final teilnehmer = erstelleTeilnehmer();

  kurs.teilnehmerHinzufuegen(teilnehmer);

  for (int i = 0; i < kurs.teilnehmerListe.length; i++) {
    print(kurs.teilnehmerListe[i].vorname);
  }

  for (var i = 0; i < cdemy.kursListe.length; i++) {
    print(cdemy.kursListe[i].kursArt);
  }
}

List<Teilnehmer> erstelleTeilnehmerListeTest() {
  final teilnehmer = <Teilnehmer>[
    Teilnehmer(
      vorname: 'Max',
      nachname: 'Mustermann',
      geschlecht: Geschlecht.m,
      geburtsdatum: DateTime(2000, 1, 1),
    ),
    Teilnehmer(
      vorname: 'Anna',
      nachname: 'Schmidt',
      geschlecht: Geschlecht.w,
      geburtsdatum: DateTime(1998, 3, 14),
      abschlussnote: 2,
    ),
    Teilnehmer(
      vorname: 'Mehmet',
      nachname: 'Yilmaz',
      geschlecht: Geschlecht.m,
      geburtsdatum: DateTime(2001, 7, 22),
    ),
    Teilnehmer(
      vorname: 'Alex',
      nachname: 'Meyer',
      geschlecht: Geschlecht.m,
      geburtsdatum: DateTime(1995, 11, 5),
      abschlussnote: 1,
    ),
    Teilnehmer(
      vorname: 'Sophie',
      nachname: 'Wagner',
      geschlecht: Geschlecht.w,
      geburtsdatum: DateTime(2003, 1, 30),
    ),
  ];

  return teilnehmer;
}

void ausgabeTeilnehmerListe(List<Teilnehmer> teilnehmer) {
  for (int i = 0; i < teilnehmer.length; i++) {
    print('Vorname: ${teilnehmer[i].vorname}');
    print('Nachname: ${teilnehmer[i].nachname}');
    print('Geschlecht: ${teilnehmer[i].geschlecht}');

    print('Alter: ${berechneAlter(teilnehmer[i])}');

    if (teilnehmer[i].abschlussnote != null) {
      print('Abschlussnote: ${teilnehmer[i].abschlussnote}');
    }
    print('${teilnehmer[i].zutrittsberechtigung.zutrittsberechtigungsId}');
    print('');
  }
}

int berechneAlter(Teilnehmer teilnehmer) {
  final dateNow = DateTime.now();

  int alter = dateNow.year - teilnehmer.geburtsdatum.year;

  if ((dateNow.month < teilnehmer.geburtsdatum.month) ||
      (dateNow.month == teilnehmer.geburtsdatum.month &&
          dateNow.day < teilnehmer.geburtsdatum.day)) {
    alter -= 1;
  }

  return alter;
}

Teilnehmer erstelleTeilnehmer() {
  print('Füge Teilnehmer hinzu.');

  String? vorname;
  while (vorname == null || vorname.trim().isEmpty) {
    stdout.write('Vorname: ');
    vorname = stdin.readLineSync();
  }

  String? nachname;
  while (nachname == null || nachname.trim().isEmpty) {
    stdout.write('Nachname: ');
    nachname = stdin.readLineSync();
  }

  String? geschlecht;
  stdout.write('Geschlecht: ');
  geschlecht = stdin.readLineSync();
  geschlecht = geschlecht?.trim().toLowerCase();

  while (geschlecht != 'w' && geschlecht != 'm' && geschlecht != 'd') {
    print('Gültige Eingaben: (w), (m), (d).');
    stdout.write('Geschlecht: ');
    geschlecht = stdin.readLineSync();
    geschlecht = geschlecht?.trim().toLowerCase();
  }

  final geschlechtEnum = switch (geschlecht) {
    'w' => Geschlecht.w,
    'm' => Geschlecht.m,
    'd' => Geschlecht.d,
    _ => throw StateError('Ungültiger Wert für Geschlecht'),
  };

  DateTime geburtsdatum;
  while (true) {
    stdout.write('Geburtsdatum (TT.MM.JJJJ): ');
    final eingabe = stdin.readLineSync();

    if (eingabe == null || eingabe.trim().isEmpty) {
      print('Bitte ein gültiges Datum im Format TT.MM.JJJJ eingeben.');
      continue;
    }

    try {
      final teile = eingabe.trim().split('.');
      if (teile.length != 3) {
        throw const FormatException();
      }

      final tag = int.parse(teile[0]);
      final monat = int.parse(teile[1]);
      final jahr = int.parse(teile[2]);
      final pruefDatum = DateTime(jahr, monat, tag);

      if ((pruefDatum.year == jahr &&
              pruefDatum.month == monat &&
              pruefDatum.day == tag) &&
          pruefDatum.isBefore(DateTime.now())) {
        geburtsdatum = pruefDatum;
        break;
      }

      print('Bitte ein gültiges Datum im Format TT.MM.JJJJ eingeben.');
    } on FormatException {
      print('Bitte ein gültiges Datum im Format TT.MM.JJJJ eingeben.');
    }
  }

  return Teilnehmer(
    vorname: vorname.trim(),
    nachname: nachname.trim(),
    geschlecht: geschlechtEnum,
    geburtsdatum: geburtsdatum,
  );
}
