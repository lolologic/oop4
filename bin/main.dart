import 'dart:io';

import 'package:oop4/cdemy.dart';
import 'package:oop4/kurs.dart';
import 'package:oop4/teilnehmer.dart';

void main() {
  final cdemy = Cdemy();

  while (true) {
    String? menue;

    print('Hauptmenü');
    print('1 - Kurs hinzufügen');
    print('2 - Teilnehmer hinzufügen');
    print('3 - Kurse anzeigen');
    print('4 - Teilnehmer anzeigen');
    print('0 - Beenden');
    print('');
    stdout.write('Auswahl: ');
    menue = stdin.readLineSync();

    switch (menue) {
      case '1':
        while (true) {
          menue = null;
          final kurs = erstelleKurs();
          cdemy.kursHinzufuegen(kurs);

          while (menue != '0' && menue != '1') {
            print('');
            print('1 - Weiteren Kurs hinzufügen');
            print('0 - Zurück zum Hauptmenü');
            stdout.write('Auswahl: ');
            menue = stdin.readLineSync();

            if (menue != null) {
              menue = menue.trim();
            }

            if (menue == '0') {
              break;
            } else if (menue == '1') {
              break;
            } else {
              print('Ungültige Eingabe.');
              continue;
            }
          }

          if (menue == '0') {
            break;
          }
        }
      case '2':
        while (true) {
          menue = null;
          final teilnehmer = erstelleTeilnehmer();

          kurs.teilnehmerHinzufuegen(teilnehmer);

          while (menue != '0' && menue != '1') {
            print('');
            print('1 - Weiteren Teilnehmer hinzufügen');
            print('0 - Zurück zum Hauptmenü');
            stdout.write('Auswahl: ');
            menue = stdin.readLineSync();

            if (menue != null) {
              menue = menue.trim();
            }

            if (menue == '0') {
              break;
            } else if (menue == '1') {
              break;
            } else {
              print('Ungültige Eingabe.');
              continue;
            }
          }

          if (menue == '0') {
            break;
          }
        }
      case '3':
        ausgabeKursListe(cdemy.kursListe);
      case '4':
        ausgabeTeilnehmerListe(kurs.teilnehmerListe);
      case '0':
        break;
      default:
        print('Ungültige Eingabe.');
    }
  }
}

void ausgabeKursListe(List<Kurs> kursListe) {
  for (int i = 0; i < kursListe.length; i++) {
    print('Kursname: ${kursListe[i].kursName}');
    print('Kursdauer: ${kursListe[i].kursDauerMonate} Monate');
    print('Teilnehmeranzahl: ${kursListe[i].teilnehmerListe.length}');
    print('');
  }
}

