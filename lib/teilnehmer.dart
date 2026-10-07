import 'dart:math';

/// Represents the gender of a participant.
enum Geschlecht {
  /// Female.
  w,

  /// Male.
  m,

  /// Diverse.
  d,
}

/// Represents a participant and their personal data.
class Teilnehmer {
  /// The participant's first name.
  String vorname;

  /// The participant's last name.
  String nachname;

  /// The participant's gender.
  Geschlecht geschlecht;

  /// The participant's date of birth.
  DateTime geburtsdatum;

  /// The participant's final grade, or `null` if no grade is available.
  int? abschlussnote;

  /// The participant's access authorization.
  Zutrittsberechtigung zutrittsberechtigung;

  /// Creates a participant with the provided personal data.
  ///
  /// A new [Zutrittsberechtigung] is created automatically.
  Teilnehmer({
    required this.vorname,
    required this.nachname,
    required this.geschlecht,
    required this.geburtsdatum,
    this.abschlussnote,
  }) : zutrittsberechtigung = Zutrittsberechtigung();
}

/// Represents an access authorization assigned to a participant.
class Zutrittsberechtigung {
  /// The unique identifier of the access authorization.
  int zutrittsberechtigungsId;

  /// Creates an access authorization with a randomly generated identifier.
  Zutrittsberechtigung()
    : zutrittsberechtigungsId = Random().nextInt(999999999);
}
