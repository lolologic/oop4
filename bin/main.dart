import 'dart:io';

import 'package:oop4/cdemy.dart';
import 'package:oop4/kurs.dart';
import 'package:oop4/teilnehmer.dart';

void main() {
  final cdemy = Cdemy();

  while (true) {
    print('Hauptmenü');
    print('1 - Kurse verwalten');
    print('2 - Teilnehmer verwalten');
    print('3 - Kurse anzeigen');
    print('4 - Teilnehmer anzeigen');
    print('0 - Beenden');
    print('');
    stdout.write('Auswahl: ');

    final menue = stdin.readLineSync()?.trim();
    print('');

    switch (menue) {
      case '1':
        while (true) {
          print('Kurse verwalten');
          print('1 - Kurs hinzufügen');
          print('2 - Kurs löschen');
          print('0 - Zurück zum Hauptmenü');
          print('');
          stdout.write('Auswahl: ');

          final kursMenue = stdin.readLineSync()?.trim();
          print('');

          if (kursMenue == '0') {
            break;
          }

          switch (kursMenue) {
            case '1':
              final kurs = erstelleKurs();
              cdemy.kursHinzufuegen(kurs);

            case '2':
              if (cdemy.kursListe.isEmpty) {
                print('Es sind keine Kurse vorhanden.');
                print('');
                break;
              }

              ausgabeKursListe(cdemy.kursListe);

              while (true) {
                stdout.write('Kursnummer zum Löschen (0 = zurück): ');

                final eingabe = stdin.readLineSync()?.trim();
                final kursNummer = int.tryParse(eingabe ?? '');
                print('');

                if (kursNummer == null) {
                  print('Ungültige Eingabe.');
                  continue;
                }

                if (kursNummer == 0) {
                  break;
                }

                if (kursNummer < 1 || kursNummer > cdemy.kursListe.length) {
                  print('Ungültige Kursnummer.');
                  continue;
                }

                final geloeschterKurs = cdemy.kursListe.removeAt(
                  kursNummer - 1,
                );

                print('Kurs "${geloeschterKurs.kursName}" wurde gelöscht.');
                print('');
                break;
              }

            default:
              print('Ungültige Eingabe.');
          }
        }

      case '2':
        while (true) {
          print('Teilnehmer verwalten');
          print('1 - Teilnehmer hinzufügen');
          print('2 - Teilnehmer löschen');
          print('0 - Zurück zum Hauptmenü');
          print('');
          stdout.write('Auswahl: ');

          final teilnehmerMenue = stdin.readLineSync()?.trim();
          print('');

          if (teilnehmerMenue == '0') {
            break;
          }

          switch (teilnehmerMenue) {
            case '1':
              if (cdemy.kursListe.isEmpty) {
                print('Kein Kurs vorhanden. Erstelle bitte zuerst einen Kurs.');
                print('');
                break;
              }

              Kurs? ausgewaehlterKurs;

              while (ausgewaehlterKurs == null) {
                print('Welchem Kurs sollen Teilnehmer hinzugefügt werden?');
                stdout.write('Gib eine Kursnummer ein (0 = zurück): ');

                final kursNummerEingabe = stdin.readLineSync()?.trim();
                final kursNummer = int.tryParse(kursNummerEingabe ?? '');
                print('');

                if (kursNummer == null) {
                  print('Ungültige Eingabe.');
                  continue;
                }

                if (kursNummer == 0) {
                  break;
                }

                if (kursNummer < 1 || kursNummer > cdemy.kursListe.length) {
                  print('Ungültige Kursnummer.');
                  continue;
                }

                ausgewaehlterKurs = cdemy.kursListe[kursNummer - 1];
              }

              if (ausgewaehlterKurs == null) {
                break;
              }

              while (true) {
                final teilnehmer = erstelleTeilnehmer();
                ausgewaehlterKurs.teilnehmerHinzufuegen(teilnehmer);

                String? auswahl;

                while (auswahl != '0' && auswahl != '1') {
                  print('1 - Weiteren Teilnehmer hinzufügen');
                  print('0 - Zurück');
                  print('');
                  stdout.write('Auswahl: ');

                  auswahl = stdin.readLineSync()?.trim();
                  print('');

                  if (auswahl != '0' && auswahl != '1') {
                    print('Ungültige Eingabe.');
                  }
                }

                if (auswahl == '0') {
                  break;
                }
              }

            case '2':
              if (cdemy.kursListe.isEmpty) {
                print('Kein Kurs vorhanden.');
                print('');
                break;
              }

              Kurs? ausgewaehlterKurs;

              while (ausgewaehlterKurs == null) {
                print('Aus welchem Kurs soll ein Teilnehmer gelöscht werden?');
                stdout.write('Gib eine Kursnummer ein (0 = zurück): ');

                final kursNummerEingabe = stdin.readLineSync()?.trim();
                final kursNummer = int.tryParse(kursNummerEingabe ?? '');
                print('');

                if (kursNummer == null) {
                  print('Ungültige Eingabe.');
                  continue;
                }

                if (kursNummer == 0) {
                  break;
                }

                if (kursNummer < 1 || kursNummer > cdemy.kursListe.length) {
                  print('Ungültige Kursnummer.');
                  continue;
                }

                ausgewaehlterKurs = cdemy.kursListe[kursNummer - 1];
              }

              if (ausgewaehlterKurs == null) {
                break;
              }

              if (ausgewaehlterKurs.teilnehmerListe.isEmpty) {
                print('Keine Teilnehmer in diesem Kurs vorhanden.');
                print('');
                break;
              }

              for (
                int i = 0;
                i < ausgewaehlterKurs.teilnehmerListe.length;
                i++
              ) {
                final teilnehmer = ausgewaehlterKurs.teilnehmerListe[i];

                print(
                  '${i + 1} - ${teilnehmer.vorname} ${teilnehmer.nachname}',
                );
              }

              print('');

              while (true) {
                stdout.write('Teilnehmernummer zum Löschen (0 = zurück): ');

                final eingabe = stdin.readLineSync()?.trim();
                final teilnehmerNummer = int.tryParse(eingabe ?? '');
                print('');

                if (teilnehmerNummer == null) {
                  print('Ungültige Eingabe.');
                  continue;
                }

                if (teilnehmerNummer == 0) {
                  break;
                }

                if (teilnehmerNummer < 1 ||
                    teilnehmerNummer >
                        ausgewaehlterKurs.teilnehmerListe.length) {
                  print('Ungültige Teilnehmernummer.');
                  continue;
                }

                final geloeschterTeilnehmer = ausgewaehlterKurs.teilnehmerListe
                    .removeAt(teilnehmerNummer - 1);

                print(
                  '${geloeschterTeilnehmer.vorname} ${geloeschterTeilnehmer.nachname} wurde gelöscht.',
                );
                print('');
                break;
              }

            default:
              print('Ungültige Eingabe.');
          }
        }

      case '3':
        if (cdemy.kursListe.isEmpty) {
          print('Es sind noch keine Kurse vorhanden.');
          print('');
          break;
        }

        ausgabeKursListe(cdemy.kursListe);

      case '4':
        if (cdemy.kursListe.isEmpty) {
          print('Kein Kurs vorhanden.');
          print('');
          break;
        }

        Kurs? ausgewaehlterKurs;

        while (ausgewaehlterKurs == null) {
          print('Von welchem Kurs sollen die Teilnehmer angezeigt werden?');
          stdout.write('Gib eine Kursnummer ein (0 = zurück): ');

          final kursNummerEingabe = stdin.readLineSync()?.trim();
          final kursNummer = int.tryParse(kursNummerEingabe ?? '');
          print('');

          if (kursNummer == null) {
            print('Ungültige Eingabe.');
            continue;
          }

          if (kursNummer == 0) {
            break;
          }

          if (kursNummer < 1 || kursNummer > cdemy.kursListe.length) {
            print('Ungültige Kursnummer.');
            continue;
          }

          ausgewaehlterKurs = cdemy.kursListe[kursNummer - 1];
        }

        if (ausgewaehlterKurs == null) {
          break;
        }

        ausgabeTeilnehmerListe(ausgewaehlterKurs.teilnehmerListe);

      case '0':
        return;

      default:
        print('Ungültige Eingabe.');
        print('');
    }
  }
}

void ausgabeKursListe(List<Kurs> kursListe) {
  for (int i = 0; i < kursListe.length; i++) {
    print('Kursname: ${i + 1} - ${kursListe[i].kursName}');
    print('Kursdauer: ${kursListe[i].kursDauerMonate} Monate');
    print('Teilnehmeranzahl: ${kursListe[i].teilnehmerListe.length}');
    print('');
  }
}

void ausgabeTeilnehmerListe(List<Teilnehmer> teilnehmer) {
  if (teilnehmer.isEmpty) {
    print('Keine Teilnehmer in diesem Kurs vorhanden.');
    print('');
    return;
  }

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
