import 'teilnehmer.dart';

enum KursArt {
  fiae,
  fisi
}

class Kurs {
  KursArt kursArt;
  DateTime startTermin;
  int kursDauerMonate;
  List<Teilnehmer> teilnehmerListe = <Teilnehmer>[];

  Kurs({required this.kursArt, required this.startTermin, required this.kursDauerMonate});

  void teilnehmerHinzufuegen(Teilnehmer teilnehmer) {
    teilnehmerListe.add(teilnehmer);
  }
}