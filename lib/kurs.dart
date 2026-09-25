import 'teilnehmer.dart';

enum KursArt { fiae, fisi }

class Kurs {
  KursArt kursArt;
  DateTime startTermin;
  int kursDauerMonate;
  List<Teilnehmer> teilnehmerListe = <Teilnehmer>[];

  Kurs({
    required this.kursArt,
    required this.startTermin,
    required this.kursDauerMonate,
  });

  void teilnehmerHinzufuegen(Teilnehmer teilnehmer) {
    teilnehmerListe.add(teilnehmer);
  }

  String get kursName {
    final kursArtEnum = switch (kursArt) {
      KursArt.fiae => 'FIAE',
      KursArt.fisi => 'FISI',
    };

    return '$kursArtEnum - ${startTermin.day.toString().padLeft(2, '0')}.${startTermin.month.toString().padLeft(2, '0')}.${startTermin.year}';
  }
}