void ausgabeTeilnehmerListe(List<Teilnehmer> teilnehmer) {
  for (int i = 0; i < teilnehmer.length; i++) {
    print('Vorname: ${teilnehmer[i].vorname}');
    print('Nachname: ${teilnehmer[i].nachname}');

    final geschlecht = switch (teilnehmer[i].geschlecht) {
      Geschlecht.w => 'weiblich',
      Geschlecht.m => 'männlich',
      Geschlecht.d => 'divers',
    };
    print('Geschlecht: $geschlecht');

    final geburtsdatum = teilnehmer[i].geburtsdatum;
    print(
      'Geburtsdatum: ${geburtsdatum.day.toString().padLeft(2, '0')}.${geburtsdatum.month.toString().padLeft(2, '0')}.${geburtsdatum.year}',
    );
    print('Alter: ${berechneAlter(teilnehmer[i])}');

    if (teilnehmer[i].abschlussnote != null) {
      print('Abschlussnote: ${teilnehmer[i].abschlussnote}');
    }
    print(
      'Zutritts-ID: ${teilnehmer[i].zutrittsberechtigung.zutrittsberechtigungsId}',
    );
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
  final regex = RegExp(
    r"^\p{L}+(['-]?\p{L}+)*( \p{L}+(['-]?\p{L}+)*)*$",
    unicode: true,
  );

  String? vorname;
  while (vorname == null ||
      vorname.trim().isEmpty ||
      !regex.hasMatch(vorname.trim())) {
    stdout.write('Vorname: ');
    vorname = stdin.readLineSync();

    if (vorname != null && !regex.hasMatch(vorname.trim())) {
      print(
        'Ungültiger Name. Erlaubt sind Buchstaben, Leerzeichen, Bindestriche und Apostrophe.',
      );
    }
  }

  String? nachname;
  while (nachname == null ||
      nachname.trim().isEmpty ||
      !regex.hasMatch(nachname.trim())) {
    stdout.write('Nachname: ');
    nachname = stdin.readLineSync();

    if (nachname != null && !regex.hasMatch(nachname.trim())) {
      print(
        'Ungültiger Name. Erlaubt sind Buchstaben, Leerzeichen, Bindestriche und Apostrophe.',
      );
    }
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
    final geburtsdatumEingabe = stdin.readLineSync();

    if (geburtsdatumEingabe == null || geburtsdatumEingabe.trim().isEmpty) {
      print('Bitte ein gültiges Datum im Format TT.MM.JJJJ eingeben.');
      continue;
    }

    try {
      final teile = geburtsdatumEingabe.trim().split('.');
      if (teile.length != 3) {
        throw const FormatException();
      }

      final tag = int.parse(teile[0]);
      final monat = int.parse(teile[1]);
      final jahr = int.parse(teile[2]);
      final pruefDatum = DateTime(jahr, monat, tag);

      if (pruefDatum.year == jahr &&
          pruefDatum.month == monat &&
          pruefDatum.day == tag) {
        if (pruefDatum.isAfter(DateTime.now())) {
          print('Das Geburtsdatum darf nicht in der Zukunft liegen.');
          continue;
        } else {
          geburtsdatum = pruefDatum;
          break;
        }
      }

      print('Bitte ein gültiges Datum im Format TT.MM.JJJJ eingeben.');
    } on FormatException {
      print('Bitte ein gültiges Datum im Format TT.MM.JJJJ eingeben.');
    }
  }

  print('');

  return Teilnehmer(
    vorname: vorname.trim(),
    nachname: nachname.trim(),
    geschlecht: geschlechtEnum,
    geburtsdatum: geburtsdatum,
  );
}

Kurs erstelleKurs() {
  print('Füge Kurs hinzu.');

  String? kursArt;
  while (true) {
    print('Gültige Eingaben: (fiae), (fisi).');
    stdout.write('KursArt: ');
    kursArt = stdin.readLineSync()?.trim().toLowerCase();

    if (kursArt == 'fiae' || kursArt == 'fisi') {
      break;
    }

    print('Bitte eine gültige Kursart eingeben.');
  }

  final kursArtEnum = switch (kursArt) {
    'fiae' => KursArt.fiae,
    'fisi' => KursArt.fisi,
    _ => throw StateError('Ungültiger Wert für KursArt'),
  };

  DateTime startTermin;
  while (true) {
    stdout.write('Starttermin (TT.MM.JJJJ): ');
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

      if (pruefDatum.year == jahr &&
          pruefDatum.month == monat &&
          pruefDatum.day == tag) {
        startTermin = pruefDatum;
        break;
      }

      print('Bitte ein gültiges Datum im Format TT.MM.JJJJ eingeben.');
    } on FormatException {
      print('Bitte ein gültiges Datum im Format TT.MM.JJJJ eingeben.');
    }
  }

  int kursDauerMonate;
  while (true) {
    stdout.write('Kursdauer in Monaten: ');
    final eingabe = stdin.readLineSync();

    if (eingabe == null || eingabe.trim().isEmpty) {
      print('Bitte eine gültige Dauer in Monaten eingeben.');
      continue;
    }

    try {
      final dauer = int.parse(eingabe.trim());
      if (dauer > 0) {
        kursDauerMonate = dauer;
        break;
      }
      print('Bitte eine Zahl größer als 0 eingeben.');
    } on FormatException {
      print('Bitte eine gültige Zahl eingeben.');
    }
  }

  print('');

  return Kurs(
    kursArt: kursArtEnum,
    startTermin: startTermin,
    kursDauerMonate: kursDauerMonate,
  );
}
