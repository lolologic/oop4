import 'teilnehmer.dart';

/// Represents the type of a course.
enum KursArt {
  /// Application development.
  fiae,

  /// System integration.
  fisi,
}

/// Represents a course with its type, start date, duration, and participants.
class Kurs {
  /// The type of the course.
  KursArt kursArt;

  /// The start date of the course.
  DateTime startTermin;

  /// The duration of the course in months.
  int kursDauerMonate;

  /// The participants enrolled in the course.
  List<Teilnehmer> teilnehmerListe = <Teilnehmer>[];

  /// Creates a course with the provided type, start date, and duration.
  Kurs({
    required this.kursArt,
    required this.startTermin,
    required this.kursDauerMonate,
  });

  /// Adds [teilnehmer] to the participant list.
  void teilnehmerHinzufuegen(Teilnehmer teilnehmer) {
    teilnehmerListe.add(teilnehmer);
  }

  /// Returns the course type and start date as a formatted course name.
  String get kursName {
    final kursArtEnum = switch (kursArt) {
      KursArt.fiae => 'FIAE',
      KursArt.fisi => 'FISI',
    };

    return '$kursArtEnum - ${startTermin.day.toString().padLeft(2, '0')}.${startTermin.month.toString().padLeft(2, '0')}.${startTermin.year}';
  }
}
