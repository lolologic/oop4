import 'kurs.dart';

/// Represents the Cdemy course administration.
class Cdemy {
  /// The courses managed by Cdemy.
  List<Kurs> kursListe = <Kurs>[];

  /// Adds [kurs] to the course list.
  void kursHinzufuegen(Kurs kurs) {
    kursListe.add(kurs);
  }
}
