import 'competence.dart';

class Posseder {
  final int? id;
  final String? nbrRecommande;
  final Competence? competence;

  const Posseder({
    this.id,
    this.nbrRecommande,
    this.competence,
  });
/*
  factory Posseder.fromJSON(Map json) {
    return;
  }
*/
}
